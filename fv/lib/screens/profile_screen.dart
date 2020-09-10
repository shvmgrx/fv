// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/models/order.dart';
import 'package:fv/onboarding/strings.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/screens/settingsScreen.dart';
import 'package:fv/utils/utilities.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:gradient_text/gradient_text.dart';
// import 'package:fv/models/user.dart';
// import 'package:fv/onboarding/strings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/editProfile.dart';
// import 'package:fv/screens/home_screen.dart';
// import 'package:fv/screens/influencer_detail.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
// import 'package:fv/screens/landing_screen.dart';
// import 'package:fv/screens/list_influencer.dart';
// import 'package:fv/screens/pageviews/chat_list_screen.dart';
import 'package:fv/utils/universal_variables.dart';
// import 'package:fv/widgets/goldMask.dart';
import 'package:fv/widgets/nmBox.dart';
// import 'package:fv/widgets/nmButton.dart';
// import 'package:fv/widgets/nmCard.dart';
// import 'package:fv/widgets/slideRoute.dart';
// import 'package:flutter/services.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
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
  Map loggedUserTimeSlots;

  DateTime ts1;
  DateTime ts2;
  DateTime ts3;
  DateTime ts4;
  DateTime ts5;
  DateTime ts6;
  DateTime ts7;

  int ts1Duration;
  int ts2Duration;
  int ts3Duration;
  int ts4Duration;
  int ts5Duration;
  int ts6Duration;
  int ts7Duration;

  String ts1orderId;
  String ts2orderId;
  String ts3orderId;
  String ts4orderId;
  String ts5orderId;
  String ts6orderId;
  String ts7orderId;

  bool ts1Bought = false;
  bool ts2Bought = false;
  bool ts3Bought = false;
  bool ts4Bought = false;
  bool ts5Bought = false;
  bool ts6Bought = false;
  bool ts7Bought = false;

  bool showts1 = false;
  bool showts2 = false;
  bool showts3 = false;
  bool showts4 = false;
  bool showts5 = false;
  bool showts6 = false;
  bool showts7 = false;

  List<Order> sellerOrderList;
  List<String> compareList = [];

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
          loggedIninfReceived = loggedUser['infReceived'];
          loggedInisInfluencer = loggedUser['isInfluencer'];
          loggedUserTimeSlots = loggedUser['timeSlots'];

          if (loggedInisInfluencer == true) {
            if (loggedUserTimeSlots['ttSlots'][0] != null) {
              ts1 = loggedUserTimeSlots['ttSlots'][0] != null
                  ? loggedUserTimeSlots['ttSlots'][0].toDate()
                  : null;

              ts1Duration = loggedUserTimeSlots['ttDurations'][0] != null
                  ? loggedUserTimeSlots['ttDurations'][0]
                  : 0;
            }

            if (loggedUserTimeSlots['ttSlots'][1] != null) {
              ts2 = loggedUserTimeSlots['ttSlots'][1] != null
                  ? loggedUserTimeSlots['ttSlots'][1].toDate()
                  : null;

              ts2Duration = loggedUserTimeSlots['ttDurations'][1] != null
                  ? loggedUserTimeSlots['ttDurations'][1]
                  : 0;
            }

            if (loggedUserTimeSlots['ttSlots'][2] != null) {
              ts3 = loggedUserTimeSlots['ttSlots'][2] != null
                  ? loggedUserTimeSlots['ttSlots'][2].toDate()
                  : null;

              ts3Duration = loggedUserTimeSlots['ttDurations'][2] != null
                  ? loggedUserTimeSlots['ttDurations'][2]
                  : 0;
            }

            if (loggedUserTimeSlots['ttSlots'][3] != null) {
              ts4 = loggedUserTimeSlots['ttSlots'][3] != null
                  ? loggedUserTimeSlots['ttSlots'][3].toDate()
                  : null;

              ts4Duration = loggedUserTimeSlots['ttDurations'][3] != null
                  ? loggedUserTimeSlots['ttDurations'][3]
                  : 0;
            }

            if (loggedUserTimeSlots['ttSlots'][4] != null) {
              ts5 = loggedUserTimeSlots['ttSlots'][4] != null
                  ? loggedUserTimeSlots['ttSlots'][4].toDate()
                  : null;

              ts5Duration = loggedUserTimeSlots['ttDurations'][4] != null
                  ? loggedUserTimeSlots['ttDurations'][4]
                  : 0;
            }

            if (loggedUserTimeSlots['ttSlots'][5] != null) {
              ts6 = loggedUserTimeSlots['ttSlots'][5] != null
                  ? loggedUserTimeSlots['ttSlots'][5].toDate()
                  : null;

              ts6Duration = loggedUserTimeSlots['ttDurations'][5] != null
                  ? loggedUserTimeSlots['ttDurations'][5]
                  : 0;
            }

            if (loggedUserTimeSlots['ttSlots'][6] != null) {
              ts7 = loggedUserTimeSlots['ttSlots'][6] != null
                  ? loggedUserTimeSlots['ttSlots'][6].toDate()
                  : null;
              ts7Duration = loggedUserTimeSlots['ttDurations'][6] != null
                  ? loggedUserTimeSlots['ttDurations'][6]
                  : 0;
            }

            ts1orderId = loggedUserTimeSlots['ttIds'][0] != null
                ? loggedUserTimeSlots['ttIds'][0]
                : null;
            ts2orderId = loggedUserTimeSlots['ttIds'][1] != null
                ? loggedUserTimeSlots['ttIds'][1]
                : null;
            ts3orderId = loggedUserTimeSlots['ttIds'][2] != null
                ? loggedUserTimeSlots['ttIds'][2]
                : null;
            ts4orderId = loggedUserTimeSlots['ttIds'][3] != null
                ? loggedUserTimeSlots['ttIds'][3]
                : null;
            ts5orderId = loggedUserTimeSlots['ttIds'][4] != null
                ? loggedUserTimeSlots['ttIds'][4]
                : null;
            ts6orderId = loggedUserTimeSlots['ttIds'][5] != null
                ? loggedUserTimeSlots['ttIds'][5]
                : null;
            ts7orderId = loggedUserTimeSlots['ttIds'][6] != null
                ? loggedUserTimeSlots['ttIds'][6]
                : null;
          }

          if (ts1 != null) {
            var now = DateTime.now();

            var t = loggedUserTimeSlots['ttSlots'][0].seconds;
            var t1 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

            if (t1.isBefore(now)) {
              showts1 = false;
            } else if (now.isBefore(t1)) {
              showts1 = true;
            }
          }

          if (ts2 != null) {
            var now = DateTime.now();

            var t = loggedUserTimeSlots['ttSlots'][0].seconds;
            var t2 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

            if (t2.isBefore(now)) {
              showts2 = false;
            } else if (now.isBefore(t2)) {
              showts2 = true;
            }
          }

          if (ts3 != null) {
            var now = DateTime.now();

            var t = loggedUserTimeSlots['ttSlots'][0].seconds;
            var t3 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

            if (t3.isBefore(now)) {
              showts3 = false;
            } else if (now.isBefore(t3)) {
              showts3 = true;
            }
          }

          if (ts4 != null) {
            var now = DateTime.now();

            var t = loggedUserTimeSlots['ttSlots'][0].seconds;
            var t4 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

            if (t4.isBefore(now)) {
              showts4 = false;
            } else if (now.isBefore(t4)) {
              showts4 = true;
            }
          }

          if (ts5 != null) {
            var now = DateTime.now();

            var t = loggedUserTimeSlots['ttSlots'][0].seconds;
            var t5 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

            if (t5.isBefore(now)) {
              showts5 = false;
            } else if (now.isBefore(t5)) {
              showts5 = true;
            }
          }

          if (ts6 != null) {
            var now = DateTime.now();

            var t = loggedUserTimeSlots['ttSlots'][0].seconds;
            var t6 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

            if (t6.isBefore(now)) {
              showts6 = false;
            } else if (now.isBefore(t6)) {
              showts6 = true;
            }
          }

          if (ts7 != null) {
            var now = DateTime.now();

            var t = loggedUserTimeSlots['ttSlots'][0].seconds;
            var t7 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

            if (t7.isBefore(now)) {
              showts7 = false;
            } else if (now.isBefore(t7)) {
              showts7 = true;
            }
          }
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
    getIVideoOrders();
    super.initState();
  }

  void getIVideoOrders() {
    _repository.fetchSellerOrders(loggedInuid).then((List<Order> list) {
      setState(() {
        sellerOrderList = list;
      });

      for (int i = 0; i < sellerOrderList.length; i++) {
        setState(() {
          compareList.add(sellerOrderList[i].uid);
        });
      }

      for (int i = 0; i < compareList.length; i++) {
        print(compareList[i]);
        //case1
        if (loggedUserTimeSlots['ttIds'][0] == compareList[i]) {
          setState(() {
            ts1Bought = true;
          });
        }
        if (loggedUserTimeSlots['ttIds'][1] == compareList[i]) {
          setState(() {
            ts2Bought = true;
          });
        }
        if (loggedUserTimeSlots['ttIds'][2] == compareList[i]) {
          setState(() {
            ts3Bought = true;
          });
        }
        if (loggedUserTimeSlots['ttIds'][3] == compareList[i]) {
          setState(() {
            ts4Bought = true;
          });
        }
        if (loggedUserTimeSlots['ttIds'][4] == compareList[i]) {
          setState(() {
            ts5Bought = true;
          });
        }
        if (loggedUserTimeSlots['ttIds'][5] == compareList[i]) {
          setState(() {
            ts6Bought = true;
          });
        }
        if (loggedUserTimeSlots['ttIds'][6] == compareList[i]) {
          setState(() {
            ts7Bought = true;
          });
        }
      }
    });
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
    //bool showAppBar = true;

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
            Visibility(
              visible:
                  loggedInisInfluencer != null ? loggedInisInfluencer : false,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 30.0, right: 65.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    ),
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: UniversalVariables.white2),
                      child: Center(
                        child: Icon(CupertinoIcons.settings,
                            size: 30.0, color: UniversalVariables.grey1),
                      ),
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  ),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalVariables.white2),
                    child: Center(
                      child: Icon(CupertinoIcons.pen,
                          size: 20.0, color: UniversalVariables.grey1),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: loggedInisInfluencer
                  ? screenHeight -
                      (screenHeight / 2.5) -
                      (controller.value * screenHeight * 0.4) -
                      55
                  : screenHeight -
                      (screenHeight / 2) -
                      (controller.value * 100) +
                      120,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
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
                                  visible: loggedInisInfluencer != null
                                      ? loggedInisInfluencer
                                      : false,
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
                                            child: loggedInanswerPrice1 != null
                                                ? Text(
                                                    "\$ $loggedInanswerPrice1",
                                                    style:
                                                        TextStyles.priceNumber,
                                                    textAlign: TextAlign.center)
                                                : Text("Not Set",
                                                    style: TextStyles
                                                        .notSetPriceNumber,
                                                    textAlign:
                                                        TextAlign.center),
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
                                  visible: loggedInisInfluencer != null
                                      ? loggedInisInfluencer
                                      : false,
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
                                            child: loggedInanswerPrice2 != null
                                                ? Text(
                                                    "\$ $loggedInanswerPrice2",
                                                    style:
                                                        TextStyles.priceNumber,
                                                    textAlign: TextAlign.center)
                                                : Text("Not Set",
                                                    style: TextStyles
                                                        .notSetPriceNumber,
                                                    textAlign:
                                                        TextAlign.center),
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
                                  visible: loggedInisInfluencer != null
                                      ? loggedInisInfluencer
                                      : false,
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
                                            child: loggedInanswerPrice3 != null
                                                ? Text(
                                                    "\$ $loggedInanswerPrice3",
                                                    style:
                                                        TextStyles.priceNumber,
                                                    textAlign: TextAlign.center)
                                                : Text("Not Set",
                                                    style: TextStyles
                                                        .notSetPriceNumber,
                                                    textAlign:
                                                        TextAlign.center),
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
                      ),
                      SizedBox(height: 15),

                      loggedInisInfCert && (loggedUserTimeSlots != null)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                height: screenHeight * 0.9,
                                width: screenWidth * 0.9,
                                color: UniversalVariables.transparent,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: <Widget>[
                                      Visibility(
                                        visible: showts1,
                                        //  visible: true,
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //   color:
                                          //    //   UniversalVariables.white2,
                                          //   //borderRadius: BorderRadius.only(
                                          //     // topLeft: Radius.circular(100),
                                          //     // topRight: Radius.circular(100),
                                          //     //   bottomLeft: Radius.circular(10),
                                          //     //   bottomRight: Radius.circular(10),
                                          //   ),
                                          // ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 20, bottom: 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ts1 != null
                                                    ? Text(
                                                        "${DateFormat('MMM d, kk:mm').format(ts1)}",
                                                        style: TextStyles
                                                            .timeTextDetailStyle)
                                                    : Text("",
                                                        style: TextStyles
                                                            .timeTextDetailStyle),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: ts1Duration != null
                                                      ? Text(
                                                          "${Utils.getDuration(ts1Duration)}",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle)
                                                      : Text("10 mins",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    // color:Colors.orange,
                                                    // width: 75,
                                                    decoration: BoxDecoration(
                                                      color: ts1Bought
                                                          ? UniversalVariables
                                                              .offline
                                                          : UniversalVariables
                                                              .online,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: UniversalVariables
                                                                .standardWhite,
                                                          ),
                                                          ts1Bought
                                                              ? Text(
                                                                  ConStrings
                                                                      .bought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails)
                                                              : Text(
                                                                  ConStrings
                                                                      .notBought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: showts2,
                                        //  visible: true,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 20, bottom: 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ts2 != null
                                                    ? Text(
                                                        "${DateFormat('MMM d, kk:mm').format(ts2)}",
                                                        style: TextStyles
                                                            .timeTextDetailStyle)
                                                    : Text("",
                                                        style: TextStyles
                                                            .timeTextDetailStyle),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: ts2Duration != null
                                                      ? Text(
                                                          "${Utils.getDuration(ts2Duration)}",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle)
                                                      : Text("10 mins",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    // color:Colors.orange,
                                                    // width: 75,
                                                    decoration: BoxDecoration(
                                                      color: ts2Bought
                                                          ? UniversalVariables
                                                              .offline
                                                          : UniversalVariables
                                                              .online,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: UniversalVariables
                                                                .standardWhite,
                                                          ),
                                                          ts2Bought
                                                              ? Text(
                                                                  ConStrings
                                                                      .bought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails)
                                                              : Text(
                                                                  ConStrings
                                                                      .notBought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: showts3,
                                        // visible: true,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 20, bottom: 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ts3 != null
                                                    ? Text(
                                                        "${DateFormat('MMM d, kk:mm').format(ts3)}",
                                                        style: TextStyles
                                                            .timeTextDetailStyle)
                                                    : Text("",
                                                        style: TextStyles
                                                            .timeTextDetailStyle),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: ts3Duration != null
                                                      ? Text(
                                                          "${Utils.getDuration(ts3Duration)}",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle)
                                                      : Text("10 mins",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    // color:Colors.orange,
                                                    // width: 75,
                                                    decoration: BoxDecoration(
                                                      color: ts3Bought
                                                          ? UniversalVariables
                                                              .offline
                                                          : UniversalVariables
                                                              .online,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: UniversalVariables
                                                                .standardWhite,
                                                          ),
                                                          ts3Bought
                                                              ? Text(
                                                                  ConStrings
                                                                      .bought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails)
                                                              : Text(
                                                                  ConStrings
                                                                      .notBought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: showts4,
                                        // visible: true,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 20, bottom: 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ts4 != null
                                                    ? Text(
                                                        "${DateFormat('MMM d, kk:mm').format(ts4)}",
                                                        style: TextStyles
                                                            .timeTextDetailStyle)
                                                    : Text("",
                                                        style: TextStyles
                                                            .timeTextDetailStyle),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: ts4Duration != null
                                                      ? Text(
                                                          "${Utils.getDuration(ts4Duration)}",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle)
                                                      : Text("10 mins",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    // color:Colors.orange,
                                                    // width: 75,
                                                    decoration: BoxDecoration(
                                                      color: ts4Bought
                                                          ? UniversalVariables
                                                              .offline
                                                          : UniversalVariables
                                                              .online,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: UniversalVariables
                                                                .standardWhite,
                                                          ),
                                                          ts4Bought
                                                              ? Text(
                                                                  ConStrings
                                                                      .bought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails)
                                                              : Text(
                                                                  ConStrings
                                                                      .notBought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: showts5,
                                        //  visible: true,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 20, bottom: 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ts5 != null
                                                    ? Text(
                                                        "${DateFormat('MMM d, kk:mm').format(ts5)}",
                                                        style: TextStyles
                                                            .timeTextDetailStyle)
                                                    : Text("",
                                                        style: TextStyles
                                                            .timeTextDetailStyle),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: ts6Duration != null
                                                      ? Text(
                                                          "${Utils.getDuration(ts5Duration)}",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle)
                                                      : Text("10 mins",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    // color:Colors.orange,
                                                    // width: 75,
                                                    decoration: BoxDecoration(
                                                      color: ts5Bought
                                                          ? UniversalVariables
                                                              .offline
                                                          : UniversalVariables
                                                              .online,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: UniversalVariables
                                                                .standardWhite,
                                                          ),
                                                          ts5Bought
                                                              ? Text(
                                                                  ConStrings
                                                                      .bought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails)
                                                              : Text(
                                                                  ConStrings
                                                                      .notBought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: showts6,
                                        // visible: true,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 20, bottom: 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ts6 != null
                                                    ? Text(
                                                        "${DateFormat('MMM d, kk:mm').format(ts6)}",
                                                        style: TextStyles
                                                            .timeTextDetailStyle)
                                                    : Text("",
                                                        style: TextStyles
                                                            .timeTextDetailStyle),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: ts6Duration != null
                                                      ? Text(
                                                          "${Utils.getDuration(ts6Duration)}",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle)
                                                      : Text("10 mins",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    // color:Colors.orange,
                                                    // width: 75,
                                                    decoration: BoxDecoration(
                                                      color: ts6Bought
                                                          ? UniversalVariables
                                                              .offline
                                                          : UniversalVariables
                                                              .online,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: UniversalVariables
                                                                .standardWhite,
                                                          ),
                                                          ts6Bought
                                                              ? Text(
                                                                  ConStrings
                                                                      .bought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails)
                                                              : Text(
                                                                  ConStrings
                                                                      .notBought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: showts7,
                                        // visible: true,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 20, bottom: 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                ts7 != null
                                                    ? Text(
                                                        "${DateFormat('MMM d, kk:mm').format(ts7)}",
                                                        style: TextStyles
                                                            .timeTextDetailStyle)
                                                    : Text("",
                                                        style: TextStyles
                                                            .timeTextDetailStyle),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: ts7Duration != null
                                                      ? Text(
                                                          "${Utils.getDuration(ts7Duration)}",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle)
                                                      : Text("10 mins",
                                                          style: TextStyles
                                                              .timeDurationDetailStyle),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    // color:Colors.orange,
                                                    // width: 75,
                                                    decoration: BoxDecoration(
                                                      color: ts7Bought
                                                          ? UniversalVariables
                                                              .offline
                                                          : UniversalVariables
                                                              .online,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: UniversalVariables
                                                                .standardWhite,
                                                          ),
                                                          ts7Bought
                                                              ? Text(
                                                                  ConStrings
                                                                      .bought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails)
                                                              : Text(
                                                                  ConStrings
                                                                      .notBought,
                                                                  style: TextStyles
                                                                      .timeSlotDetails),
                                                        ],
                                                      ),
                                                    ),
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
                              ),
                            )
                          : Container(
                              width: screenWidth * 0.9,

                              // child: OutlineButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => SettingsScreen(),
                              //       ),
                              //     );
                              //   },
                              //   focusColor: UniversalVariables.standardWhite,
                              //   // borderSide: BorderSide.solid,
                              //   child:
                              //       Text("", style: TextStyles.verifiedStyle),
                              // ),

                              child: Center(
                                  child: loggedInisInfluencer
                                      ? OutlineButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SettingsScreen(),
                                              ),
                                            );
                                          },
                                          focusColor:
                                              UniversalVariables.standardWhite,
                                          // borderSide: BorderSide.solid,
                                          child: Text(ConStrings.ADDTS,
                                              style: TextStyles.verifiedStyle),
                                        )
                                      : Text(ConStrings.UPCOMINGFAVS,
                                          style: TextStyles.verifiedStyle)),
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

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 30.0),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                    )
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
              top: loggedInisInfluencer
                  ? screenHeight -
                      screenHeight / 2.5 -
                      65.0 -
                      (controller.value * screenHeight * 0.35) -
                      55
                  : screenHeight -
                      screenHeight / 2.5 -
                      65.0 -
                      (controller.value * 100) +
                      60,
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
                          image: NetworkImage(loggedInprofilePhoto),
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
          ],
        ),
      ),
    );
  }
}
