import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zad_app/models/app_banner.dart';

class BannersSlider extends StatelessWidget {
  final List<AppBanner> banners;
  const BannersSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: CarouselSlider(
            items: banners.map((banner) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        image: DecorationImage(
                            image: NetworkImage(banner.url),
                            fit: BoxFit.cover)),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 100,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            )),
      ),
    );
  }
}
