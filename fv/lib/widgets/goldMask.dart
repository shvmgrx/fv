import 'package:flutter/material.dart';
import 'package:fv/utils/universal_variables.dart';

class GoldMask extends StatelessWidget {
  GoldMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
    
        colors: [
          UniversalVariables.gold1,
                UniversalVariables.gold2,
                UniversalVariables.gold3,
                UniversalVariables.gold4
              ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}