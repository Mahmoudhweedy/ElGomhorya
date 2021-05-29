import 'package:easy_localization/easy_localization.dart';
import '../constants/my_btn_nav_bar.dart';
import '../constants/custom_drawer.dart';
import '../models/user.dart';
import '../services/services.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;
import 'dart:convert';

import 'orders_screen.dart';

class Profile extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static String routeName = "/prfile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSelected = false;
  String imagePath;
  Future<int> getsUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id");
  }

  int userId;
  @override
  void initState() {
    isSelected = true;
    super.initState();
    getsUserId().then((value) => userId);
    SharedPreferences.getInstance().then((value) => {
          imagePath = value.getString("image"),
          print(" hryyyyyyyyyyyy $imagePath")
        });
  }

  String status = '';
  String errMessage = 'Error Uploading Image';

  File _image;
  final picker = ImagePicker();
  String imgPath;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print(pickedFile.path);
    imgPath = pickedFile.path;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("image", imgPath);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        upload(imgPath);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pushReplacementNamed(context, Profile.routeName);
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Future upload(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userMobile = prefs.getString("mobile");
    print(" userMobile $userMobile");
    final bytes = Io.File(image).readAsBytesSync();

    String img64 = base64Encode(bytes);
    print(img64);
    print("object");
    http.post(Uri.parse("https://dashboard.elgmhoria.com/api/add-cst-image"),
        body: <String, dynamic>{
          "image": img64,
          "name": image.split("/").last,
          "user_mobile": userMobile,
        }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String name;
  String mobile;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: widget._scaffoldKey,
      drawer: CustomDrawer(
        isSelected: isSelected,
        userName: name,
        mobileNumber: mobile,
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      backgroundColor: Color(0xFFF7F6FD),
      body: FutureBuilder(
        future: Services().getUserData(),
        builder: (BuildContext context, AsyncSnapshot<Guser> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: RefreshProgressIndicator(
                backgroundColor: Color(0xFFFEC40D),
              ),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text(""),
            );
          }
          name = '${snapshot.data.firstName} ${snapshot.data.lastName}';
          mobile = '${(snapshot.data.mobileNumber)}';
          return Stack(
            children: [
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget._scaffoldKey.currentState.openDrawer();
                      },
                      child: SizedBox(
                        child: SvgPicture.asset(
                          'assets/icons/menu_dots.svg',
                          width: 35,
                          height: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 30,
                        )),
                  ],
                ),
              ),
              Positioned(
                left: getProportionateScreenWidth(38),
                bottom: getProportionateScreenHeight(15),
                child: Center(
                  child: Container(
                    width: SizeConfig.screenWidth * .8,
                    height: SizeConfig.screenHeight * .7,
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
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(90)),
                        child: Column(
                          children: [
                            Text(
                              '${snapshot.data.firstName} ${snapshot.data.lastName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Visibility(
                              visible: (snapshot.data.city != null),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(58),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${snapshot.data.city}',
                                      style: TextStyle(
                                        //height: 1.1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/icons/location.png',
                                      width: getProportionateScreenWidth(25),
                                      height: getProportionateScreenHeight(25),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.0),
                              child: Divider(
                                thickness: 3,
                              ),
                            ),
                            Text(
                              tr("total_purchases"),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              ' 5000 ${tr("egp")}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Divider(thickness: 3),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _makePhoneCall(
                                            'tel:${snapshot.data.mobileNumber}');
                                      });
                                    },
                                    child: Text(
                                      snapshot.data.mobileNumber,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 3),
                            GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => OrderScreen())),
                                child:
                                    ProfileList(text: tr("purchase_orders"))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: getProportionateScreenHeight(80),
                left: getProportionateScreenWidth(115),
                child: GestureDetector(
                  onTap: getImage,
                  child: Container(
                    width: getProportionateScreenWidth(150),
                    height: getProportionateScreenHeight(150),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          spreadRadius: 1,
                          color: Colors.black12,
                        )
                      ],
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(75)),
                      color: Color(0xFF333333),
                      border: Border.all(width: 4, color: Color(0xFFB51F32)),
                    ),
                    child: imagePath == null
                        ? Text(
                            tr("profile_picture"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   child: MyBottomNavigationBar(),
              // ),
            ],
          );
        },
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  final String text;
  const ProfileList({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}

// bool isSelected = false;
// // File image;
// // final picker = ImagePicker();
// // bool imageExist = false;
// // Future<File> file;
// // String status = '';
// // String base64Image;
// // File tmpFile;
// // String errMessage = 'Error Uploading Image';

// Future<int> getsUserId() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getInt("id");
// }

// int userId;
// @override
// void initState() {
//   isSelected = true;
//   super.initState();
//   getsUserId().then((value) => userId);
// }

// static final String uploadEndPoint =
//     'http://localhost/flutter_test/upload_image.php';
// Future<File> file;
// String status = '';
// String base64Image;
// File tmpFile;
// String errMessage = 'Error Uploading Image';

// chooseImage() {
//   setState(() {
//     file = ImagePicker.pickImage(source: ImageSource.gallery);
//   });
//   setStatus('');
// }

// setStatus(String message) {
//   setState(() {
//     status = message;
//   });
// }

// startUpload() {
//   setStatus('Uploading Image...');
//   if (null == tmpFile) {
//     setStatus(errMessage);
//     return;
//   }
//   String fileName = tmpFile.path.split('/').last;
//   upload(fileName);
// }

// upload(String fileName) {
//   http.post(uploadEndPoint, body: {
//     "image": base64Image,
//     "name": fileName,
//   }).then((result) {
//     setStatus(result.statusCode == 200 ? result.body : errMessage);
//   }).catchError((error) {
//     setStatus(error);
//   });
// }

// // Future<void> _makePhoneCall(String url) async {
// //   if (await canLaunch(url)) {
// //     await launch(url);
// //   } else {
// //     throw 'Could not launch $url';
// //   }
// // }
