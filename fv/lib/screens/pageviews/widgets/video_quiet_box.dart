import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/screens/search_screen.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/nmBox.dart';

class VideoQuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            width: screenWidth * 0.85,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(

                //gradient: UniversalVariables.fabGradient,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                //color: UniversalVariables.white2
                color: mC,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(-10, 10),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: mCL,
                    offset: Offset(0, -10),
                    blurRadius: 10,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.video_camera,
                      color: UniversalVariables.gold2, size: 45),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text(
                      ConStrings.UPCOMING_VCONTACTS,
                      textAlign: TextAlign.center,
                      style: TextStyles.nextUpdate,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
