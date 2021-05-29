import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/dialogue.dart';
import '../screens/terms.dart';
import '../store/store_type_picker.dart';
import '../constants/form_design.dart';
import '../constants/welcome_button.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../constants/form_error.dart';

class CreateStoreAccount extends StatefulWidget {
  static String routeName = '/create_store_account';

  @override
  _CreateStoreAccountState createState() => _CreateStoreAccountState();
}

class _CreateStoreAccountState extends State<CreateStoreAccount> {
  final _formKey = GlobalKey<FormState>();
  String fName,
      storeName,
      lName,
      userName,
      phone,
      password,
      email,
      government,
      region;

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
  String govern;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5FFFA),
      body: SingleChildScrollView(
        child: FormDesign(
          accountType: tr("create_store_account"),
          iconAsset: 'assets/icons/store.svg',
          needHeader: true,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20)),
              children: [
                buildFNameField(),
                buildLNameField(),
                buildUserNameField(),
                buildStoreNameField(),
                buildPhoneField(),
                buildEmailField(),
                Container(
                  height: 50,
                  child: DropdownButton<String>(
                      itemHeight: 100.0,
                      isExpanded: true,
                      value: govern,
                      items: governments.map((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: new Text(val),
                        );
                      }).toList(),
                      hint: Text('المحافظة'),
                      // : Text(unit),
                      onChanged: (newVal) {
                        setState(() {
                          govern = newVal;
                        });
                        print(govern);
                      }),
                ),
                buildRegionField(),
                buildPasswordField(),
                buildConfirmPasswordField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(30)),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Color(0xFFfec40d),
                        value: approved,
                        onChanged: (newValue) {
                          setState(() {
                            approved = newValue;
                          });
                          print(approved);
                        }),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, Terms.routeName),
                      child: GestureDetector(
                            onTap: ()=> Navigator.pushNamed(context, Terms.routeName),
                                                      child: Text(
                              tr("terms_and_conditions_approve"),
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                    )
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                WelcomeButton(
                    onPress: () {
                      print(_formKey.currentState.validate());

                      if (_formKey.currentState.validate() &&
                          approved == true) {
                        removeError(tr("approve_terms"));
                        DialogBuilder(context).showLoadingIndicator();
                        _formKey.currentState.save();
                        DialogBuilder(context).hideOpenDialog();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => StoreTypePicker(
                                      email: email,
                                      fName: fName,
                                      government: government,
                                      lName: lName,
                                      password: password,
                                      phone: phone,
                                      region: region,
                                      storeName: storeName,
                                      userName: userName,
                                    )));
                      } else if (approved == false) {
                        addError(tr("approve_terms"));
                      }
                    },
                    textColor: Colors.white,
                    decoration: BoxDecoration(
                        color: Color(0xFFB51F32),
                        borderRadius: BorderRadius.circular(50)),
                    title: tr("create_new_account")),
              ],
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
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kFNamelNullError)) {
            addError(kFNamelNullError);
          }
          return '';
        }
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
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kFNamelNullError)) {
            addError(kFNamelNullError);
          }

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
        if (value.isEmpty) {
          if (!errors.contains(kFNamelNullError)) {
            addError(kFNamelNullError);
          }

          return '';
        } else if (!userNameValidatorRegExp.hasMatch(value)) {
          if (!errors.contains(kInvalidEmailError)) {
            addError(kInvalidEmailError);
          }

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

  TextFormField buildStoreNameField() {
    return TextFormField(
      onSaved: (newValue) => storeName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kStoreNameNullError)) {
          removeError(kStoreNameNullError);
          return '';
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kStoreNameNullError)) {
            addError(kStoreNameNullError);
          }

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
        labelText: tr("store_name"),
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

  TextFormField buildEmailField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          removeError(kEmailNullError);
          return '';
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          removeError(kInvalidEmailError);
          return '';
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kEmailNullError)) {
            addError(kEmailNullError);
          }

          return '';
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          if (!errors.contains(kInvalidEmailError)) {
            addError(kInvalidEmailError);
          }

          return '';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: tr('email_address'),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
      ),
    );
  }

  TextFormField buildGovernmentField() {
    return TextFormField(
      onSaved: (newValue) => government = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          removeError(kEmailNullError);
          return '';
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          removeError(kInvalidEmailError);
          return '';
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kEmailNullError)) {
            addError(kEmailNullError);
          }

          return '';
        }

        return null;
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: tr('government'),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
        ),
      ),
    );
  }

  TextFormField buildRegionField() {
    return TextFormField(
      onSaved: (newValue) => region = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          removeError(kEmailNullError);
        }
        return '';
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kEmailNullError)) {
            addError(kEmailNullError);
          }

          return '';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: tr('region'),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(18),
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
        if (value.isEmpty) {
          if (!errors.contains(kPassNullError)) {
            addError(kPassNullError);
          }

          return "";
        } else if (value.length < 8) {
          if (!errors.contains(kShortPassError)) {
            addError(kShortPassError);
          }

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
      ),
    );
  }
}
