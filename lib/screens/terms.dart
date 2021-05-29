import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/constants.dart';
import 'package:elgomhorya/constants/my_app_bar.dart';
import 'package:elgomhorya/models/terms.dart';
import 'package:elgomhorya/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Terms extends StatefulWidget {
  static String routeName = '/terms';

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar(
              isDrawer: false,
              radius: 30,
              screenName: tr("terms"),
              onPress: () {},
            ),
            SizedBox(height: 15),
            SvgPicture.asset(
              'assets/icons/term.svg',
              width: 100,
              height: 100,
              color: kPrimaryColor,
            ),
            FutureBuilder(
              future: Services().getTerms(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TermsAndConditions>> snapshot) {
                if (snapshot.data == null) {
                  return Center(child: SpinKitHourGlass(color: kPrimaryColor));
                }
                if (!snapshot.hasData) {
                  return SpinKitHourGlass(color: kPrimaryColor);
                }
                var desc = snapshot.data[0].description.split('ضيفنا');
                return Column(
                  children: [
                    Text(
                      snapshot.data[0].title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      desc[0],
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'ضيفنا${desc[1]}',
                      style: TextStyle(fontSize: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            snapshot.data.length - 1,
                            (index) => ExpansionPanelList(
                                  elevation: 0,
                                  dividerColor: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  children: [
                                    ExpansionPanel(
                                      canTapOnHeader: true,
                                      headerBuilder: (_, isExpanded) {
                                        return Text(
                                            snapshot.data[index + 1].title);
                                      },
                                      body: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(snapshot
                                            .data[index + 1].description),
                                      ),
                                      isExpanded:
                                          snapshot.data[index + 1].expanded,
                                    ),
                                  ],
                                  expansionCallback: (int item, bool status) {
                                    setState(() {
                                      snapshot.data[index].expanded =
                                          !snapshot.data[index].expanded;
                                    });
                                  },
                                )),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
