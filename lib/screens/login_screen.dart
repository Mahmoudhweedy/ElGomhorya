import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/dialogue.dart';
import 'package:elgomhorya/user/complete_register.dart';
import '../constants/constants.dart';
import '../constants/form_design.dart';
import '../constants/form_error.dart';
import '../constants/welcome_button.dart';
import '../services/services.dart';
import '../user/home_screen.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String phone, password;
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
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF5FFFA),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FormDesign(
            child: Column(
              children: [
                Spacer(),
                buildPhoneField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: errors),
                Spacer(),
                WelcomeButton(
                  onPress: () async {
                    print(_formKey.currentState.validate());

                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print('$phone $password');
                      if (phone != null && password != null) {
                        DialogBuilder(context).showLoadingIndicator();
                        bool response = await Services()
                            .login(phone: phone, password: password);
                        // CartData().setInitItems(await Services().getCartData());
                        DialogBuilder(context).hideOpenDialog();
                        response
                            ? Navigator.pushNamedAndRemoveUntil(
                                context, HomeScreen.routeName, (route) => false)
                            : showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Center(
                                        child: Text(
                                      tr("unauthorized"),
                                      style: TextStyle(color: kPrimaryColor),
                                    )),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(tr("user_passowrd_wrong")),
                                        Text(tr("or")),
                                        InkWell(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              CompleteRegister.routeName),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 15),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              tr("register_need"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
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
        }
        password = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kPassNullError)) {
            addError(kPassNullError);
          }

          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          addError(kShortPassError);
          return "";
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
}
