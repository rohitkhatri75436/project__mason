import 'package:flutter/material.dart';
import 'package:quran_app/app/res/fonts/font_family.dart';

class TextWidget extends StatelessWidget {


  final String text;
  final double textSize;
  final double? lineSpace;
  final EdgeInsets padding;
  final Color color;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String fontFamily;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;
  const TextWidget(
      {
        required this.text,
        this.textSize = 14,
        this.padding =  EdgeInsets.zero,
        this.color = Colors.black,
        this.fontWeight = FontWeight.normal,
        this.backgroundColor = Colors.transparent,
        this.textAlign = TextAlign.start,
        this.fontFamily = FontStyles.inter,
        this.textDecoration = TextDecoration.none,
        this.maxLines,
        this.overflow,
        this.lineSpace,super.key,});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Text(
        text,
        maxLines: maxLines == null ? null : maxLines!,
        overflow: overflow == null ? TextOverflow.visible : overflow!,
        style: TextStyle(
          decoration: textDecoration,
          fontSize: textSize,
          color: color,
          fontWeight: fontWeight,
          height: lineSpace ?? 1.4,
          fontFamily: fontFamily,
        ),
        textAlign: textAlign,
      ),
    );
  }

}
