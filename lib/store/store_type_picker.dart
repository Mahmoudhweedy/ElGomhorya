import 'package:easy_localization/easy_localization.dart';
import '../models/categories.dart';
import '../models/stores.dart';
import '../services/services.dart';
import '../user/verification_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../size_config.dart';

class StoreTypePicker extends StatelessWidget {
  static String routeName = '/store_type';
  final String fName,
      storeName,
      lName,
      userName,
      phone,
      password,
      email,
      government,
      region;

  const StoreTypePicker({
    Key key,
    this.fName,
    this.storeName,
    this.lName,
    this.userName,
    this.phone,
    this.password,
    this.email,
    this.government,
    this.region,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF7F6F0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight),
                Container(
                  padding: EdgeInsets.only(
                    right: getProportionateScreenWidth(20),
                    left: getProportionateScreenWidth(20),
                  ),
                  width: double.infinity,
                  height: SizeConfig.screenHeight * .31,
                  decoration: BoxDecoration(
                    color: Color(0xFFFEC40D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: getProportionateScreenHeight(60)),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 30,
                                ),
                              )),
                          SvgPicture.asset(
                            'assets/icons/homeIcon.svg',
                            color: Colors.white,
                            width: getProportionateScreenWidth(150),
                            height: getProportionateScreenHeight(150),
                          ),
                          SizedBox(width: getProportionateScreenWidth(50)),
                        ],
                      ),
                      Text(
                        tr('store_type'),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: getProportionateScreenHeight(220),
                  right: SizeConfig.screenWidth - 300,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          isDismissible: false,
                          bounce: true,
                          backgroundColor: Colors.white10,
                          context: context,
                          builder: (context) => StoreTypes(
                            email: email,
                            fName: fName,
                            government: government,
                            lName: lName,
                            password: password,
                            phone: phone,
                            region: region,
                            storeName: storeName,
                            userName: userName,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(10)),
                        width: getProportionateScreenWidth(200),
                        height: getProportionateScreenHeight(60),
                        decoration: BoxDecoration(
                            color: Color(0xFFFEC40D),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            )),
                        child: Text(
                          tr('pick_your_store_type'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StoreTypes extends StatefulWidget {
  final String fName,
      storeName,
      lName,
      userName,
      phone,
      password,
      email,
      government,
      region;
  const StoreTypes({
    Key key,
    this.fName,
    this.storeName,
    this.lName,
    this.userName,
    this.phone,
    this.password,
    this.email,
    this.government,
    this.region,
  }) : super(key: key);

  @override
  _StoreTypesState createState() => _StoreTypesState();
}

class _StoreTypesState extends State<StoreTypes> {
  int isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(25)),
      height: SizeConfig.screenHeight * .7,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: FutureBuilder(
        future: Services().getStoresCategories(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Categories>> snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: RefreshProgressIndicator(
              backgroundColor: Color(0xFFFEC40D),
            ));
          }
          return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: .7,
                mainAxisSpacing: 15,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      isSelected = index;
                    });
                    Stores store = Stores(
                      city: widget.government,
                      companyName: widget.storeName,
                      email: widget.email,
                      firstName: widget.fName,
                      lastName: widget.lName,
                      mobileNumber: widget.phone,
                      region: widget.region,
                      password: widget.password,
                    );
                    await Services().storeRegister(store);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerificationScreen(
                            mobile: widget.phone,
                          ),
                        ));
                  },
                  child: Container(
                    width: getProportionateScreenWidth(150),
                    height: getProportionateScreenHeight(150),
                    decoration: BoxDecoration(
                        color: isSelected == index
                            ? Colors.red[800]
                            : Color(0xFFFEC40D),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/homeIcon.svg',
                          color: Colors.white,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.contain,
                          width: getProportionateScreenWidth(120),
                          height: getProportionateScreenHeight(120),
                        ),
                        Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
