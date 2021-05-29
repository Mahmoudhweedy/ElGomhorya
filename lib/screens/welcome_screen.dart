import '../screens/sign_choice.dart';
import '../constants/logo_container.dart';
import '../constants/welcome_button.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = '/welcome';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(),
              LogoContainer(
                pictureAsset: "assets/images/logo.png",
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                tr("application_name"),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Text(
                tr("app_purpose"),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                tr("app_description"),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Almarai",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              WelcomeButton(
                textColor: Colors.black,
                title: tr("welcome_button_text"),
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(50),
                ),
                onPress: () async {
                  Navigator.pushNamed(context, SignChoice.routeName);
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
