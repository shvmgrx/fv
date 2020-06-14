import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:infv1/onboarding/text_styles.dart';
import 'package:infv1/resources/firebase_repository.dart';
import 'package:infv1/utils/universal_variables.dart';
import 'package:infv1/ui_elements/loader.dart';
import 'package:infv1/ui_elements/delayed_animation.dart';
import 'home_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  FirebaseRepository _repository = FirebaseRepository();

  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final color = Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        backgroundColor: UniversalVariables.backgroundGrey,
        body: Stack(
          children: <Widget>[
            // Image.asset(
            //   "assets/loginImage.png",
            //   height: height,
            //   fit: BoxFit.fitHeight,
            // ),
            Center(
              child: Column(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 30),
                  //   child: AvatarGlow(
                  //     endRadius: 85,
                  //     duration: Duration(seconds: 2),
                  //     glowColor: Color(0xffd07155),
                  //     repeat: true,
                  //     repeatPauseDuration: Duration(seconds: 2),
                  //     startDelay: Duration(seconds: 1),
                  //     child: Material(
                  //         elevation: 8.0,
                  //         shape: CircleBorder(),
                  //         child: CircleAvatar(
                  //           child: Container(
                  //               width: 190.0,
                  //               height: 190.0,
                  //               decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   image: DecorationImage(
                  //                       fit: BoxFit.fill,
                  //                       image: AssetImage(
                  //                           "assets/izlits.jpeg")))),
                  //           // child: Image.asset(
                  //           //   "assets/logoBorder.png",
                  //           // ),
                  //           radius: 50.0,
                  //         )),
                  //   ),
                  // ),
                  SizedBox(
                    height: 160.0,
                  ),
                  DelayedAnimation(
                    child:

                        // GradientText("FAVEEZ",
                        // gradient: LinearGradient(colors: [
                        //   UniversalVariables.gold1,
                        //   UniversalVariables.gold2,
                        //   UniversalVariables.gold3,
                        //   UniversalVariables.gold4
                        // ],
                        // ),
                        // style: TextStyles.appNameLogoStyle,
                        // textAlign: TextAlign.center),

                        Text("FAVEEZ",
                          
                            style: TextStyles.appNameLogoStyle,
                            textAlign: TextAlign.center),
                    delay: delayedAmount + 1000,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Get personal advice from ",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          //fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: UniversalVariables.grey2),
                    ),
                    delay: delayedAmount + 2000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "the people you look up to.",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          //fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: UniversalVariables.grey2),
                    ),
                    delay: delayedAmount + 2500,
                  ),
                  SizedBox(
                    height: 170.0,
                  ),
                  DelayedAnimation(
                    child: Stack(children: [
                      Center(
                        child: animatedButtonUI(screenWidth),
                      ),
                      isLoginPressed
                          ? Center(
                              child: Column(
                              children: <Widget>[
                                SizedBox(height: 80),
                                ColorLoader5(),
                              ],
                            ))
                          : Container(),
                    ]),
                    delay: delayedAmount + 3000,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: UniversalVariables.blackColor,
    //   body: Stack(children: [
    //     Center(
    //       child: loginButton(),
    //     ),
    //     isLoginPressed ? Center(child: ColorLoader5()) : Container(),
    //   ]),
    // );
  }

  Widget loginButton() {
    return FlatButton(
      padding: EdgeInsets.all(35),
      child: Text(
        "LOGIN NOW",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
      ),
      onPressed: () => performLogin(),
    );
  }

  Widget animatedButtonUI(screenwidth) => Container(
        height: 60,
        width: screenwidth*0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: UniversalVariables.gold2.withOpacity(0.7),
        ),
        child: Center(
          child: FlatButton(
            onPressed: () => performLogin(),
            child: Text(
              'Google Sign In',
              style: TextStyle(
                fontFamily: 'Kiona',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  void performLogin() {
    setState(() {
      isLoginPressed = true;
    });

    _repository.signIn().then((FirebaseUser user) {
      print("something");
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
