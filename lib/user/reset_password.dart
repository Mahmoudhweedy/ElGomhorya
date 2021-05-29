import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/constants.dart';
import 'package:elgomhorya/constants/dialogue.dart';
import 'package:elgomhorya/constants/form_design.dart';
import 'package:elgomhorya/constants/form_error.dart';
import 'package:elgomhorya/constants/welcome_button.dart';
import 'package:elgomhorya/screens/login_screen.dart';
import 'package:elgomhorya/services/services.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class ResetPassword extends StatefulWidget {
  final String phone;
  static String routeName = 'reset_password';

  const ResetPassword({Key key, this.phone}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
    final _formKey = GlobalKey<FormState>();
  String confirmPassword, password;
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF5FFFA),
       body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FormDesign(
            child: Column(
              children: [
                Spacer(),
                buildPasswordField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConfirmPasswordField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: errors),
                Spacer(),
                WelcomeButton(
                  onPress: () async {
                    print(_formKey.currentState.validate());

                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (confirmPassword != null && password != null) {
                        DialogBuilder(context).showLoadingIndicator();
                      await Services().resetPassword(
                        mobile: widget.phone,
                        newPassword: password,
                      );
                      print('${widget.phone} $password');

                        DialogBuilder(context).hideOpenDialog();
                        Navigator.pushNamed(context, LoginScreen.routeName);

                     
                      }
                    }
                  },
                  textColor: Colors.white,
                  decoration: BoxDecoration(
                      color: Color(0xFFFEC40D),
                      borderRadius: BorderRadius.circular(50)),
                  title: tr("login_button"),
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
    TextFormField buildPasswordField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          removeError(kPassNullError);
          return "";
        } else if (value.length > 8 && errors.contains(kShortPassError)) {
          removeError(kShortPassError);
          return "";
        } else if (password == confirmPassword &&
            errors.contains(kMatchPassError)) {
          removeError(kMatchPassError);
        }
        password = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          addError(kPassNullError);
          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          addError(kShortPassError);
          return "";
        } else if (password != confirmPassword &&
            !errors.contains(kMatchPassError)) {
          addError(kMatchPassError);
          return '';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: tr("password"),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildConfirmPasswordField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(kPassNullError);
          return "";
        } else if (password != value) {
          addError(kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: tr("confirm_password"),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

