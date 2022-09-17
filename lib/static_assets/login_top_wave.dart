import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginTopWave extends StatelessWidget {
  static String assetName = 'assets/images/login_top_wave.svg';
  final Widget svg = SvgPicture.asset(
    assetName,
  );

  LoginTopWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return svg;
  }
}
