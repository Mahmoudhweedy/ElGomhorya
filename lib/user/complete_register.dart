import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/dialogue.dart';
import 'package:elgomhorya/constants/map_Screen.dart';
import 'package:elgomhorya/screens/login_screen.dart';
import 'package:elgomhorya/screens/terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/form_error.dart';
import '../models/user.dart';
import '../services/services.dart';
import '../constants/welcome_button.dart';
import '../user/verification_mobile.dart';
import '../constants/constants.dart';

import '../constants/form_design.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';

class CompleteRegister extends StatefulWidget {
  static String routeName = '/complete_register';
  @override
  _CompleteRegisterState createState() => _CompleteRegisterState();
}

class _CompleteRegisterState extends State<CompleteRegister> {
  final _formKey = GlobalKey<FormState>();
  String fName, lName, userName, phone, password;
  String location = " ";
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool remember = false;
  String confirmPassword;
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

  bool approved = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF5FFFA),
      body: SingleChildScrollView(
        child: FormDesign(
          accountType: tr("create_user_account"),
          iconAsset: 'assets/icons/store.svg',
          needHeader: true,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildFNameField(),
                  buildLNameField(),
                  buildUserNameField(),
                  buildPhoneField(),
                  buildAddressField(),
                  buildPasswordField(),
                  buildConfirmPasswordField(),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Color(0xFFfec40d),
                          value: approved,
                          onChanged: (newValue) {
                            print(approved);
                            setState(() {
                              approved = newValue;
                            });
                            print(approved);
                          }),
                      SizedBox(width: getProportionateScreenWidth(10)),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, Terms.routeName),
                        child: Container(
                          width: 195,
                          child: Text(
                            tr("terms_and_conditions_approve"),
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  WelcomeButton(
                      onPress: () async {
                        if (_formKey.currentState.validate() &&
                            approved == true) {
                          removeError(tr("approve_terms"));
                          DialogBuilder(context).showLoadingIndicator();
                          _formKey.currentState.save();
                          Guser user = Guser(
                            firstName: fName,
                            lastName: lName,
                            userName: userName,
                            mobileNumber: phone,
                            password: password,
                            address: location,
                          );
                          int res = await Services().customerRegister(user);
                          print(
                              "${user.firstName} ${user.lastName} ${user.userName} ${user.mobileNumber} ${user.address}");
                          DialogBuilder(context).hideOpenDialog();
                          if (res == 2) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Center(
                                      child: Text(
                                    tr("re_register"),
                                    style: TextStyle(color: kPrimaryColor),
                                  )),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(tr("make_sure_phone")),
                                      Text(tr("or")),
                                      InkWell(
                                        onTap: () => Navigator.pushNamed(
                                            context, LoginScreen.routeName),
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
                                            tr("try_to_login"),
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
                          } else if (res == 1) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("type", 'user');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VerificationScreen(
                                  mobile: phone,
                                ),
                              ),
                            );
                          }
                        } else if (approved == false) {
                          addError(tr("approve_terms"));
                        }
                      },
                      textColor: Colors.white,
                      decoration: BoxDecoration(
                          color: Color(0xFFB51F32),
                          borderRadius: BorderRadius.circular(50)),
                      title: tr("create_new_account")),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildFNameField() {
    return TextFormField(
      onSaved: (newValue) => fName = newValue,
      onChanged: (value) {
        print(value);
        if (value.isNotEmpty && errors.contains(kFNamelNullError)) {
          removeError(kFNamelNullError);
          return '';
        }
        //  else if (emailValidatorRegExp.hasMatch(value) &&
        //     errors.contains(kInvalidEmailError)) {
        //   removeError(kInvalidEmailError);
        //   return '';
        // }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kFNamelNullError)) {
          addError(kFNamelNullError);
          return '';
        }
        // else if (!emailValidatorRegExp.hasMatch(value) &&
        //     !errors.contains(kInvalidEmailError)) {
        //   addError(kInvalidEmailError);
        //   return '';
        // }
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: tr("first_name"),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildLNameField() {
    return TextFormField(
      onSaved: (newValue) => lName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kFNamelNullError)) {
          removeError(kFNamelNullError);
          return '';
        }
        //  else if (emailValidatorRegExp.hasMatch(value) &&
        //     errors.contains(kInvalidEmailError)) {
        //   removeError(kInvalidEmailError);
        //   return '';
        // }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kFNamelNullError)) {
          addError(kFNamelNullError);
          return '';
        }
        // else if (!emailValidatorRegExp.hasMatch(value) &&
        //     !errors.contains(kInvalidEmailError)) {
        //   addError(kInvalidEmailError);
        //   return '';
        // }
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: tr("last_name"),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildUserNameField() {
    return TextFormField(
      onSaved: (newValue) => userName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kFNamelNullError)) {
          removeError(kFNamelNullError);
          return '';
        } else if (userNameValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          removeError(kInvalidEmailError);
          return '';
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kFNamelNullError)) {
          addError(kFNamelNullError);
          return '';
        } else if (!userNameValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          addError(kInvalidEmailError);
          return '';
        }
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: tr("user_name"),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
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
        //  else if (emailValidatorRegExp.hasMatch(value) &&
        //     errors.contains(kInvalidEmailError)) {
        //   removeError(kInvalidEmailError);
        //   return '';
        // }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPhoneNumberNullError)) {
          addError(kPhoneNumberNullError);
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

  TextFormField buildAddressField() {
    return TextFormField(
      controller: controller,
      // initialValue: location,
      onSaved: (newValue) => location = newValue,
      onChanged: (value) {
        print(value);
        if (value.isNotEmpty && errors.contains(kaddressNullError)) {
          removeError(kaddressNullError);
          return '';
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kaddressNullError)) {
          addError(kaddressNullError);
          return '';
        }

        return null;
      },
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        hintText: location,
        suffixIcon: GestureDetector(
            onTap: () async {
              location = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapScreen(),
                  ));

              print('lOC $location');
              controller.text = location;
            },
            child: Icon(
              Icons.pin_drop_outlined,
              size: 30,
            )),
        labelText: tr("address"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
      ),
    );
  }

  TextFormField builduserNameField() {
    return TextFormField(
      onSaved: (newValue) => userName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kUserNameNullError)) {
          removeError(kUserNameNullError);
          return '';
        } else if (userNameValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidUserNameError)) {
          removeError(kInvalidUserNameError);
          return '';
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kUserNameNullError)) {
          addError(kUserNameNullError);
          return '';
        } else if (!userNameValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidUserNameError)) {
          addError(kInvalidUserNameError);
          return '';
        }
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: tr("last_name"),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
        hintText: tr("enter_lname"),
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

// if (oldMobile == phone){
//   showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Center(
//               child: Text(
//             tr("re_register"),
//             style: TextStyle(color: kPrimaryColor),
//           )),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(tr("make_sure_phone")),
//               Text(tr("or")),
//               InkWell(
//                 onTap: () => Navigator.pushNamed(
//                     context,
//                     LoginScreen.routeName),
//                 child: Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: 25, vertical: 15),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: kPrimaryColor,
//                     borderRadius:
//                         BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     tr("try_to_login"),
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
// }
