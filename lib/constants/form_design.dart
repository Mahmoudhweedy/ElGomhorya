import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class FormDesign extends StatelessWidget {
  final Widget child;
  final bool needHeader;
  final String iconAsset;
  final String accountType;
  const FormDesign({
    Key key,
    @required this.child,
    @required this.needHeader,
    this.iconAsset,
    @required this.accountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
            width: SizeConfig.screenWidth, height: SizeConfig.screenHeight),
        Container(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(50),
            right: getProportionateScreenWidth(20),
            left: getProportionateScreenWidth(20),
          ),
          width: double.infinity,
          height: SizeConfig.screenHeight * .45,
          decoration: BoxDecoration(
            color: Color(0xFFFEC40D),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 30,
                  )),
              SizedBox(width: getProportionateScreenWidth(35)),
              Column(
                children: [
                  iconAsset == null
                      ? Text('')
                      : SvgPicture.asset(
                          iconAsset,
                          width: getProportionateScreenWidth(50),
                          height: getProportionateScreenHeight(50),
                        ),
                  needHeader
                      ? Text(
                          accountType,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        )
                      : Text(""),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: getProportionateScreenHeight(15),
          child: Center(
            child: Container(
              width: SizeConfig.screenWidth * .8,
              height: SizeConfig.screenHeight * .8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
