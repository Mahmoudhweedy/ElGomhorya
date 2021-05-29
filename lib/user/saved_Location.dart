import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/my_app_bar.dart';
import 'package:flutter/material.dart';

class SavedLocations extends StatefulWidget {
  static String routeName = '/saved_loc';

  @override
  _SavedLocationsState createState() => _SavedLocationsState();
}

class _SavedLocationsState extends State<SavedLocations> {
  String savedLocation;
  @override
  void initState() {
    print("savedLocation $savedLocation");
    SharedPreferences.getInstance().then((value) {
      savedLocation = value.getString("address");
      print(" in savedLocation $savedLocation");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar(
              radius: 30,
              screenName: tr('saved_locations'),
              onPress: () {},
              isDrawer: false,
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(3, (index) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/home.svg',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: Text(
                          savedLocation,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
