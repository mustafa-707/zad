import 'package:flutter/material.dart';
import 'package:flutter_country_code/flutter_country_code.dart';

// must too be updated into `flutter_country_code`
const String placeholderImgPath = 'flags/placeholder.png';

class FlagIcon extends StatelessWidget {
  final String? countryCode;

  const FlagIcon({
    super.key,
    this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(99)),
        child: Image.asset(
          countryCode == null ? placeholderImgPath : (getCountryByCountryCode(countryCode!).flag),
          fit: BoxFit.fill,
          height: 50,
          width: 50,
          package: countryCodePackageName,
          errorBuilder: (context, _, __) => const SizedBox(width: 22),
        ),
      ),
    );
  }
}
