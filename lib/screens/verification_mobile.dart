import 'package:easy_localization/easy_localization.dart';
import '../constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import '../constants/welcome_button.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import '../user/reset_password.dart';

class ForgetVerificationScreen extends StatefulWidget {
  final String mobile;

  static String routeName = '/verification';

  const ForgetVerificationScreen({Key key, this.mobile}) : super(key: key);

  @override
  _ForgetVerificationScreenState createState() =>
      _ForgetVerificationScreenState();
}

class _ForgetVerificationScreenState extends State<ForgetVerificationScreen> {
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: kPrimaryColor,
    ),
  );

  @override
  void initState() {
    verifyPhoneNumber(widget.mobile);
    print('verification');
    super.initState();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print('verification');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF5FFFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 30,
                        )),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: SizeConfig.screenHeight * .45,
                  child: Image.asset(
                    'assets/images/otp.png',
                    color: kPrimaryColor,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  tr('confirm_mobile_number'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                PinPut(
                  fieldsCount: 6,
                  textStyle:
                      const TextStyle(fontSize: 25.0, color: Colors.black),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    try {
                      // await FirebaseAuth.instance
                      //     .signInWithCredential(PhoneAuthProvider.credential(
                      //         verificationId: _verificationCode, smsCode: pin))
                      //     .then((value) async {
                      //   print("before");
                      //   if (value.user != null) {
                      //     print("after");
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) => ResetPassword(
                      //           phone: widget.mobile,
                      //         ),
                      //       ),
                      //     );
                      //     print("after after");
                      //   }
                      // });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('invalid OTP')));
                    }
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  tr("enter_confirmation_code"),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(tr("exist_in_messages"),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: getProportionateScreenHeight(20)),
                WelcomeButton(
                    onPress: () async {
                      print("before");
                      print(_pinPutController.text);
                      if (_pinPutController.text == _verificationCode) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResetPassword(
                                      phone: widget.mobile,
                                    )));
                      }
                    },
                    textColor: Colors.white,
                    decoration: BoxDecoration(
                      color: Color(0xFF333333),
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(50)),
                    ),
                    title: tr("continue_button"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyPhoneNumber(String mobileNumber) async {
    print('verifying ... ');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+20$mobileNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => ResetPassword(
                          phone: widget.mobile,
                        )));
            
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print(e.message);
      },
      codeSent: (String verficationID, int resendToken) {
        setState(() {
          _verificationCode = verficationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      timeout: Duration(seconds: 120),
    );
  }
}
