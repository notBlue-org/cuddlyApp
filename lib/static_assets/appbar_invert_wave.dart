import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInvertWaveSvg extends StatelessWidget {
  static String assetName = 'assets/images/wave_invert.svg';
  final Widget svg = SvgPicture.asset(
    assetName,
  );

  CustomInvertWaveSvg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return svg;
  }
}
