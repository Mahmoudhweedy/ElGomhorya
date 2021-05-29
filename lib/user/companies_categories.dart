// import 'package:easy_localization/easy_localization.dart';
// import '../constants/ads_bar.dart';
// import '../constants/my_app_bar.dart';
// import '../constants/my_btn_nav_bar.dart';
// import '../size_config.dart';
// import '../user/categories_screen.dart';
// import '../user/products_screen.dart';
// import 'package:flutter/material.dart';

// class CompaniesCategories extends StatelessWidget {
//   static String routeName = '/companies_categories';
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 MyAppBar(radius: 25, screenName: tr("companies")),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: getProportionateScreenWidth(20)),
//                   child: Text(
//                     tr("companies"),
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: SizeConfig.screenHeight,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 8,
//                     itemBuilder: (BuildContext context, int index) {
//                       if (index == 2) {
//                         return ADSBar();
//                       }
//                       return CompaniesSlider();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           MyBottomNavigationBar(),
//         ],
//       ),
//     );
//   }
// }

// class CompaniesSlider extends StatelessWidget {
//   const CompaniesSlider({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.fromLTRB(
//         getProportionateScreenWidth(15),
//         0,
//         0,
//         0,
//       ),
//       height: getProportionateScreenHeight(180),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 6,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () => Navigator.pushNamed(context, ProductsScreen.routeName),
//             child: Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: getProportionateScreenWidth(10),
//                 vertical: getProportionateScreenHeight(20),
//               ),
//               padding: EdgeInsets.all(8),
//               width: getProportionateScreenWidth(140),
//               height: getProportionateScreenHeight(150),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(3),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 2),
//                     blurRadius: 4,
//                     spreadRadius: 4,
//                     color: Colors.black12,
//                   )
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 50,
//                     height: 50,
//                     // child:
//                     // SvgPicture.asset(
//                     //   'assets/icons/Tool3.svg',
//                     // ),
//                   ),
//                   Text(
//                     tr("elsewedy"),
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
