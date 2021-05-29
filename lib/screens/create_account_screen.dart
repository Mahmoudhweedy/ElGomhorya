// import 'package:easy_localization/easy_localization.dart';
// import '../constants/welcome_button.dart';
// import '../size_config.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CreateAccount extends StatelessWidget {
//   static String routeName = '/create_account';
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       backgroundColor: Color(0xFFF5FFFA),
//       body: Stack(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         alignment: AlignmentDirectional.topCenter,
//         children: [
//           Container(
//               width: SizeConfig.screenWidth, height: SizeConfig.screenHeight),
//           Container(
//             padding: EdgeInsets.only(
//               top: getProportionateScreenHeight(50),
//               right: getProportionateScreenWidth(20),
//               left: getProportionateScreenWidth(20),
//             ),
//             width: double.infinity,
//             height: SizeConfig.screenHeight * .45,
//             decoration: BoxDecoration(
//               color: Colors.yellow[600],
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//                 bottomRight: Radius.circular(50),
//               ),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   child: SvgPicture.asset(
//                     'assets/icons/menu_dots.svg',
//                     width: 35,
//                     height: 40,
//                   ),
//                 ),
//                 SizedBox(width: getProportionateScreenWidth(25)),
//                 Text(
//                   tr("أنشاء حساب"),
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
//                 ),
//                 Spacer(),
//                 SvgPicture.asset(
//                   'assets/icons/lnr-chevron-left.svg',
//                   height: 30.0,
//                   width: 30.0,
//                   allowDrawingOutsideViewBox: true,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: getProportionateScreenHeight(70),
//             child: Center(
//               child: Container(
//                 width: SizeConfig.screenWidth * .8,
//                 height: SizeConfig.screenHeight * .7,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(5),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0, 2),
//                       blurRadius: 6,
//                       spreadRadius: 2,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       TextField(
//                         decoration: InputDecoration(
//                           hintText: tr(""),
//                         ),
//                       ),
//                       SizedBox(height: getProportionateScreenHeight(30)),
//                       Row(
//                         children: [
//                           Icon(Icons.check_circle, size: 20),
//                           SizedBox(width: getProportionateScreenWidth(10)),
//                           Text(
//                             tr("موافق على الشروط والأحكام"),
//                             style: TextStyle(fontSize: 16),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: getProportionateScreenHeight(30)),
//                       WelcomeButton(
//                           onPress: () {},
//                           textColor: Colors.white,
//                           decoration: BoxDecoration(
//                               color: Color(0xFF3f3f47),
//                               borderRadius: BorderRadius.circular(50)),
//                           title: tr("التالي"))
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//               bottom: 0,
//               child: Container(
//                 width: SizeConfig.screenWidth,
//                 height: getProportionateScreenHeight(80),
//                 decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(2, 0),
//                     spreadRadius: 10,
//                   ),
//                 ]),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SvgPicture.asset(
//                       'assets/icons/store.svg',
//                       width: getProportionateScreenWidth(40),
//                       height: getProportionateScreenWidth(40),
//                     ),
//                     SvgPicture.asset(
//                       'assets/icons/store.svg',
//                       width: getProportionateScreenWidth(40),
//                       height: getProportionateScreenWidth(40),
//                     ),
//                     SvgPicture.asset(
//                       'assets/icons/store.svg',
//                       width: getProportionateScreenWidth(40),
//                       height: getProportionateScreenWidth(40),
//                     ),
//                     SvgPicture.asset(
//                       'assets/icons/store.svg',
//                       width: getProportionateScreenWidth(40),
//                       height: getProportionateScreenWidth(40),
//                     ),
//                     SvgPicture.asset(
//                       'assets/icons/store.svg',
//                       width: getProportionateScreenWidth(40),
//                       height: getProportionateScreenWidth(40),
//                     ),
//                   ],
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }


// // Container(
// //           padding: EdgeInsets.only(
// //             top: getProportionateScreenHeight(50),
// //             right: getProportionateScreenWidth(20),
// //             left: getProportionateScreenWidth(20),
// //           ),
// //           width: double.infinity,
// //           height: SizeConfig.screenHeight * .45,
// //           decoration: BoxDecoration(
// //             color: Colors.yellow[600],
// //             borderRadius: BorderRadius.only(
// //               bottomLeft: Radius.circular(50),
// //               bottomRight: Radius.circular(50),
// //             ),
// //           ),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               SizedBox(
// //                 child: SvgPicture.asset(
// //                   'assets/icons/menu_dots.svg',
// //                   width: 35,
// //                   height: 40,
// //                 ),
// //               ),
// //               SizedBox(width: getProportionateScreenWidth(25)),
// //               Text(
// //                 tr("أنشاء حساب"),
// //                 style:
// //                     TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
// //               ),
// //               Spacer(),
// //               SvgPicture.asset(
// //                 'assets/icons/lnr-chevron-left.svg',
// //                 height: 30.0,
// //                 width: 30.0,
// //                 allowDrawingOutsideViewBox: true,
// //               ),
// //             ],
// //           ),
// //         ),


// // Positioned(
// //               bottom: 0,
// //               child: Center(
// //                 child: Container(
// //                   width: SizeConfig.screenWidth * .7,
// //                   height: SizeConfig.screenHeight * .7,
// //                   color: Colors.red,
// //                 ),
// //               ),
// //             )
