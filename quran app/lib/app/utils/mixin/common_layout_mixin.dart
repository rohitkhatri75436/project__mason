import 'package:flutter/material.dart';

mixin CommonLayoutMixin {
  Widget getVerticalSpace(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget getHorizontalSpace(double width) {
    return SizedBox(
      width: width,
    );
  }

}
