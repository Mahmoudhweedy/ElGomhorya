import 'package:elgomhorya/screens/sign_choice.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePicker extends StatelessWidget {
  static String routeName = '/language_pick';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEC40D),
        title: Text("اختيار اللغة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'يرجى اختيار لغة التطبيق',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Spacer(flex: 1),
            GestureDetector(
              onTap: () async {
                await context.setLocale(Locale('ar', 'EG'));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("lang", "ar");
                print(prefs.containsKey("lang"));
                Navigator.pushNamed(context, SignChoice.routeName);
              },
              child: Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFFFEC40D),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'العربية',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () async {
                await context.setLocale(Locale('en', 'US'));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("lang", "en");
                Navigator.pushNamed(context, SignChoice.routeName);
              },
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFFFEC40D),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'English',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
