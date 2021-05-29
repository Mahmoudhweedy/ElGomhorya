import 'package:easy_localization/easy_localization.dart';
import '../constants/form_design.dart';
import '../constants/welcome_button.dart';
import '../size_config.dart';
import '../user/verification_mobile.dart';
import 'package:flutter/material.dart';

class CreateUserAccount extends StatelessWidget {
  static String routeName = '/create_user_account';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5FFFA),
      body: SingleChildScrollView(
        child: FormDesign(
          accountType: tr('create_user_account'),
          iconAsset: 'assets/icons/man.svg',
          needHeader: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: tr("mobile_number"),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              Row(
                children: [
                  Icon(Icons.check_circle, size: 20),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Text(
                    tr("terms_and_conditions_approve"),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              WelcomeButton(
                onPress: () =>
                    Navigator.pushNamed(context, VerificationScreen.routeName),
                textColor: Colors.black,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(50),
                ),
                title: tr("next"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
