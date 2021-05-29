import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import '../constants/form_design.dart';
import '../store/congrats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessfullRegister extends StatefulWidget {
  static String routeName = '/succcessfulRegister';

  @override
  _SuccessfullRegisterState createState() => _SuccessfullRegisterState();
}

class _SuccessfullRegisterState extends State<SuccessfullRegister> {
  Duration duration = Duration(seconds: 5);
  startTimer() async {
    Duration(seconds: 5);
    return Timer(duration, navigateToNextScreen);
  }

  navigateToNextScreen() {
    Navigator.pushNamed(context, Congrats.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormDesign(
        accountType: tr("create_store_account"),
        needHeader: false,
        child: SuccessfullContent(),
      ),
    );
  }
}

class SuccessfullContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          tr("register_done"),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          tr("activation_waiting"),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Congrats.routeName),
          child: SvgPicture.asset(
            'assets/icons/new-product.svg',
            color: Colors.yellow[600],
          ),
        ),
        // WelcomeButton(
        //     onPress: () {
        //       Navigator.pushNamed(context, HomeScreen.routeName);
        //     },
        //     textColor: Colors.white,
        //     decoration: BoxDecoration(
        //       color: Color(0xFFFEC40D),
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     title: tr('goto_home')),
      ],
    );
  }
}
