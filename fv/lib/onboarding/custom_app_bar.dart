
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  final double opacity;

  const CustomAppBar({Key key, this.opacity = 0.8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.only(top: 5, left: 3, ),
        child: Row(
          children: <Widget>[
            // Image.asset("assets/logo.png",
            // height: 150,
            // width: 150,
            // ),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: Strings.APP_NAME,
            //         style: TextStyles.appNameTextStyle,
            //       ),
            //       TextSpan(text: "\n"),
            //     ],
            //   ),
            // ),
            Spacer(),
            // Icon(
            //   Icons.menu,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}