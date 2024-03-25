import 'package:flutter/widgets.dart';

extension MediaQuiryHelper on BuildContext {
  double get width => MediaQuery.of(this).size.width;
}
