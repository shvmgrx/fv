import 'dart:async';

import 'package:infv1/onboarding/custom_app_bar.dart';
//import 'package:animal_planet/screens/choose_plan_screen.dart';
import 'package:infv1/onboarding/strings.dart';
import 'package:infv1/onboarding/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:infv1/screens/dashboard_screen.dart';
import 'package:infv1/screens/login_screen.dart';
import 'package:infv1/utils/universal_variables.dart';
import 'package:video_player/video_player.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     Pointing the video controller to our local asset.
//     _controller = VideoPlayerController.asset("assets/landingVideo.mp4")
//       ..initialize().then((_) {
//         // Once the video has been loaded we play the video and set looping to true.
//         _controller.play();
//         _controller.setLooping(true);
//         // Ensure the first frame is shown after the video is initialized.
//         setState(() {});
//       });
// Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => LoginScreen(),
//                     ),
//                   );
    
//   }

@override
  void initState() {
    super.initState();
      
      WidgetsBinding.instance.addPostFrameCallback((_) async {

      Timer(Duration(seconds: 1), () {
  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()
            )
        );
});
        
      });
  
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Image.asset(
            //   "assets/elephant.jpg",
            //   height: height,
            //   fit: BoxFit.fitHeight,
            // ),

            Center(
              child: Image.asset(
                "assets/faveezLogo.png",
                height: 80,
                width: 80,
              ),
            ),

            Positioned(
              bottom: 45,
              left: 100,
              right: 100,
              child: Text("FAVEEZ",
                  style: TextStyles.appNameLogoStyle,
                  textAlign: TextAlign.center),
            ),
            // SizedBox.expand(
            //     child: FittedBox(
            //       // If your background video doesn't look right, try changing the BoxFit property.
            //       // BoxFit.fill created the look I was going for.
            //       fit: BoxFit.cover,

            //       // child: SizedBox(
            //       //   width: _controller.value.size?.width ?? 0,
            //       //   height: _controller.value.size?.height ?? 0,
            //       //   child: VideoPlayer(_controller),
            //       // ),
            //     ),
            //   ),
            //  CustomAppBar(),
            //  Container(

            //    child:  Text("FAVErES"),),
            // Column(
            //   //mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[

            // Spacer(flex: 1,),

            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 120.0,
            //     left: 32,
            //     right: 32,
            //   ),
            // child: RichText(
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: Strings.READY_TO_CONNECT,
            //         style: TextStyles.bigHeadingTextStyle,
            //       ),
            //       TextSpan(text: "\n"),
            //        TextSpan(text: "\n"),
            //       TextSpan(

            //         text: Strings.READY_TO_CONNECT_DESC,
            //         style: TextStyles.bodyTextStyle,
            //       ),
            //       TextSpan(text: "\n"),
            //       TextSpan(text: "\n"),
            //       // TextSpan(
            //       //   text: Strings.START_ENJOYING,
            //       //   style: TextStyles.buttonTextStyle,
            //       // ),
            //     ],
            //   ),
            // ),
            // ),
            //   // ],
            // ),
            // Positioned(
            //   bottom: -30,
            //   right: -30,
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => LoginScreen(),
            //         ),
            //       );
            //     },
            //     child: Container(
            //       width: 100,
            //       height: 100,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: UniversalVariables.gold2.withOpacity(0.8),
            //       ),
            //       child: Align(
            //         alignment: Alignment(-0.4, -0.4),
            //         child: Icon(
            //           Icons.arrow_forward,
            //           color: Colors.white,
            //           size: 40,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Override the dipose() method to cleanup the video controller.
  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

}
