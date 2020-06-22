import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/resources/auth_methods.dart';
import 'package:fv/utils/appleSignInAvailable.dart';
// import 'package:gradient_text/gradient_text.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/ui_elements/loader.dart';
import 'package:fv/ui_elements/delayed_animation.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
// import 'package:avatar_glow/avatar_glow.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
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

  bool isGoogleLoginPressed = false;
  bool isAppleLoginPressed = false;

  Future<void> _signInWithApple(BuildContext context) async {

        setState(() {
      isAppleLoginPressed = true;
    });
    try {
      final authService = Provider.of<AuthMethods>(context, listen: false);
      final user = await authService
          .signInWithApple(scopes: [Scope.email, Scope.fullName]);
      if (user != null) {
        authenticateAppleUser(user);
      } else {
        print("There was an error");
      }
      print('uid: ${user.uid}');
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // final color = Colors.white;

    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);

    // Future<void> _signInWithApple(BuildContext context) async {

    //   try {
    //     final authService = Provider.of<AuthMethods>(context, listen: false);
    //     final user = await authService.signInWithApple(scopes: [Scope.email, Scope.fullName]);

    // if (user != null) {
    //   authenticateAppleUser(user);
    // } else {
    //   print("There was an error");
    // }
    // print('uid: ${user.uid}');
    //   } catch (e) {
    //     // TODO: Show alert here
    //     print(e);
    //   }
    // }

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
                        child: animatedGoogleSignIn(screenWidth),
                      ),
                      isGoogleLoginPressed
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
                  appleSignInAvailable.isAvailable
                      ? DelayedAnimation(
                          child: Stack(children: [
                            Center(
                              child: animatedAppleSignIn(screenWidth),
                            ),
                            isAppleLoginPressed
                                ? Center(
                                    child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 80),
                                      ColorLoader5(),
                                    ],
                                  ))
                                : Container(),
                          ]),
                          delay: delayedAmount + 3400,
                        )
                      : Container(),
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
  }

  // Widget loginButton() {
  //   return FlatButton(
  //     padding: EdgeInsets.all(35),
  //     child: Text(
  //       "LOGIN NOW",
  //       style: TextStyle(
  //           fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
  //     ),
  //     onPressed: () => performLogin(),
  //   );
  // }

  Widget animatedGoogleSignIn(screenwidth) => Container(
        height: 60,
        width: screenwidth * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: UniversalVariables.gold2.withOpacity(0.7),
        ),
        child: Center(
          child: FlatButton(
            onPressed: () => performGoogleLogin(),
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

  Widget animatedAppleSignIn(screenwidth) => Container(
      height: 60,
      width: screenwidth * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: UniversalVariables.blackColor.withOpacity(0.7),
      ),
      child: AppleSignInButton(
        style: ButtonStyle.black,
        type: ButtonType.signIn,
        onPressed: () => _signInWithApple(context),
      )

      // FlatButton(
      //   onPressed: () => _signInWithApple(context),
      //   child: Text(
      //     'Apple Sign In',
      //     style: TextStyle(
      //       fontFamily: 'Kiona',
      //       fontSize: 20.0,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      );

  void performGoogleLogin() {
    setState(() {
      isGoogleLoginPressed = true;
    });

    _repository.signIn().then((FirebaseUser user) {
      print("something");
      if (user != null) {
        authenticateGoogleUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  // void performAppleLogin() {

  //   setState(() {
  //     isAppleLoginPressed = true;
  //   });

  //   _signInWithApple(context);

  // }

  void authenticateGoogleUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isGoogleLoginPressed = false;
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

  void authenticateAppleUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isAppleLoginPressed = false;
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
