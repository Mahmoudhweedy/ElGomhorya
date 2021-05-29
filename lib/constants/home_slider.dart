import '../models/products.dart';
import '../user/product_screen.dart';
import '../models/slider.dart';
import '../services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../size_config.dart';
import 'constants.dart';
import 'package:shimmer/shimmer.dart';

final String imageUrl = '${image}slider/';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * .24,
      width: SizeConfig.screenWidth,
      alignment: Alignment.center,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder(
            future: Services().getSliders(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Sliders>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return SizedBox(
                  height: SizeConfig.screenHeight / 6,
                  width: SizeConfig.screenWidth,
                  child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      direction: ShimmerDirection.rtl,
                      highlightColor: Color(0xFFFEC40D).withOpacity(.1),
                      child: Container(
                        height: SizeConfig.screenHeight / 6,
                        width: SizeConfig.screenWidth,
                        color: Colors.white,
                      )),
                );
              }
              if (snapshot.data == null) {
                return SizedBox(
                  height: SizeConfig.screenHeight / 6,
                  width: SizeConfig.screenWidth,
                  child: Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.yellow,
                      child: Container(
                        height: SizeConfig.screenHeight / 6,
                        width: SizeConfig.screenWidth,
                      )),
                );
              }
              var productsJson = snapshot.data[index].product;
              var products = productsJson
                  .map((product) => Product.fromJson(product))
                  .toList();
              Widget sliderImage = Image.network(
                  '$imageUrl${snapshot.data[index].image}',
                  fit: BoxFit.fill);
              return GestureDetector(
                onTap: () {
                  products.isEmpty == null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductScreen(product: products[0]),
                          ),
                        )
                      : print('noproduct');
                },
                child: Container(
                  height: SizeConfig.screenHeight / 6,
                  child: ClipRRect(
                    child: sliderImage,
                  ),
                ),
              );
            },
          );
        },
        itemWidth: SizeConfig.screenWidth,
        itemHeight: SizeConfig.screenHeight * .24,
        itemCount: 3,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Color(0xffb51f32),
          ),
        ),
      ),
    );
  }
}
