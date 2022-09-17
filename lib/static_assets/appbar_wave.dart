import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomWaveSvg extends StatelessWidget {
  static String assetName = 'assets/images/wave_flip.svg';
  final Widget svg = SvgPicture.asset(
    assetName,
  );

  CustomWaveSvg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return svg;
  }
}
