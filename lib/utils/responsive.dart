import 'package:flutter/material.dart';

class Responsive {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }

  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 360 && width < 600;
  }

  static double fontSize(BuildContext context, {required double small, required double medium, required double large}) {
    if (isSmallScreen(context)) return small;
    if (isMediumScreen(context)) return medium;
    return large;
  }

  static double horizontalPadding(BuildContext context) {
    return isSmallScreen(context) ? 8.0 : 12.0;
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle baseStyle;
  final double smallScale;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const ResponsiveText(
    this.text, {
    super.key,
    required this.baseStyle,
    this.smallScale = 0.85,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.isSmallScreen(context) ? smallScale : 1.0;
    return Text(
      text,
      style: baseStyle.copyWith(
        fontSize: (baseStyle.fontSize ?? 14) * scale,
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
