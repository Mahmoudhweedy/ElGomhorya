import 'package:flutter/material.dart';

import '../size_config.dart';

class LogoContainer extends StatelessWidget {
  final String pictureAsset;
  const LogoContainer({
    Key key,
    @required this.pictureAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(250),
      height: getProportionateScreenHeight(250),
      child: Image.asset(pictureAsset),
    );
  }
}
