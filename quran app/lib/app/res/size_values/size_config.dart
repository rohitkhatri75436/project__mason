import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// SizeConfigWidget is used directly under MaterialApp
/// you have to provide draft size and child in this and provide UniqueKey() always.
class SizeConfigWidget extends StatefulWidget {

  final Widget child;
  final Size draftSize;
  const SizeConfigWidget(
      { required this.child, required this.draftSize,super.key,});


  @override
  State<SizeConfigWidget> createState() => _SizeConfigWidgetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Size>('draftSize', draftSize));
  }
}

class _SizeConfigWidgetState extends State<SizeConfigWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.initialize(
          context: context,
          draftWidth: widget.draftSize.width,
          draftHeight: widget.draftSize.height,
        );
        return widget.child;
      },
    );
  }
}

/// SizeConfig class is used to calculate h, w, sp & r.
/// To use this you have 2 option:
/// 1. User SizeConfigWidget
/// 2. or you can initialize SizeConfig.initialize once after MaterialApp
/// it uses Singleton feature
class SizeConfig {
  static SizeConfig? instance;
  late final double _widthScale;
  late final double _heightScale;
  late final double _textScale;


  SizeConfig(
      {required double widthScale,
      required double heightScale,
      bool minTextAdapt = false,})
      : _widthScale = widthScale,
        _heightScale = heightScale,
        _textScale = minTextAdapt ? min(widthScale, heightScale) : widthScale;

  factory SizeConfig.initialize({
    required BuildContext context,
    required double draftWidth,
    required double draftHeight,
    bool minTextAdapt = false,
  }) {


    final  actualWidth = MediaQuery.of(context).size.width;
    final  widthScale = actualWidth / draftWidth;

    ///Height Scale Calculate
    final actualHeight = MediaQuery.of(context).size.height;
    final heightScale = actualHeight / draftHeight;

    instance = SizeConfig(
        heightScale: heightScale,
        widthScale: widthScale,
        minTextAdapt: minTextAdapt,);

    return instance!;

  }


  double getHeight(num height) => height * _heightScale;

  double getWidth(num width) => width * _widthScale;

  double getTextSize(num textSize) => textSize * _textScale;

  double getRadius(num r) => r * min(_widthScale, _heightScale);

}

extension SizeConfigExtension on num {
  /// Get size according to height
  double get h => SizeConfig.instance!.getHeight(this);

  /// Get size according to width
  double get w => SizeConfig.instance!.getWidth(this);

  /// Get font size in SP
  double get sp => SizeConfig.instance!.getTextSize(this);

  /// Get minimum size in radius of height and width
  double get r => SizeConfig.instance!.getRadius(this);
}
