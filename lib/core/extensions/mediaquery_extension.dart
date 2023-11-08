import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  double getHight() {
    return MediaQuery.of(this).size.height;
  }

  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  Orientation getOrientation() {
    return MediaQuery.of(this).orientation;
  }

  double getDefaultSize() {
    return getOrientation() == Orientation.landscape ? getHight() * .024 : getWidth() * .024;
  }
}
