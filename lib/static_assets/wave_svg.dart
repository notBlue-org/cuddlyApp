import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaveSvg extends StatelessWidget {
  static String assetName = 'assets/images/wave.svg';
  final Widget svg = SvgPicture.asset(
    assetName,
  );

  WaveSvg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return svg;
  }
}
