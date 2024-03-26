import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zad_app/models/app_banner.dart';

class BannersSlider extends StatelessWidget {
  final List<AppBanner> banners;
  const BannersSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CarouselSlider(
          items: banners.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: InkWell(
                    onTap: banner.url.isEmpty
                        ? null
                        : () {
                            _launchUrl(banner.url);
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            banner.url,
                            scale: 1.4,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 132,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7),
            autoPlayAnimationDuration: const Duration(milliseconds: 1650),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
          )),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
