import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBottomWave extends StatelessWidget {
  static String assetName = 'assets/images/home_bottom_wave.svg';
  final Widget svg = SvgPicture.asset(
    assetName,
  );

  HomeBottomWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return svg;
  }
}
