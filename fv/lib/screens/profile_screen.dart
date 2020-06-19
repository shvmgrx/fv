import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/screens/settingsScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/strings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/editProfile.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/screens/influencer_detail.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/screens/landing_screen.dart';
import 'package:fv/screens/list_influencer.dart';
import 'package:fv/screens/pageviews/chat_list_screen.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/goldMask.dart';
import 'package:fv/widgets/nmBox.dart';
import 'package:fv/widgets/nmButton.dart';
import 'package:fv/widgets/nmCard.dart';
import 'package:fv/widgets/slideRoute.dart';
import 'package:flutter/services.dart';
import 'package:swipedetector/swipedetector.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final influencers = allInfluencers;

  FirebaseRepository _repository = FirebaseRepository();

  String loggedInuid;
  String loggedInname;
  String loggedInemail;
  String loggedInusername;
  String loggedInstatus;
  int loggedInstate;
  String loggedInprofilePhoto;
  int loggedInanswerPrice1;
  int loggedInanswerPrice2;
  int loggedInanswerPrice3;
  int loggedInanswerDuration;
  String loggedInbio;
  bool loggedInisInfCert;
  int loggedInmaxQuestionCharcount;
  int loggedInrating;
  String loggedIncategory;
  int loggedInreviews;
  int loggedIninfWorth;
  int loggedIninfSent;
  int loggedIninfReceived;
  bool loggedInisInfluencer;

  AnimationController controller;
  Animation animation;
  Animation anim;

  void initState() {
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedInuid = loggedUser['uid'];
          loggedInname = loggedUser['name'];
          loggedInemail = loggedUser['email'];
          loggedInusername = loggedUser['username'];
          loggedInstatus = loggedUser['status'];
          loggedInstate = loggedUser['state'];
          loggedInprofilePhoto = loggedUser['profilePhoto'];
          loggedInanswerPrice1 = loggedUser['answerPrice1'];
          loggedInanswerPrice2 = loggedUser['answerPrice2'];
          loggedInanswerPrice3 = loggedUser['answerPrice3'];
          loggedInanswerDuration = loggedUser['answerDuration'];
          loggedInbio = loggedUser['bio'];
          loggedInisInfCert = loggedUser['isInfCert'];
          loggedInmaxQuestionCharcount = loggedUser['maxQuestionCharcount'];
          loggedInrating = loggedUser['rating'];
          loggedIncategory = loggedUser['category'];
          loggedInreviews = loggedUser['reviews'];
          loggedIninfWorth = loggedUser['infWorth'];
          // loggedIninfSent = loggedUser['infSent'];
          loggedIninfReceived = loggedUser['infReceived'];
          loggedInisInfluencer = loggedUser['isInfluencer'];
        });
      });
    });

        controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    anim = TextStyleTween(
            begin: TextStyles.usernameStyleBegin,
            end: TextStyles.usernameStyleEnd)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });
    
    super.initState();
  }
  
    @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void pullUp() {
    controller.forward();
  }

  void pullDown() {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    bool showAppBar = true;

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SwipeDetector(
        onSwipeUp: () {
          pullUp();
        },
        onSwipeDown: () {
          pullDown();
        },
        swipeConfiguration: SwipeConfiguration(
          verticalSwipeMinVelocity: 20.0,
          verticalSwipeMinDisplacement: 20.0,
          verticalSwipeMaxWidthThreshold: 120.0,
        ),
        child: Stack(
          children: <Widget>[
            
            Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.transparent),
            GestureDetector(
              onTap: () {
                pullDown();
              },
              child: Container(
                height: screenHeight - screenHeight / 3,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/surfing.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 30.0, right: 65.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  ),
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: UniversalVariables.white2),
                  child: Center(
                    child: Icon(CupertinoIcons.settings,
                        size: 30.0, color: UniversalVariables.grey1),
                  ),
                ),
              ),
            ),
          ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(left: 45.0, top: 30.0, right: 15.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  ),
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: UniversalVariables.white2),
                  child: Center(
                    child: Icon(CupertinoIcons.pen,
                        size: 20.0, color: UniversalVariables.grey1),
                  ),
                ),
              ),
            ),
          ),
            Positioned(
             
             top: loggedInisInfluencer? 
             screenHeight - (screenHeight / 2.5) - (controller.value * 100)-55
             :screenHeight - (screenHeight / 2) - (controller.value * 100)+120,
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                height: screenHeight,
                width: screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.0),
                      loggedInname != null
                          ? Text(
                              loggedInname,
                              style: TextStyles.theNameStyle,
                            )
                          : Text(
                              "Favees User",
                              style: TextStyles.theNameStyle,
                            ),
                      SizedBox(height: 7.0),

                      // SizedBox(height: 7.0),

                      // SizedBox(height: 1.0),
                     loggedInbio != null
                          ? Container(
                              width: 180,
                              child: Text(loggedInbio,
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: UniversalVariables.grey2)),
                            )
                          : Container(
                              width: 175,
                              child: Text(
                                "Nam quis nulla. Integer malesuada. In in enim a arcu imperdiet malesuada. Sed vel lectus. Donec odio urna, tempus molest",
                                style: GoogleFonts.sourceSansPro(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: UniversalVariables.grey2),
                              ),
                            ),

                      SizedBox(height: 15.0),
                      // Text('Read More',
                      //   style: GoogleFonts.sourceSansPro(
                      //     fontSize: 14.0,
                      //     fontWeight: FontWeight.w400,
                      //     color: Color(0xFFF36F32)
                      //   )
                      // ),
                      SizedBox(height: 25.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                              },
                              child: Visibility(
                                visible:loggedInisInfluencer,
                                                              child: Container(
                                  height: 80.0,
                                  width: screenWidth / 4,
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Text Reply",
                                                style: TextStyles.priceType,
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: loggedInanswerPrice1 !=
                                                  null
                                              ? Text(
                                                  "\$ ${loggedInanswerPrice1}",
                                                  style: TextStyles.priceNumber,
                                                  textAlign: TextAlign.center)
                                              : Text("Not Set",
                                                  style: TextStyles
                                                      .notSetPriceNumber,
                                                  textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                              },
                              child: Visibility(
                                visible:loggedInisInfluencer,
                                                              child: Container(
                                  height: 80.0,
                                  width: screenWidth / 4,
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Video Reply",
                                                style: TextStyles.priceType,
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: loggedInanswerPrice2 !=
                                                  null
                                              ? Text(
                                                  "\$ ${loggedInanswerPrice2}",
                                                  style: TextStyles.priceNumber,
                                                  textAlign: TextAlign.center)
                                              : Text("Not Set",
                                                  style: TextStyles
                                                      .notSetPriceNumber,
                                                  textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                              },
                              child: Visibility(
                                visible:loggedInisInfluencer,
                                                              child: Container(
                                  height: 80.0,
                                  width: screenWidth / 4,
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Videocall",
                                                style: TextStyles.priceType,
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: loggedInanswerPrice3 !=
                                                  null
                                              ? Text(
                                                  "\$ ${loggedInanswerPrice3}",
                                                  style: TextStyles.priceNumber,
                                                  textAlign: TextAlign.center)
                                              : Text("Not Set",
                                                  style: TextStyles
                                                      .notSetPriceNumber,
                                                  textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0),
                      //   child: Container(
                      //       height: 250,
                      //       width: screenWidth * 0.9,
                      //       color: UniversalVariables.transparent,
                      //       child: SingleChildScrollView(
                      //         scrollDirection: Axis.vertical,
                      //         child: Column(
                      //           children: <Widget>[
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 color: UniversalVariables.standardWhite,
                      //                 borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(100),
                      //                   topRight: Radius.circular(100),
                      //                   //   bottomLeft: Radius.circular(10),
                      //                   //   bottomRight: Radius.circular(10),
                      //                 ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.only(top: 18.0),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: <Widget>[
                      //                     Text("July 23, 16:00",
                      //                         style: TextStyles
                      //                             .timeTextDetailStyle),
                      //                     Container(
                      //                       // color:Colors.orange,
                      //                       width: 75,
                      //                       decoration: BoxDecoration(
                      //                         color: UniversalVariables.gold2,
                      //                         borderRadius: BorderRadius.only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Row(
                      //                           children: <Widget>[
                      //                             Icon(
                      //                               Icons.shopping_cart,
                      //                               color: UniversalVariables
                      //                                   .standardWhite,
                      //                             ),
                      //                             Text("BOOK",
                      //                                 style: TextStyles
                      //                                     .timeSlotDetails),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 color: UniversalVariables.standardWhite,
                      //                 // borderRadius: BorderRadius.only(
                      //                 //   topLeft: Radius.circular(10),
                      //                 //   topRight: Radius.circular(10),
                      //                 //   bottomLeft: Radius.circular(10),
                      //                 //   bottomRight: Radius.circular(10),
                      //                 // ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: <Widget>[
                      //                     Text("July 23, 16:00",
                      //                         style: TextStyles
                      //                             .timeTextDetailStyle),
                      //                     Container(
                      //                       // color:Colors.orange,
                      //                       width: 75,
                      //                       decoration: BoxDecoration(
                      //                         color: UniversalVariables.gold2,
                      //                         borderRadius: BorderRadius.only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Row(
                      //                           children: <Widget>[
                      //                             Icon(
                      //                               Icons.shopping_cart,
                      //                               color: UniversalVariables
                      //                                   .standardWhite,
                      //                             ),
                      //                             Text("BOOK",
                      //                                 style: TextStyles
                      //                                     .timeSlotDetails),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 color: UniversalVariables.standardWhite,
                      //                 // borderRadius: BorderRadius.only(
                      //                 //   topLeft: Radius.circular(10),
                      //                 //   topRight: Radius.circular(10),
                      //                 //   bottomLeft: Radius.circular(10),
                      //                 //   bottomRight: Radius.circular(10),
                      //                 // ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: <Widget>[
                      //                     Text("July 23, 16:00",
                      //                         style: TextStyles
                      //                             .timeTextDetailStyle),
                      //                     Container(
                      //                       // color:Colors.orange,
                      //                       width: 75,
                      //                       decoration: BoxDecoration(
                      //                         color: UniversalVariables.gold2,
                      //                         borderRadius: BorderRadius.only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Row(
                      //                           children: <Widget>[
                      //                             Icon(
                      //                               Icons.shopping_cart,
                      //                               color: UniversalVariables
                      //                                   .standardWhite,
                      //                             ),
                      //                             Text("BOOK",
                      //                                 style: TextStyles
                      //                                     .timeSlotDetails),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 color: UniversalVariables.standardWhite,
                      //                 // borderRadius: BorderRadius.only(
                      //                 //   topLeft: Radius.circular(10),
                      //                 //   topRight: Radius.circular(10),
                      //                 //   bottomLeft: Radius.circular(10),
                      //                 //   bottomRight: Radius.circular(10),
                      //                 // ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: <Widget>[
                      //                     Text("July 23, 16:00",
                      //                         style: TextStyles
                      //                             .timeTextDetailStyle),
                      //                     Container(
                      //                       // color:Colors.orange,
                      //                       width: 75,
                      //                       decoration: BoxDecoration(
                      //                         color: UniversalVariables.gold2,
                      //                         borderRadius: BorderRadius.only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Row(
                      //                           children: <Widget>[
                      //                             Icon(
                      //                               Icons.shopping_cart,
                      //                               color: UniversalVariables
                      //                                   .standardWhite,
                      //                             ),
                      //                             Text("BOOK",
                      //                                 style: TextStyles
                      //                                     .timeSlotDetails),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 color: UniversalVariables.standardWhite,
                      //                 // borderRadius: BorderRadius.only(
                      //                 //   topLeft: Radius.circular(10),
                      //                 //   topRight: Radius.circular(10),
                      //                 //   bottomLeft: Radius.circular(10),
                      //                 //   bottomRight: Radius.circular(10),
                      //                 // ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: <Widget>[
                      //                     Text("July 23, 16:00",
                      //                         style: TextStyles
                      //                             .timeTextDetailStyle),
                      //                     Container(
                      //                       // color:Colors.orange,
                      //                       width: 75,
                      //                       decoration: BoxDecoration(
                      //                         color: UniversalVariables.gold2,
                      //                         borderRadius: BorderRadius.only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Row(
                      //                           children: <Widget>[
                      //                             Icon(
                      //                               Icons.shopping_cart,
                      //                               color: UniversalVariables
                      //                                   .standardWhite,
                      //                             ),
                      //                             Text("BOOK",
                      //                                 style: TextStyles
                      //                                     .timeSlotDetails),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 color: UniversalVariables.standardWhite,
                      //                 // borderRadius: BorderRadius.only(
                      //                 //   topLeft: Radius.circular(10),
                      //                 //   topRight: Radius.circular(10),
                      //                 //   bottomLeft: Radius.circular(10),
                      //                 //   bottomRight: Radius.circular(10),
                      //                 // ),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: <Widget>[
                      //                     Text("July 23, 16:00",
                      //                         style: TextStyles
                      //                             .timeTextDetailStyle),
                      //                     Container(
                      //                       // color:Colors.orange,
                      //                       width: 75,
                      //                       decoration: BoxDecoration(
                      //                         color: UniversalVariables.gold2,
                      //                         borderRadius: BorderRadius.only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Row(
                      //                           children: <Widget>[
                      //                             Icon(
                      //                               Icons.shopping_cart,
                      //                               color: UniversalVariables
                      //                                   .standardWhite,
                      //                             ),
                      //                             Text("BOOK",
                      //                                 style: TextStyles
                      //                                     .timeSlotDetails),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 color: UniversalVariables.standardWhite,
                      //                 borderRadius: BorderRadius.only(
                      //                   //  topLeft: Radius.circular(10),
                      //                   //  topRight: Radius.circular(10),
                      //                   bottomLeft: Radius.circular(50),
                      //                   bottomRight: Radius.circular(50),
                      //                 ),
                      //               ),
                      //               child: Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(bottom: 80.0),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: <Widget>[
                      //                     Text("July 23, 16:00",
                      //                         style: TextStyles
                      //                             .timeTextDetailStyle),
                      //                     Container(
                      //                       // color:Colors.orange,
                      //                       width: 75,
                      //                       decoration: BoxDecoration(
                      //                         color: UniversalVariables.gold2,
                      //                         borderRadius: BorderRadius.only(
                      //                           topLeft: Radius.circular(10),
                      //                           topRight: Radius.circular(10),
                      //                           bottomLeft: Radius.circular(10),
                      //                           bottomRight:
                      //                               Radius.circular(10),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Row(
                      //                           children: <Widget>[
                      //                             Icon(
                      //                               Icons.shopping_cart,
                      //                               color: UniversalVariables
                      //                                   .standardWhite,
                      //                             ),
                      //                             Text("BOOK",
                      //                                 style: TextStyles
                      //                                     .timeSlotDetails),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       )),
                      // ),
                      // Container(
                      //   width: 325,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Container(
                      //             height: 75.0,
                      //             width: 150.0,
                      //             child: Center(
                      //                 child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                   Icon(
                      //                     Icons.text_format,
                      //                     color: Colors.white,
                      //                     size: 30,
                      //                   ),
                      //                   Text(Strings.TEXT_MESSAGE,
                      //                       style: GoogleFonts.sourceSansPro(
                      //                           fontSize: 12.0,
                      //                           fontWeight: FontWeight.w500,
                      //                           color: UniversalVariables
                      //                               .standardCream))
                      //                 ])),
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.all(
                      //                   Radius.circular(35.0),
                      //                 ),
                      //                 color: UniversalVariables.standardPink),
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Container(
                      //             height: 75.0,
                      //             width: 150.0,
                      //             child: Center(
                      //                 child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                   Icon(
                      //                     Icons.videocam,
                      //                     color: Colors.white,
                      //                     size: 30,
                      //                   ),
                      //                   Text(Strings.VIDEO_MESSAGE,
                      //                       style: GoogleFonts.sourceSansPro(
                      //                           fontSize: 12.0,
                      //                           fontWeight: FontWeight.w500,
                      //                           color: UniversalVariables
                      //                               .standardCream))
                      //                 ])),
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.all(
                      //                   Radius.circular(35.0),
                      //                 ),
                      //                 color: UniversalVariables.standardPink),
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ]),
                decoration: BoxDecoration(
                  color: UniversalVariables.backgroundGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //       height: 70.0,
            //       width: MediaQuery.of(context).size.width,
            //       child: Center(
            //           child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //               //crossAxisAlignment: CrossAxisAlignment.stretch,
            //               children: [
            //             Icon(
            //               Icons.expand_less,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //             Icon(
            //               Icons.star_border,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //             Icon(
            //               Icons.expand_more,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //           ])),
            //       decoration: BoxDecoration(
            //           //borderRadius: BorderRadius.only(topLeft: Radius.circular(55.0)),
            //           color: UniversalVariables.standardWhite),
            //     ),
            //     ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 30.0),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalVariables.white2),
                    child: Center(
                      child: Icon(Icons.arrow_back,
                          size: 20.0, color: UniversalVariables.grey1),
                    ),
                  ),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 15.0, top: 30.0, right: 15.0),
            //     child: Container(
            //       height: 40.0,
            //       width: 40.0,
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle, color: UniversalVariables.white2),
            //       child: Center(
            //         child: Icon(Icons.edit,
            //             size: 20.0, color: UniversalVariables.grey1),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: (screenHeight - screenHeight / 3) / 2,
            //   left: (screenWidth /2) - 75.0,
            //   child: Container(
            //     height: 40.0,
            //     width: 150.0,
            //     decoration: BoxDecoration(
            //       color: Color(0xFFA4B2AE),
            //       borderRadius: BorderRadius.circular(20.0)
            //     ),
            //     child: Center(
            //       child: Text('Add Your intro video here',
            //       style: GoogleFonts.sourceSansPro(
            //         fontSize: 14.0,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.white
            //       )
            //       )
            //     )
            //   )
            // ),
            Positioned(
              top: loggedInisInfluencer? 
              screenHeight -screenHeight / 2.5 -65.0 -(controller.value * 100)-20
              :screenHeight -screenHeight / 2.5 -65.0 -(controller.value * 100)+60
              ,
              right: 35.0,
              child: Hero(
                tag: loggedInprofilePhoto,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 110.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              loggedInprofilePhoto),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Row(
                        children: <Widget>[
                          loggedInusername != null
                              ? Text(
                                  loggedInusername,
                                  // style: TextStyles.usernameStyle,
                                  style: anim.value,
                                )
                              : Text(
                                  "faveezUsername",
                                  style: TextStyles.usernameStyleEnd,
                                ),
                          Icon(
                            Icons.verified_user,
                            color: UniversalVariables.gold2,
                            size: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Positioned(
            //   top: screenHeight - screenHeight / 3.5,
            //   left: 10,
            //   right: 10,
            //   child: Center(
            //     child: Row(
            //       children: <Widget>[
            //         Padding(
            //           padding: EdgeInsets.all(20.0),
            //           child: Stack(
            //             children: <Widget>[
            //               Container(
            //                   height: 110.0,
            //                   width: 126.0,
            //                   color: UniversalVariables.transparent),
            //               Positioned(
            //                   left: 1.0,
            //                   top: 1.0,
            //                   child: Column(
            //                     children: <Widget>[
            //                       GestureDetector(
            //                         onTap: () {
            //                           Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                               builder: (context) => ChatScreen(
            //                                 receiver: widget.selectedInfluencer,
            //                               ),
            //                             ),
            //                           );
            //                         },
            //                         child: Container(
            //                           height: 78.0,
            //                           width: 115.0,
            //                           decoration: BoxDecoration(

            //                               //gradient: UniversalVariables.fabGradient,

            //                               borderRadius: BorderRadius.only(
            //                                 topLeft: Radius.circular(10.0),
            //                                 topRight: Radius.circular(10.0),
            //                               ),
            //                               //color: UniversalVariables.white2
            //                               color: mC,
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                   color: mCD,
            //                                   offset: Offset(-10, 10),
            //                                   blurRadius: 10,
            //                                 ),
            //                                 BoxShadow(
            //                                   color: mCL,
            //                                   offset: Offset(0, -10),
            //                                   blurRadius: 10,
            //                                 ),
            //                               ]),
            //                           child: Padding(
            //                             padding: const EdgeInsets.symmetric(
            //                                 vertical: 2.0),
            //                             child: Align(
            //                               alignment: Alignment.center,
            //                               child: widget.selectedInfluencer
            //                                           .answerPrice1 !=
            //                                       null
            //                                   ? Text(
            //                                       "\$ ${widget.selectedInfluencer.answerPrice1}",
            //                                       style: TextStyles.priceNumber,
            //                                       textAlign: TextAlign.center)
            //                                   : Text("Not Set",
            //                                       style: TextStyles
            //                                           .notSetPriceNumber,
            //                                       textAlign: TextAlign.center),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 27.0,
            //                         width: 115.0,
            //                         decoration: BoxDecoration(
            //                             //gradient: UniversalVariables.fabGradient,
            //                             borderRadius: BorderRadius.only(
            //                               bottomLeft: Radius.circular(10.0),
            //                               bottomRight: Radius.circular(10.0),
            //                             ),
            //                             color: UniversalVariables.white2),
            //                         child: Padding(
            //                           padding: const EdgeInsets.symmetric(
            //                               vertical: 2.0),
            //                           child: Align(
            //                             alignment: Alignment.center,
            //                             child: Text("Text Reply",
            //                                 style: TextStyles.priceType,
            //                                 textAlign: TextAlign.center),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ))
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.all(20.0),
            //           child: Stack(
            //             children: <Widget>[
            //               Container(
            //                   height: 110.0,
            //                   width: 132.0,
            //                   color: UniversalVariables.transparent),
            //               Positioned(
            //                   right: 1,
            //                   top: 1.0,
            //                   child: Column(
            //                     children: <Widget>[
            //                       GestureDetector(
            //                         onTap: () {
            //                           Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                               builder: (context) => ChatScreen(
            //                                 receiver: widget.selectedInfluencer,
            //                               ),
            //                             ),
            //                           );
            //                         },
            //                         child: Container(
            //                           height: 78.0,
            //                           width: 120.0,
            //                           decoration: BoxDecoration(

            //                               //gradient: UniversalVariables.fabGradient,

            //                               borderRadius: BorderRadius.only(
            //                                 topLeft: Radius.circular(10.0),
            //                                 topRight: Radius.circular(10.0),
            //                               ),
            //                               //color: UniversalVariables.white2
            //                               color: mC,
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                   color: mCD,
            //                                   offset: Offset(-10, 10),
            //                                   blurRadius: 10,
            //                                 ),
            //                                 BoxShadow(
            //                                   color: mCL,
            //                                   offset: Offset(0, -10),
            //                                   blurRadius: 10,
            //                                 ),
            //                               ]),
            //                           child: Padding(
            //                             padding: const EdgeInsets.symmetric(
            //                                 vertical: 2.0),
            //                             child: Align(
            //                               alignment: Alignment.center,
            //                               child: widget.selectedInfluencer
            //                                           .answerPrice2 !=
            //                                       null
            //                                   ? Text(
            //                                       "\$ ${widget.selectedInfluencer.answerPrice2}",
            //                                       style: TextStyles.priceNumber,
            //                                       textAlign: TextAlign.center)
            //                                   : Text("Not Set",
            //                                       style: TextStyles
            //                                           .notSetPriceNumber,
            //                                       textAlign: TextAlign.center),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 27.0,
            //                         width: 120.0,
            //                         decoration: BoxDecoration(
            //                             //gradient: UniversalVariables.fabGradient,
            //                             borderRadius: BorderRadius.only(
            //                               bottomLeft: Radius.circular(10.0),
            //                               bottomRight: Radius.circular(10.0),
            //                             ),
            //                             color: UniversalVariables.white2),
            //                         child: Padding(
            //                           padding: const EdgeInsets.symmetric(
            //                               vertical: 2.0),
            //                           child: Align(
            //                             alignment: Alignment.center,
            //                             child: Text("Video Reply",
            //                                 style: TextStyles.priceType,
            //                                 textAlign: TextAlign.center),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ))
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/search_screen");
      //   },
      //   backgroundColor: UniversalVariables.standardWhite,
      //   child: Icon(Icons.search, size: 45, color: UniversalVariables.grey2),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //     shape: CircularNotchedRectangle(),
      //     color: UniversalVariables.standardWhite,
      //     elevation: 9.0,
      //     clipBehavior: Clip.antiAlias,
      //     notchMargin: 6.0,
      //     child: Container(
      //       height: 60,
      //       child: Ink(
      // decoration: BoxDecoration(),
      // child: CupertinoTabBar(
      //   backgroundColor: Colors.transparent,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: GestureDetector(
      //             onTap: () {
      //               Navigator.pushNamed(context, "/home_screen");
      //             },
      //             child: Icon(Icons.home,
      //                 color: UniversalVariables.grey2))),
      //     BottomNavigationBarItem(
      //         icon: GestureDetector(
      //             onTap: () {
      //               //  Navigator.pushNamed(context, "/profile_screen");
      //             },
      //             child: Icon(Icons.person,
      //                 color: UniversalVariables.grey1))),
      //   ],
      //   //onTap: navigationTapped,
      //   //currentIndex: _page,
      // ),
      //       ),
      //     ),
      //   ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   return Scaffold(
  //     body: Stack(
  //       children: <Widget>[
  //         Container(
  //             height: screenHeight,
  //             width: screenWidth,
  //             color: Colors.transparent),
  //         Container(
  //           height: screenHeight - screenHeight / 3,
  //           width: screenWidth,
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //                 image: AssetImage('assets/surfing.jpg'), fit: BoxFit.cover),
  //           ),
  //         ),
  //         Positioned(
  //           top: screenHeight - (screenHeight / 2.5) - 25,
  //           child: Container(
  //             padding: EdgeInsets.only(left: 20.0),
  //             height: screenHeight / 3 + 25.0,
  //             width: screenWidth,
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(height: 25.0),
  //                   Text(
  //                     loggedInname != null ? loggedInname : "Add name",
  //                     style: TextStyles.theNameStyle,
  //                   ),
  //                   SizedBox(height: 7.0),
  //                   // Row(
  //                   //   children: <Widget>[
  //                   //     Text(
  //                   //       widget.selectedInfluencer.username,
  //                   //       style: TextStyles.usernameStyle,
  //                   //     ),
  //                   //     Icon(
  //                   //       Icons.verified_user,
  //                   //       color: UniversalVariables.gold2,
  //                   //       size: 20,
  //                   //     ),
  //                   //   ],
  //                   // ),
  //                   // Text('Santa Monica, CA',
  //                   // style: GoogleFonts.sourceSansPro(
  //                   //   fontSize: 15.0,
  //                   //   fontWeight: FontWeight.w400,
  //                   //   color: Color(0xFF5E5B54)
  //                   // )
  //                   // ),
  //                   SizedBox(height: 7.0),
  //                   Row(
  //                     children: <Widget>[
  //                       // SmoothStarRating(
  //                       //   allowHalfRating: false,
  //                       //   starCount: 5,
  //                       //   rating: 4.0,
  //                       //   size: 15.0,
  //                       //   color: Color(0xFFF36F32),
  //                       //   borderColor: Color(0xFFF36F32),
  //                       //   spacing:0.0
  //                       // ),
  //                       SizedBox(width: 3.0),
  //                       // Text('4.7',
  //                       //   style: GoogleFonts.sourceSansPro(
  //                       //           fontSize: 14.0,
  //                       //           fontWeight: FontWeight.w400,
  //                       //           color: Color(0xFFD57843)
  //                       //         )
  //                       // ),
  //                       // SizedBox(width: 3.0),
  //                       // Text('(200 Reviews)',
  //                       //   style: GoogleFonts.sourceSansPro(
  //                       //           fontSize: 14.0,
  //                       //           fontWeight: FontWeight.w400,
  //                       //           color: Color(0xFFC2C0B6)
  //                       //         )
  //                       // )
  //                     ],
  //                   ),
  //                   SizedBox(height: 5.0),
  //                   Text(loggedInbio != null ? loggedInbio : "Add bio",
  //                       style: GoogleFonts.sourceSansPro(
  //                           fontSize: 14.0,
  //                           fontWeight: FontWeight.w400,
  //                           color: Color(0xFF201F1C))),
  //                   SizedBox(height: 15.0),
  //                   // Text('Read More',
  //                   //   style: GoogleFonts.sourceSansPro(
  //                   //     fontSize: 14.0,
  //                   //     fontWeight: FontWeight.w400,
  //                   //     color: Color(0xFFF36F32)
  //                   //   )
  //                   // ),
  //                   SizedBox(height: 10.0),

  //                   // Container(
  //                   //   width: 325,
  //                   //   child: Row(
  //                   //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   //     children: [
  //                   //       Column(
  //                   //         crossAxisAlignment: CrossAxisAlignment.start,
  //                   //         children: <Widget>[
  //                   //           Container(
  //                   //             height: 75.0,
  //                   //             width: 150.0,
  //                   //             child: Center(
  //                   //                 child: Column(
  //                   //                     mainAxisAlignment:
  //                   //                         MainAxisAlignment.center,
  //                   //                     children: [
  //                   //                   Icon(
  //                   //                     Icons.text_format,
  //                   //                     color: Colors.white,
  //                   //                     size: 30,
  //                   //                   ),
  //                   //                   Text(Strings.TEXT_MESSAGE,
  //                   //                       style: GoogleFonts.sourceSansPro(
  //                   //                           fontSize: 12.0,
  //                   //                           fontWeight: FontWeight.w500,
  //                   //                           color: UniversalVariables
  //                   //                               .standardCream))
  //                   //                 ])),
  //                   //             decoration: BoxDecoration(
  //                   //                 borderRadius: BorderRadius.all(
  //                   //                   Radius.circular(35.0),
  //                   //                 ),
  //                   //                 color: UniversalVariables.standardPink),
  //                   //           )
  //                   //         ],
  //                   //       ),
  //                   //       Column(
  //                   //         crossAxisAlignment: CrossAxisAlignment.start,
  //                   //         children: <Widget>[
  //                   //           Container(
  //                   //             height: 75.0,
  //                   //             width: 150.0,
  //                   //             child: Center(
  //                   //                 child: Column(
  //                   //                     mainAxisAlignment:
  //                   //                         MainAxisAlignment.center,
  //                   //                     children: [
  //                   //                   Icon(
  //                   //                     Icons.videocam,
  //                   //                     color: Colors.white,
  //                   //                     size: 30,
  //                   //                   ),
  //                   //                   Text(Strings.VIDEO_MESSAGE,
  //                   //                       style: GoogleFonts.sourceSansPro(
  //                   //                           fontSize: 12.0,
  //                   //                           fontWeight: FontWeight.w500,
  //                   //                           color: UniversalVariables
  //                   //                               .standardCream))
  //                   //                 ])),
  //                   //             decoration: BoxDecoration(
  //                   //                 borderRadius: BorderRadius.all(
  //                   //                   Radius.circular(35.0),
  //                   //                 ),
  //                   //                 color: UniversalVariables.standardPink),
  //                   //           )
  //                   //         ],
  //                   //       ),
  //                   //     ],
  //                   //   ),
  //                   // )
  //                 ]),
  //             decoration: BoxDecoration(
  //               color: UniversalVariables.backgroundGrey,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(25.0),
  //                 topRight: Radius.circular(25.0),
  //               ),
  //             ),
  //           ),
  //         ),
  //         // Align(
  //         //     alignment: Alignment.bottomCenter,
  //         //     child: Container(
  //         //       height: 70.0,
  //         //       width: MediaQuery.of(context).size.width,
  //         //       child: Center(
  //         //           child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         //               //crossAxisAlignment: CrossAxisAlignment.stretch,
  //         //               children: [
  //         //             Icon(
  //         //               Icons.expand_less,
  //         //               color: Colors.white,
  //         //               size: 30,
  //         //             ),
  //         //             Icon(
  //         //               Icons.star_border,
  //         //               color: Colors.white,
  //         //               size: 30,
  //         //             ),
  //         //             Icon(
  //         //               Icons.expand_more,
  //         //               color: Colors.white,
  //         //               size: 30,
  //         //             ),
  //         //           ])),
  //         //       decoration: BoxDecoration(
  //         //           //borderRadius: BorderRadius.only(topLeft: Radius.circular(55.0)),
  //         //           color: UniversalVariables.standardWhite),
  //         //     ),
  //         //     ),
  //         Align(
  //           alignment: Alignment.topLeft,
  //           child: Padding(
  //             padding: EdgeInsets.only(left: 15.0, top: 30.0),
  //             child: GestureDetector(
  //               onTap: () => {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => HomeScreen(),
  //                   ),
  //                 ),
  //               },
  //               child: Container(
  //                 height: 40.0,
  //                 width: 40.0,
  //                 decoration: BoxDecoration(
  //                     shape: BoxShape.circle, color: UniversalVariables.white2),
  //                 child: Center(
  //                   child: Icon(Icons.arrow_back,
  //                       size: 20.0, color: UniversalVariables.grey1),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 15.0, top: 30.0, right: 15.0),
          //     child: GestureDetector(
          //       onTap: () => {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => EditProfile(),
          //           ),
          //         ),
          //       },
          //       child: Container(
          //         height: 40.0,
          //         width: 40.0,
          //         decoration: BoxDecoration(
          //             shape: BoxShape.circle, color: UniversalVariables.white2),
          //         child: Center(
          //           child: Icon(Icons.edit,
          //               size: 20.0, color: UniversalVariables.grey1),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
  //         // Positioned(
  //         //   top: (screenHeight - screenHeight / 3) / 2,
  //         //   left: (screenWidth /2) - 75.0,
  //         //   child: Container(
  //         //     height: 40.0,
  //         //     width: 150.0,
  //         //     decoration: BoxDecoration(
  //         //       color: Color(0xFFA4B2AE),
  //         //       borderRadius: BorderRadius.circular(20.0)
  //         //     ),
  //         //     child: Center(
  //         //       child: Text('Add Your intro video here',
  //         //       style: GoogleFonts.sourceSansPro(
  //         //         fontSize: 14.0,
  //         //         fontWeight: FontWeight.w500,
  //         //         color: Colors.white
  //         //       )
  //         //       )
  //         //     )
  //         //   )
  //         // ),
  //         Positioned(
  //           top: screenHeight - screenHeight / 2.5 - 65.0,
  //           right: 35.0,
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 height: 100.0,
  //                 width: 100.0,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     image: NetworkImage(loggedInprofilePhoto != null
  //                         ? loggedInprofilePhoto
  //                         : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Crystal_Clear_kdm_user_female.svg/1200px-Crystal_Clear_kdm_user_female.svg.png"),
  //                     fit: BoxFit.cover,
  //                   ),
  //                   borderRadius: BorderRadius.circular(15.0),
  //                 ),
  //               ),
  //               SizedBox(height: 5),
  //               Container(
  //                 child: Row(
  //                   children: <Widget>[
  //                     Text(
  //                       loggedInusername != null
  //                           ? loggedInusername
  //                           : "Add username",
  //                       style: TextStyles.usernameStyleEnd,
  //                     ),
  //                     Icon(
  //                       Icons.verified_user,
  //                       color: UniversalVariables.gold2,
  //                       size: 20,
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),

  //         Positioned(
  //           top: screenHeight - screenHeight / 4,
  //           left: 10,
  //           right: 10,
  //           child: Container(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       mainAxisSize: MainAxisSize.max,
  //                       children: <Widget>[
  //                         GestureDetector(
  //                           onTap: () {
  //                            Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => SettingsScreen(),
  //                   ),
  //                 );
  //                           },
  //                           child: Container(
  //                             height: 80.0,
  //                             width: screenWidth / 4,
  //                             decoration: BoxDecoration(

  //                                 //gradient: UniversalVariables.fabGradient,

  //                                 borderRadius: BorderRadius.only(
  //                                   topLeft: Radius.circular(10.0),
  //                                   topRight: Radius.circular(10.0),
  //                                   bottomLeft: Radius.circular(5.0),
  //                                   bottomRight: Radius.circular(5.0),
  //                                 ),
  //                                 //color: UniversalVariables.white2
  //                                 color: mC,
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: mCD,
  //                                     offset: Offset(-10, 10),
  //                                     blurRadius: 10,
  //                                   ),
  //                                   BoxShadow(
  //                                     color: mCL,
  //                                     offset: Offset(0, -10),
  //                                     blurRadius: 10,
  //                                   ),
  //                                 ]),
  //                             child: Column(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceAround,
  //                               children: <Widget>[
  //                                 Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 2.0),
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         vertical: 2.0),
  //                                     child: Align(
  //                                       alignment: Alignment.center,
  //                                       child: Text("Text Reply",
  //                                           style: TextStyles.priceType,
  //                                           textAlign: TextAlign.center),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 2.0),
  //                                   child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: loggedInanswerPrice1 !=
  //                                             null
  //                                         ? Text(
  //                                             "\$ ${loggedInanswerPrice1}",
  //                                             style: TextStyles.priceNumber,
  //                                             textAlign: TextAlign.center)
  //                                         : Text("Not Set",
  //                                             style:
  //                                                 TextStyles.notSetPriceNumber,
  //                                             textAlign: TextAlign.center),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => SettingsScreen(),
  //                   ),
  //                 );
  //                           },
  //                           child: Container(
  //                             height: 80.0,
  //                             width: screenWidth / 4,
  //                             decoration: BoxDecoration(

  //                                 //gradient: UniversalVariables.fabGradient,

  //                                 borderRadius: BorderRadius.only(
  //                                   topLeft: Radius.circular(10.0),
  //                                   topRight: Radius.circular(10.0),
  //                                   bottomLeft: Radius.circular(5.0),
  //                                   bottomRight: Radius.circular(5.0),
  //                                 ),
  //                                 //color: UniversalVariables.white2
  //                                 color: mC,
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: mCD,
  //                                     offset: Offset(-10, 10),
  //                                     blurRadius: 10,
  //                                   ),
  //                                   BoxShadow(
  //                                     color: mCL,
  //                                     offset: Offset(0, -10),
  //                                     blurRadius: 10,
  //                                   ),
  //                                 ]),
  //                             child: Column(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceAround,
  //                               children: <Widget>[
  //                                 Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 2.0),
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         vertical: 2.0),
  //                                     child: Align(
  //                                       alignment: Alignment.center,
  //                                       child: Text("Video Reply",
  //                                           style: TextStyles.priceType,
  //                                           textAlign: TextAlign.center),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 2.0),
  //                                   child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: loggedInanswerPrice2 !=
  //                                             null
  //                                         ? Text(
  //                                             "\$ ${loggedInanswerPrice2}",
  //                                             style: TextStyles.priceNumber,
  //                                             textAlign: TextAlign.center)
  //                                         : Text("Not Set",
  //                                             style:
  //                                                 TextStyles.notSetPriceNumber,
  //                                             textAlign: TextAlign.center),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => SettingsScreen(),
  //                   ),
  //                 );
  //                           },
  //                           child: Container(
  //                             height: 80.0,
  //                             width: screenWidth / 4,
  //                             decoration: BoxDecoration(

  //                                 //gradient: UniversalVariables.fabGradient,

  //                                 borderRadius: BorderRadius.only(
  //                                   topLeft: Radius.circular(10.0),
  //                                   topRight: Radius.circular(10.0),
  //                                   bottomLeft: Radius.circular(5.0),
  //                                   bottomRight: Radius.circular(5.0),
  //                                 ),
  //                                 //color: UniversalVariables.white2
  //                                 color: mC,
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: mCD,
  //                                     offset: Offset(-10, 10),
  //                                     blurRadius: 10,
  //                                   ),
  //                                   BoxShadow(
  //                                     color: mCL,
  //                                     offset: Offset(0, -10),
  //                                     blurRadius: 10,
  //                                   ),
  //                                 ]),
  //                             child: Column(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceAround,
  //                               children: <Widget>[
  //                                 Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 2.0),
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         vertical: 2.0),
  //                                     child: Align(
  //                                       alignment: Alignment.center,
  //                                       child: Text("Videocall",
  //                                           style: TextStyles.priceType,
  //                                           textAlign: TextAlign.center),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 2.0),
  //                                   child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: loggedInanswerPrice3 !=
  //                                             null
  //                                         ? Text(
  //                                             "\$ ${loggedInanswerPrice3}",
  //                                             style: TextStyles.priceNumber,
  //                                             textAlign: TextAlign.center)
  //                                         : Text("Not Set",
  //                                             style:
  //                                                 TextStyles.notSetPriceNumber,
  //                                             textAlign: TextAlign.center),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //         //     child: Row(
  //         //       children: <Widget>[
  //         //         Padding(
  //         //           padding: EdgeInsets.all(20.0),
  //         //           child: Stack(
  //         //             children: <Widget>[
  //         //               Container(
  //         //                   height: 110.0,
  //         //                   width: 120.0,
  //         //                   color: UniversalVariables.transparent),
  //         //               Positioned(
  //         //                   left: 1.0,
  //         //                   top: 1.0,
  //         //                   child: Column(
  //         //                     children: <Widget>[
  //         //                       Container(
  //         //                         height: 55.0,
  //         //                         width: 115.0,
  //         //                         decoration: BoxDecoration(

  //         //                             //gradient: UniversalVariables.fabGradient,

  //         //                             borderRadius: BorderRadius.only(
  //         //                               topLeft: Radius.circular(10.0),
  //         //                               topRight: Radius.circular(10.0),
  //         //                             ),
  //         //                             //color: UniversalVariables.white2
  //         //                             color: mC,
  //         //                             boxShadow: [
  //         //                               BoxShadow(
  //         //                                 color: mCD,
  //         //                                 offset: Offset(10, 10),
  //         //                                 blurRadius: 10,
  //         //                               ),
  //         //                               BoxShadow(
  //         //                                 color: mCL,
  //         //                                 offset: Offset(-10, -10),
  //         //                                 blurRadius: 10,
  //         //                               ),
  //         //                             ]),
  //         //                         child: Padding(
  //         //                           padding: const EdgeInsets.symmetric(
  //         //                               vertical: 2.0),
  //         //                           child: Align(
  //         //                             alignment: Alignment.center,
  //         //                             child: loggedInanswerPrice1 != null
  //         //                                 ? Text("\$ $loggedInanswerPrice1",
  //         //                                     style: TextStyles.priceNumber,
  //         //                                     textAlign: TextAlign.center)
  //         //                                 : Text("\$0",
  //         //                                     style: TextStyles.priceNumber,
  //         //                                     textAlign: TextAlign.center),
  //         //                           ),
  //         //                         ),
  //         //                       ),
  //         //                       Container(
  //         //                         height: 27.0,
  //         //                         width: 115.0,
  //         //                         decoration: BoxDecoration(
  //         //                             //gradient: UniversalVariables.fabGradient,
  //         //                             borderRadius: BorderRadius.only(
  //         //                               bottomLeft: Radius.circular(10.0),
  //         //                               bottomRight: Radius.circular(10.0),
  //         //                             ),
  //         //                             color: UniversalVariables.white2),
  //         //                         child: Padding(
  //         //                           padding: const EdgeInsets.symmetric(
  //         //                               vertical: 2.0),
  //         //                           child: Align(
  //         //                             alignment: Alignment.center,
  //         //                             child: Text("Text Reply",
  //         //                                 style: TextStyles.priceType,
  //         //                                 textAlign: TextAlign.center),
  //         //                           ),
  //         //                         ),
  //         //                       ),
  //         //                     ],
  //         //                   ))
  //         //             ],
  //         //           ),
  //         //         ),
  //         //         Padding(
  //         //           padding: EdgeInsets.all(20.0),
  //         //           child: Stack(
  //         //             children: <Widget>[
  //         //               Container(
  //         //                   height: 110.0,
  //         //                   width: 125.0,
  //         //                   color: UniversalVariables.transparent),
  //         //               Positioned(
  //         //                   left: 1.0,
  //         //                   top: 1.0,
  //         //                   child: Column(
  //         //                     children: <Widget>[
  //         //                       Container(
  //         //                         height: 55.0,
  //         //                         width: 120.0,
  //         //                         decoration: BoxDecoration(

  //         //                             //gradient: UniversalVariables.fabGradient,

  //         //                             borderRadius: BorderRadius.only(
  //         //                               topLeft: Radius.circular(10.0),
  //         //                               topRight: Radius.circular(10.0),
  //         //                             ),
  //         //                             //color: UniversalVariables.white2
  //         //                             color: mC,
  //         //                             boxShadow: [
  //         //                               BoxShadow(
  //         //                                 color: mCD,
  //         //                                 offset: Offset(10, 10),
  //         //                                 blurRadius: 10,
  //         //                               ),
  //         //                               BoxShadow(
  //         //                                 color: mCL,
  //         //                                 offset: Offset(-10, -10),
  //         //                                 blurRadius: 10,
  //         //                               ),
  //         //                             ]),
  //         //                         child: Padding(
  //         //                           padding: const EdgeInsets.symmetric(
  //         //                               vertical: 2.0),
  //         //                           child: Align(
  //         //                             alignment: Alignment.center,
  //         //                             child: loggedInanswerPrice2 != null
  //         //                                 ? Text("\$ $loggedInanswerPrice2",
  //         //                                     style: TextStyles.priceNumber,
  //         //                                     textAlign: TextAlign.center)
  //         //                                 : Text("\$0",
  //         //                                     style: TextStyles.priceNumber,
  //         //                                     textAlign: TextAlign.center),
  //         //                           ),
  //         //                         ),
  //         //                       ),
  //         //                       Container(
  //         //                         height: 27.0,
  //         //                         width: 120.0,
  //         //                         decoration: BoxDecoration(
  //         //                             //gradient: UniversalVariables.fabGradient,
  //         //                             borderRadius: BorderRadius.only(
  //         //                               bottomLeft: Radius.circular(10.0),
  //         //                               bottomRight: Radius.circular(10.0),
  //         //                             ),
  //         //                             color: UniversalVariables.white2),
  //         //                         child: Padding(
  //         //                           padding: const EdgeInsets.symmetric(
  //         //                               vertical: 2.0),
  //         //                           child: Align(
  //         //                             alignment: Alignment.center,
  //         //                             child: Text("Video Reply",
  //         //                                 style: TextStyles.priceType,
  //         //                                 textAlign: TextAlign.center),
  //         //                           ),
  //         //                         ),
  //         //                       ),
  //         //                     ],
  //         //                   ))
  //         //             ],
  //         //           ),
  //         //         ),
  //         //       ],
  //         //     ),
  //           ),
          
  //       ],
  //     ),
  //     // floatingActionButton: Visibility(
  //     //   child: FloatingActionButton(
  //     //     onPressed: () {
  //     //       Navigator.pushNamed(context, "/search_screen");
  //     //     },
  //     //     backgroundColor: UniversalVariables.standardWhite,
  //     //     child: Icon(Icons.search, size: 45, color: UniversalVariables.grey2),
  //     //   ),
  //     // ),
  //     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //     // bottomNavigationBar: Visibility(
  //     //   child: BottomAppBar(
  //     //     shape: CircularNotchedRectangle(),
  //     //     color: UniversalVariables.standardWhite,
  //     //     elevation: 9.0,
  //     //     clipBehavior: Clip.antiAlias,
  //     //     notchMargin: 6.0,
  //     //     child: Container(
  //     //       height: 60,
  //     //       child: Ink(
  //     //         decoration: BoxDecoration(),
  //     //         child: CupertinoTabBar(
  //     //           backgroundColor: Colors.transparent,
  //     //           items: <BottomNavigationBarItem>[
  //     //             BottomNavigationBarItem(
  //     //                 icon: GestureDetector(
  //     //                   onTap: () {
  //     //                       Navigator.pushNamed(
  //     //                           context, "/home_screen");
  //     //                     },
  //     //                     child: Icon(Icons.home, color: UniversalVariables.grey2))),
  //     //             BottomNavigationBarItem(
  //     //                 icon: GestureDetector(
  //     //                     onTap: () {
  //     //                       // Navigator.pushNamed(
  //     //                       //     context, "/profile_screen");
  //     //                     },
  //     //                     child: Icon(Icons.person,
  //     //                         color: UniversalVariables.grey2))),
  //     //           ],
  //     //           //onTap: navigationTapped,
  //     //           //currentIndex: _page,
  //     //         ),
  //     //       ),
  //     //     ),
  //     //   ),
  //     // ),
  //   );
  // }
}
