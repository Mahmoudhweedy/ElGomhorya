import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/constants.dart';
import 'package:elgomhorya/constants/dialogue.dart';
import 'package:elgomhorya/constants/form_design.dart';
import 'package:elgomhorya/constants/form_error.dart';
import 'package:elgomhorya/constants/welcome_button.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';
import '../screens/verification_mobile.dart';

class ForgetPassword extends StatefulWidget {
  static String routeName = '/forget';
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  String phone;
  final List<String> errors = [];

  void addError(String error) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError(String error) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FormDesign(
            child: Column(
              children: [
                Spacer(),
                buildPhoneField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: errors),
                Spacer(),
                WelcomeButton(
                  onPress: () async {
                    print(_formKey.currentState.validate());

                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      if (phone != null) {
                        DialogBuilder(context).showLoadingIndicator();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("s_name", "forget");
                        DialogBuilder(context).hideOpenDialog();
                        print('veri$phone');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ForgetVerificationScreen(
                                      mobile: phone,
                                    )));
                      }
                    }
                  },
                  textColor: Colors.white,
                  decoration: BoxDecoration(
                      color: Color(0xFFFEC40D),
                      borderRadius: BorderRadius.circular(50)),
                  title: tr("verify"),
                ),
                Spacer(),
              ],
            ),
            needHeader: false,
            accountType: tr("login_button"),
          ),
        ),
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPhoneNumberNullError)) {
          removeError(kPhoneNumberNullError);
          return '';
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kPhoneNumberNullError)) {
            addError(kPhoneNumberNullError);
          }

          return '';
        } else if (value.length != 11) {
          if (!errors.contains(kPhoneNumberInvalidError)) {
            addError(kPhoneNumberInvalidError);
          }

          return '';
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: tr("mobile_number"),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
