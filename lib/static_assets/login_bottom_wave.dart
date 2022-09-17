import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginBottomWave extends StatelessWidget {
  static String assetName = 'assets/images/login_bottom_wave.svg';
  final Widget svg = SvgPicture.asset(
    assetName,
  );

  LoginBottomWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return svg;
  }
}
