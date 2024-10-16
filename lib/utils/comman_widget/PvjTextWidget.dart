import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadlineBodyOneBaseWidget extends StatelessWidget {
  const HeadlineBodyOneBaseWidget(
    this.title, {
    Key? key,
    this.titleColor,
    this.titleTextAlign = TextAlign.left,
    this.maxLine,
    this.fontWeight,
    this.textOverflow,
    this.fontSize,
    this.height,
    this.foreground,
    this.fontFamily,
    this.underline = false,
    this.letterSpacing=1,
    this.wordSpacing,
    this.isLineThrough = false,
    this.latterSpacing,
  }) : super(key: key);

  final String? title;
  final Color? titleColor;
  final TextAlign? titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final double? height;
  final double? latterSpacing;
  final Paint? foreground;
  final String? fontFamily;
  final bool underline;
  final double? letterSpacing;
  final double? wordSpacing;
  final bool? isLineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      style: GoogleFonts.robotoMono(
        letterSpacing: latterSpacing,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: titleColor
      ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: textOverflow,
      softWrap: true,
    );
  }
}
