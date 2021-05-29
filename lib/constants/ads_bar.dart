import 'package:elgomhorya/models/ad.dart';
import 'package:elgomhorya/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../size_config.dart';
import 'constants.dart';

class ADSBar extends StatelessWidget {
  const ADSBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services().getAds(),
      builder: (BuildContext context, AsyncSnapshot<List<Ad>> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Text('Ads'),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('Ads'),
          );
        }
        return Container(
          margin:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(50)),
          width: SizeConfig.screenWidth,
          height: getProportionateScreenHeight(120),
          color: Color(0xFF333333),
          child: Swiper(
            itemBuilder: (_, index) {
              return Container(
                child: Image.network(
                  '${image}ads/${snapshot.data[index].image}',
                  fit: BoxFit.fitWidth,
                ),
              );
            },
            itemCount: snapshot.data.length,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: Color(0xffb51f32),
              ),
            ),
          ),
        );
      },
    );
  }
}
