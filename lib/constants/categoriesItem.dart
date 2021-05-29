import 'package:flutter/material.dart';
import '../size_config.dart';

class CategoriesItem extends StatelessWidget {
  final String categoryName;
  final Widget picture;
  final Function navigateTo;

  CategoriesItem({
    this.categoryName,
    @required this.picture,
    @required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateTo,
      child: Container(
        margin: EdgeInsets.all(10),
        height: getProportionateScreenHeight(160),
        width: MediaQuery.of(context).size.width * .42,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 5,
                color: Colors.black26,
                offset: Offset(0, 2),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            picture,
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
