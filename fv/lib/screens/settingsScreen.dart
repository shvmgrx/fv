// import 'dart:io';
// import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
// import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/enum/ts_state.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gradient_text/gradient_text.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:fv/models/user.dart';
// import 'package:fv/onboarding/strings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/home_screen.dart';
// import 'package:fv/screens/influencer_detail.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
// import 'package:fv/screens/pageviews/chat_list_screen.dart';
import 'package:fv/utils/universal_variables.dart';
// import 'package:fv/utils/utilities.dart';
// import 'package:fv/widgets/goldMask.dart';
// import 'package:fv/widgets/nmBox.dart';
// import 'package:fv/widgets/nmButton.dart';
// import 'package:fv/widgets/nmCard.dart';
// import 'package:fv/widgets/slideRoute.dart';
import 'package:flutter/services.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:fv/utils/utilities.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final influencers = allInfluencers;

  FirebaseRepository _repository = FirebaseRepository();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  ImageUploadProvider _imageUploadProvider;

  FirebaseUser loggedUser;
  String loggedUserDisplayName;
  String loggedUserEmail;
  String loggedUserUserName;
  String loggedUserStatus;
  int loggedUserState;
  String loggedUserProfilePic;
  int loggedUseranswerPrice1;
  int loggedUseranswerPrice2;
  int loggedUseranswerPrice3;
  int loggedUseranswerDuration;
  String loggedUserBio;
  bool loggedUserisInfCert;
  int loggedUsermaxQuestionCharcount;
  int loggedUserRating;
  String loggedUserCategory;
  int loggedUserReviews;
  int loggedUserinfWorth;
  int loggedUserinfSent;
  int loggedUserinfReceived;
  bool loggedUserisInfluencer;
  String loggedUserHashtags;

  Map loggedUserTimeSlots;

  static List ttIds = new List()..length = 7;
  static List ttSlots = new List()..length = 7;
  static List ttDurations = new List()..length = 7;

  Map<String, List> tempTimeslots = {
    "ttIds":ttIds,
    "ttSlots": ttSlots,
    "ttDurations": ttDurations,
  };

  bool showts1 = true;
  bool ts1Set = false;
  int ts1Changed = 0;
  bool ts1ErrorFlag = false;
  DateTime ts1;
  int ts1Duration;
  bool isTs1bought = false;
  bool isTS1same =true;
  String ts1orderId;
  var ts1State = TsState.UNSET;

  bool showts2 = false;
  bool ts2Set = false;
  int ts2Changed = 0;
  bool ts2ErrorFlag = false;
  DateTime ts2;
  int ts2Duration;
  bool isTs2bought = false;
  bool isTS2same =true;
  String ts2orderId;
  var ts2State = TsState.UNSET;

  bool showts3 = false;
  bool ts3Set = false;
  int ts3Changed = 0;
  bool ts3ErrorFlag = false;
  DateTime ts3;
  int ts3Duration;
  bool isTs3bought = false;
  bool isTS3same =true;
  String ts3orderId;
  var ts3State = TsState.UNSET;

  bool showts4 = false;
  bool ts4Set = false;
  int ts4Changed = 0;
  bool ts4ErrorFlag = false;
  DateTime ts4;
  int ts4Duration;
  bool isTs4bought = false;
  bool isTS4same =true;
  String ts4orderId;
  var ts4State = TsState.UNSET;

  bool showts5 = false;
  bool ts5Set = false;
  int ts5Changed = 0;
  bool ts5ErrorFlag = false;
  DateTime ts5;
  int ts5Duration;
  bool isTs5bought = false;
  bool isTS5same =true;
  String ts5orderId;
  var ts5State = TsState.UNSET;

  bool showts6 = false;
  bool ts6Set = false;
  int ts6Changed = 0;
  bool ts6ErrorFlag = false;
  DateTime ts6;
  int ts6Duration;
  bool isTs6bought = false;
  bool isTS6same =true;
  String ts6orderId;
  var ts6State = TsState.UNSET;

  bool showts7 = false;
  bool ts7Set = false;
  int ts7Changed = 0;
  bool ts7ErrorFlag = false;
  DateTime ts7;
  int ts7Duration;
  bool isTs7bought = false;
  bool isTS7same =true;
  String ts7orderId;
  var ts7State = TsState.UNSET;

  bool showts8 = false;
  bool ts8Set = false;
  int ts8Changed = 0;
  bool ts8ErrorFlag = false;
  DateTime ts8;
  int ts8Duration;
  bool isTs8bought = false;
  String ts8orderId;
  var ts8State = TsState.UNSET;

  bool expertMode = false;
  bool textMode;
  bool videoMode;
  bool videoCallMode;

  void initState() {
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserDisplayName = loggedUser['name'];
          loggedUserEmail = loggedUser['email'];
          loggedUserUserName = loggedUser['username'];
          loggedUserStatus = loggedUser['status'];
          loggedUserState = loggedUser['state'];
          loggedUserProfilePic = loggedUser['profilePhoto'];
          loggedUseranswerPrice1 = loggedUser['answerPrice1'];
          loggedUseranswerPrice2 = loggedUser['answerPrice2'];
          loggedUseranswerPrice3 = loggedUser['answerPrice3'];
          loggedUseranswerDuration = loggedUser['answerDuration'];
          loggedUserBio = loggedUser['bio'];
          loggedUserisInfCert = loggedUser['isInfCert'];
          loggedUsermaxQuestionCharcount = loggedUser['maxQuestionCharcount'];
          loggedUserRating = loggedUser['rating'];
          loggedUserCategory = loggedUser['category'];
          loggedUserReviews = loggedUser['reviews'];
          loggedUserinfWorth = loggedUser['infWorth'];
          loggedUserinfSent = loggedUser['infSent'];
          loggedUserinfReceived = loggedUser['infReceived'];
          loggedUserisInfluencer = loggedUser['isInfluencer'];
          loggedUserHashtags = loggedUser['hashtags'];
          loggedUserTimeSlots = loggedUser['timeSlots'];
          expertMode = loggedUser['isInfluencer'];

          expertMode = expertMode == null ? false : loggedUser['isInfluencer'];

          if(loggedUserTimeSlots !=null){

          
          ts1 = loggedUserTimeSlots['ttSlots'][0] !=null ? loggedUserTimeSlots['ttSlots'][0].toDate():null;
          if (ts1!=null){
            ts1State=TsState.SET;
          }
          ts2 = loggedUserTimeSlots['ttSlots'][1] !=null ? loggedUserTimeSlots['ttSlots'][1].toDate():null;
          if (ts2!=null){
            ts2State=TsState.SET;
          }
          ts3 = loggedUserTimeSlots['ttSlots'][2] !=null ? loggedUserTimeSlots['ttSlots'][2].toDate():null;
          if (ts3!=null){
            ts3State=TsState.SET;
          }
          ts4 = loggedUserTimeSlots['ttSlots'][3] !=null ? loggedUserTimeSlots['ttSlots'][3].toDate():null;
          if (ts4!=null){
            ts4State=TsState.SET;
          }
          ts5 = loggedUserTimeSlots['ttSlots'][4] !=null ? loggedUserTimeSlots['ttSlots'][4].toDate():null;
          if (ts5!=null){
            ts5State=TsState.SET;
          }
          ts6 = loggedUserTimeSlots['ttSlots'][5] !=null ? loggedUserTimeSlots['ttSlots'][5].toDate():null;
          if (ts6!=null){
            ts6State=TsState.SET;
          }
          ts7 = loggedUserTimeSlots['ttSlots'][6] !=null ? loggedUserTimeSlots['ttSlots'][6].toDate():null;
          if (ts7!=null){
            ts7State=TsState.SET;
          }


          ts1Duration = loggedUserTimeSlots['ttDurations'][0] !=null ? loggedUserTimeSlots['ttDurations'][0]:0;
          ts2Duration = loggedUserTimeSlots['ttDurations'][1] !=null ? loggedUserTimeSlots['ttDurations'][1]:0;
          ts3Duration = loggedUserTimeSlots['ttDurations'][2] !=null ? loggedUserTimeSlots['ttDurations'][2]:0;
          ts4Duration = loggedUserTimeSlots['ttDurations'][3] !=null ? loggedUserTimeSlots['ttDurations'][3]:0;
          ts5Duration = loggedUserTimeSlots['ttDurations'][4] !=null ? loggedUserTimeSlots['ttDurations'][4]:0;
          ts6Duration = loggedUserTimeSlots['ttDurations'][5] !=null ? loggedUserTimeSlots['ttDurations'][5]:0;
          ts7Duration = loggedUserTimeSlots['ttDurations'][6] !=null ? loggedUserTimeSlots['ttDurations'][6]:0;

          ts1orderId = loggedUserTimeSlots['ttIds'][0] !=null ? loggedUserTimeSlots['ttIds'][0]:null;
          ts2orderId = loggedUserTimeSlots['ttIds'][1] !=null ? loggedUserTimeSlots['ttIds'][1]:null;
          ts3orderId = loggedUserTimeSlots['ttIds'][2] !=null ? loggedUserTimeSlots['ttIds'][2]:null;
          ts4orderId = loggedUserTimeSlots['ttIds'][3] !=null ? loggedUserTimeSlots['ttIds'][3]:null;
          ts5orderId = loggedUserTimeSlots['ttIds'][4] !=null ? loggedUserTimeSlots['ttIds'][4]:null;
          ts6orderId = loggedUserTimeSlots['ttIds'][5] !=null ? loggedUserTimeSlots['ttIds'][5]:null;
          ts7orderId = loggedUserTimeSlots['ttIds'][6] !=null ? loggedUserTimeSlots['ttIds'][6]:null;

          

          showts2 = (loggedUserTimeSlots['ttSlots'][1] !=null && loggedUserTimeSlots['ttDurations'][1] !=null)? true:false;
          showts3 = (loggedUserTimeSlots['ttSlots'][2] !=null && loggedUserTimeSlots['ttDurations'][2] !=null)? true:false;
          showts4 = (loggedUserTimeSlots['ttSlots'][3] !=null && loggedUserTimeSlots['ttDurations'][3] !=null)? true:false;
          showts5 = (loggedUserTimeSlots['ttSlots'][4] !=null && loggedUserTimeSlots['ttDurations'][4] !=null)? true:false;
          showts6 = (loggedUserTimeSlots['ttSlots'][5] !=null && loggedUserTimeSlots['ttDurations'][5] !=null)? true:false;
          showts7 = (loggedUserTimeSlots['ttSlots'][6] !=null && loggedUserTimeSlots['ttDurations'][6] !=null)? true:false;
          }


          textMode = loggedUseranswerPrice1 != null;
          videoMode = loggedUseranswerPrice2 != null;
          videoCallMode = loggedUseranswerPrice3 != null;
        });
      });
    });

    super.initState();

    _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchAllUsers(user).then((List<User> list) {
        setState(() {
          influencerList = list;
          print(influencerList);
          for (var i = 0; i < 1; i++) {
            if (list[i].isInfluencer == true && list[i].isInfCert == true) {
              influencerList.add(list[i]);
            }
          }
        });
      });
    });

    _repository.getCurrentUser().then((FirebaseUser user) {
      loggedUserDisplayName = user.displayName;
      loggedUserProfilePic = user.photoUrl;
    });
  }

  // updateTimeFunction(TimeOfDay ts, int tsNum) {
  //   setState(() {
  //     loggedUserTimeSlots = {tsNum: ts};
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    // var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: UniversalVariables.backgroundGrey,
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: UniversalVariables.grey2,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // print(tempTimeslots);
                 
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("FAVEEZ",
                        style: TextStyles.appNameLogoStyle,
                        textAlign: TextAlign.center),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.done,
                      color: UniversalVariables.grey2,
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      if (ttIds[0]==null || ts1Changed>1) {
                   
                        ttIds[0]= Utils.generateRandomOrderId();
                      }
                      if (ttIds[1]==null || ts2Changed>1) {
                        ttIds[1]= Utils.generateRandomOrderId();
                      }
                       if (ttIds[2]==null || ts3Changed>1) {
                        ttIds[2]= Utils.generateRandomOrderId();
                      }
                       if (ttIds[3]==null || ts4Changed>1) {
                        ttIds[3]= Utils.generateRandomOrderId();
                      }
                       if (ttIds[4]==null || ts5Changed>1) {
                        ttIds[4]= Utils.generateRandomOrderId();
                      }
                       if (ttIds[5]==null || ts6Changed>1) {
                        ttIds[5]= Utils.generateRandomOrderId();
                      }
                       if (ttIds[6]==null || ts7Changed>1) {
                        ttIds[6]= Utils.generateRandomOrderId();
                      }

                      setState(() {
                        loggedUserTimeSlots = tempTimeslots;
                      });

                    

                      _formKey.currentState.save();

                      _repository.getCurrentUser().then((FirebaseUser user) {
                        _repository.updateProfiletoDb(
                            user,
                            loggedUserDisplayName,
                            loggedUserEmail,
                            loggedUserUserName,
                            loggedUserStatus,
                            loggedUserState,
                            loggedUserProfilePic,
                            loggedUseranswerPrice1,
                            loggedUseranswerPrice2,
                            loggedUseranswerPrice3,
                            loggedUseranswerDuration,
                            loggedUserBio,
                            loggedUserisInfCert,
                            loggedUsermaxQuestionCharcount,
                            loggedUserRating,
                            loggedUserCategory,
                            loggedUserReviews,
                            loggedUserinfWorth,
                            loggedUserinfSent,
                            loggedUserinfReceived,
                            loggedUserisInfluencer,
                            loggedUserHashtags,
                            loggedUserTimeSlots);
                      });

                      Navigator.pushNamed(context, "/home_screen");
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text("Expert Mode",
                                      style: TextStyles.editHeadingName,
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CupertinoSwitch(
                                    value:
                                        expertMode == null ? false : expertMode,
                                    activeColor: UniversalVariables.gold2,
                                    onChanged: (value) {
                                      setState(() {
                                        expertMode = value;
                                        loggedUserisInfluencer = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                              visible: expertMode,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Text("Text Reply",
                                        style: TextStyles.editHeadingName,
                                        textAlign: TextAlign.left),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: CupertinoSwitch(
                                        value:
                                            textMode == null ? false : textMode,
                                        activeColor: UniversalVariables.gold2,
                                        onChanged: (value) {
                                          setState(() {
                                            textMode = value;
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            Visibility(
                              visible: expertMode,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Text("Video Reply",
                                        style: TextStyles.editHeadingName,
                                        textAlign: TextAlign.left),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: CupertinoSwitch(
                                        value: videoMode == null
                                            ? false
                                            : videoMode,
                                        activeColor: UniversalVariables.gold2,
                                        onChanged: (value) {
                                          setState(() {
                                            videoMode = value;
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            Visibility(
                              visible: expertMode,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Text("Videocall",
                                        style: TextStyles.editHeadingName,
                                        textAlign: TextAlign.left),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: CupertinoSwitch(
                                        value: videoCallMode,
                                        activeColor: UniversalVariables.gold2,
                                        onChanged: (value) {
                                          setState(() {
                                            videoCallMode = value;
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            Visibility(
                              visible: expertMode,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Text Reply Price",
                                            style: TextStyles.editHeadingName,
                                            textAlign: TextAlign.left),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                        enabled: textMode && expertMode,
                                        cursorColor: UniversalVariables.gold2,
                                        decoration: InputDecoration(
                                          icon: loggedUserinfReceived == 1
                                              ? Icon(Icons.euro, size: 20)
                                              : Icon(Icons.attach_money,
                                                  size: 20),
                                          contentPadding:
                                              EdgeInsets.only(bottom: 5),
                                          hintText: '$loggedUseranswerPrice1',
                                          hintStyle: TextStyles.hintTextStyle,
                                        ),
                                        //  keyboardType: TextInputType.number,
                                        style: TextStyles.whileEditing,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        onChanged: (input) => {
                                              setState(() {
                                                loggedUseranswerPrice1 =
                                                    num.tryParse(input);
                                              })
                                            }),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: expertMode,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Video Reply Price",
                                            style: TextStyles.editHeadingName,
                                            textAlign: TextAlign.left),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Expanded(
                                      flex: 3,
                                      child: TextField(
                                          enabled: videoMode && expertMode,
                                          cursorColor: UniversalVariables.gold2,
                                          decoration: InputDecoration(
                                            icon: loggedUserinfReceived == 1
                                                ? Icon(Icons.euro, size: 20)
                                                : Icon(Icons.attach_money,
                                                    size: 20),
                                            contentPadding:
                                                EdgeInsets.only(bottom: 5),
                                            hintText: '$loggedUseranswerPrice2',
                                            hintStyle: TextStyles.hintTextStyle,
                                          ),
                                          //  keyboardType: TextInputType.number,
                                          style: TextStyles.whileEditing,
                                          inputFormatters: <TextInputFormatter>[
                                            WhitelistingTextInputFormatter
                                                .digitsOnly 
                                          ],
                                          onChanged: (input) =>
                                              loggedUseranswerPrice2 =
                                                  num.tryParse(input)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: expertMode && videoCallMode,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Video Call Price (10 mins)",
                                            style: TextStyles.editHeadingName,
                                            textAlign: TextAlign.left),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Expanded(
                                      flex: 3,
                                      child: TextField(
                                          enabled: videoCallMode && expertMode,
                                          cursorColor: UniversalVariables.gold2,
                                          decoration: InputDecoration(
                                            icon: loggedUserinfReceived == 1
                                                ? Icon(Icons.euro, size: 20)
                                                : Icon(Icons.attach_money,
                                                    size: 20),
                                            contentPadding:
                                                EdgeInsets.only(bottom: 5),
                                            hintText: '$loggedUseranswerPrice3',
                                            hintStyle: TextStyles.hintTextStyle,
                                          ),
                                          keyboardAppearance: Brightness.light,
                                          //   keyboardType: TextInputType.number,
                                          style: TextStyles.whileEditing,
                                          inputFormatters: <TextInputFormatter>[
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ],
                                          onChanged: (input) => {
                                                loggedUseranswerPrice3 =
                                                    num.tryParse(input)
                                              }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: expertMode &&
                                  videoCallMode &&
                                  loggedUseranswerPrice3 != null,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Video Call Price (15 mins)",
                                              style: TextStyles.editHeadingName,
                                              textAlign: TextAlign.left),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Expanded(
                                        flex: 3,
                                        child: loggedUseranswerPrice3 == null
                                            ? Text(
                                                "Set videocall price",
                                                style: TextStyles.hintTextStyle,
                                              )
                                            : loggedUserinfReceived == 1
                                                ? Text(
                                                    "€ ${(loggedUseranswerPrice3 * 1.333).ceil()}",
                                                    style: TextStyles
                                                        .hintMoneyTextStyle,
                                                  )
                                                : Text(
                                                    "\$ ${(loggedUseranswerPrice3 * 1.333).ceil()}",
                                                    style: TextStyles
                                                        .hintMoneyTextStyle,
                                                  ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: expertMode &&
                                  videoCallMode &&
                                  loggedUseranswerPrice3 != null,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Video Call Price (20 mins)",
                                              style: TextStyles.editHeadingName,
                                              textAlign: TextAlign.left),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Expanded(
                                        flex: 3,
                                        child: loggedUseranswerPrice3 == null
                                            ? Text(
                                                "Set videocall price",
                                                style: TextStyles.hintTextStyle,
                                              )
                                            : loggedUserinfReceived == 1
                                                ? Text(
                                                    "€ ${(loggedUseranswerPrice3 * 2.667).ceil()}",
                                                    style: TextStyles
                                                        .hintMoneyTextStyle,
                                                  )
                                                : Text(
                                                    "\$ ${(loggedUseranswerPrice3 * 2.667).ceil()}",
                                                    style: TextStyles
                                                        .hintMoneyTextStyle,
                                                  ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 40,
                            ),
                            Visibility(
                              visible: expertMode && videoCallMode,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Videocall Timeslots",
                                          style: TextStyles.editHeadingName,
                                          textAlign: TextAlign.left),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                  //TS1
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              // ts1Set && !ts1ErrorFlag
                                              //     ? Padding(
                                              //         padding: const EdgeInsets
                                              //                 .symmetric(
                                              //             horizontal: 5.0),
                                              //         child: Padding(
                                              //           padding: const EdgeInsets.symmetric(horizontal:5.0),
                                              //           child: Icon(
                                              //               Icons.edit_off,
                                              //               size: 20),
                                              //         ),
                                              //       )
                                              //     : Icon(Icons.edit, size: 20),
                                              Expanded(
                                                flex: 5,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    height: 50,
                                                    width: screenWidth / 2,
                                                    child: CupertinoTheme(
                                                      data: CupertinoThemeData(
                                                        textTheme:
                                                            CupertinoTextThemeData(
                                                          dateTimePickerTextStyle:
                                                              TextStyles
                                                                  .timeTextStyle,
                                                        ),
                                                      ),
                                                      child: AbsorbPointer(
                                                        absorbing: ts1Set &&
                                                            !ts1ErrorFlag,
                                                        child:
                                                            CupertinoDatePicker(
                                                          minimumDate: DateTime.now(),

                                                          
                                                            
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .dateAndTime,
                                                          initialDateTime: ts1 !=null? ts1:DateTime.now(),
                                                         
                                                             // DateTime.now(),
                                                          //  DateTime.now(),
                                                          onDateTimeChanged:
                                                              (DateTime
                                                                  newTimeslot) {
                                                            setState(() {
                                                              ts1Changed++;
                                                              ts1 = newTimeslot;
                                                              ts1State= TsState.UNSET;
                                                            });
                                                          },
                                                          use24hFormat: true,
                                                           minuteInterval: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Expanded(
                                                flex: 2,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    height: 50,
                                                    width: screenWidth / 2,
                                                    child: CupertinoTheme(
                                                      data: CupertinoThemeData(
                                                        textTheme:
                                                            CupertinoTextThemeData(
                                                          pickerTextStyle:
                                                              TextStyles
                                                                  .timeTextStyle,
                                                        ),
                                                      ),
                                                      child: AbsorbPointer(
                                                        absorbing: ts1Set &&
                                                            !ts1ErrorFlag,
                                                        child: CupertinoPicker(
                                                        
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              ts1Duration =
                                                                  value;
                                                              ts1Changed++;
                                                              ts1State= TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                         
                                                          children: const [
                                          
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts1Duration!=null? FixedExtentScrollController(initialItem: ts1Duration):FixedExtentScrollController(initialItem: 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        ts1Set = !ts1Set;

                                                        if (ts1Set &&
                                                            ts1Changed > 1) {
                                                          showts2 = true;

                                                          ttSlots[0] = ts1;
                                                          ttDurations[0] = ts1Duration;

                                                          ts1ErrorFlag = false;
                                                          ts1State = TsState.SET;
                                                        } else {
                                                          ts1ErrorFlag = true;
                                                        }
                                                      });
                                                    },
                                                    child: ts1State == TsState.SET
                                                        ? Icon(
                                                            CupertinoIcons
                                                                .check_mark_circled_solid,
                                                            size: 30.0,
                                                            color:
                                                                UniversalVariables
                                                                    .gold2)
                                                        : Icon(
                                                            CupertinoIcons
                                                                .check_mark_circled,
                                                            size: 30.0,
                                                            color:
                                                                UniversalVariables
                                                                    .grey1),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: ts1ErrorFlag,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 13.0),
                                              child: Center(
                                                child: Text(
                                                    "SET CORRECT DURATION AND TIMESLOT",
                                                    style:
                                                        TextStyles.errorStyle),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //TS2
                                  Visibility(
                                    visible: true,
                                  //  visible: showts2,
                                    
                                
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                // ts2Set && !ts2ErrorFlag
                                                //   ? Padding(
                                                //       padding: const EdgeInsets
                                                //               .symmetric(
                                                //           horizontal: 5.0),
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                //         child: Icon(
                                                //             Icons.edit_off,
                                                //             size: 20),
                                                //       ),
                                                //     )
                                                //   : Icon(Icons.edit, size: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            dateTimePickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts2Set &&
                                                              !ts2ErrorFlag,
                                                          child:
                                                              CupertinoDatePicker(
                                                            minimumDate:
                                                                DateTime.now(),
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .dateAndTime,
                                                            initialDateTime: ts2 !=null? ts2:DateTime.now(),
                                                              
                                                            onDateTimeChanged:
                                                                (DateTime
                                                                    newTimeslot) {
                                                              setState(() {
                                                                ts2Changed++;
                                                                ts2 =
                                                                    newTimeslot;
                                                                    ts2State= TsState.UNSET;
                                                              });
                                                            },
                                                            use24hFormat: true,
                                                            minuteInterval: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            pickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts2Set &&
                                                              !ts2ErrorFlag,
                                                          child:
                                                              CupertinoPicker(
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                ts2Changed++;
                                                                ts2Duration =
                                                                    value;
                                                                    ts2State= TsState.UNSET;
                                                              });
                                                            },
                                                            itemExtent: 30.0,
                                                            children: const [
                                                              Text('10 mins'),
                                                              Text('15 mins'),
                                                              Text('20 mins'),

                                                            ],
                                                            scrollController: ts2Duration!=null? FixedExtentScrollController(initialItem: ts2Duration):FixedExtentScrollController(initialItem: 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          ts2Set = !ts2Set;

                                                          if (ts2Set &&
                                                              ts2Changed > 1) {
                                                            showts3 = true;

                                                            ttSlots[1] = ts2;
                                                            ttDurations[1] =
                                                                ts2Duration;

                                                            ts2ErrorFlag =
                                                                false;
                                                                ts2State= TsState.SET;
                                                          } else {
                                                            ts2ErrorFlag = true;
                                                          }
                                                        });
                                                      },
                                                      child: ts2State == TsState.SET
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .gold2)
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .grey1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: ts2ErrorFlag,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13.0),
                                                child: Center(
                                                  child: Text(
                                                      "SET CORRECT DURATION AND TIMESLOT",
                                                      style: TextStyles
                                                          .errorStyle),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS3
                                  Visibility(
                                    visible: true,
                                   // visible: showts3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                // ts3Set && !ts3ErrorFlag
                                                //   ? Padding(
                                                //       padding: const EdgeInsets
                                                //               .symmetric(
                                                //           horizontal: 5.0),
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                //         child: Icon(
                                                //             Icons.edit_off,
                                                //             size: 20),
                                                //       ),
                                                //     )
                                                //   : Icon(Icons.edit, size: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            dateTimePickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts3Set &&
                                                              !ts3ErrorFlag,
                                                          child:
                                                              CupertinoDatePicker(
                                                            minimumDate:
                                                                DateTime.now(),
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .dateAndTime,
                                                            initialDateTime:ts3 !=null? ts3:DateTime.now(),
                                                              
                                                            onDateTimeChanged:
                                                                (DateTime
                                                                    newTimeslot) {
                                                              setState(() {
                                                                ts3Changed++;
                                                                ts3 =
                                                                    newTimeslot;
                                                                    ts3State=TsState.UNSET;
                                                              });
                                                            },
                                                            use24hFormat: true,
                                                             minuteInterval: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            pickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts3Set &&
                                                              !ts3ErrorFlag,
                                                          child:
                                                              CupertinoPicker(
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                ts3Duration =
                                                                    value;
                                                                ts3Changed++;
                                                                ts3State=TsState.UNSET;
                                                              });
                                                            },
                                                            itemExtent: 30.0,
                                                            children: const [
                                                              Text('10 mins'),
                                                              Text('15 mins'),
                                                              Text('20 mins'),
                                                            ],
                                                            scrollController: ts3Duration!=null? FixedExtentScrollController(initialItem: ts3Duration):FixedExtentScrollController(initialItem: 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          ts3Set = !ts3Set;

                                                          if (ts3Set &&
                                                              ts3Changed > 1) {
                                                            showts4 = true;

                                                            ttSlots[2] = ts3;
                                                            ttDurations[2] =
                                                                ts3Duration;

                                                            ts3ErrorFlag =
                                                                false;
                                                                ts3State=TsState.SET;
                                                          } else {
                                                            ts3ErrorFlag = true;
                                                          }
                                                        });
                                                      },
                                                      child: ts3State == TsState.SET
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .gold2)
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .grey1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: ts3ErrorFlag,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13.0),
                                                child: Center(
                                                  child: Text(
                                                      "SET CORRECT DURATION AND TIMESLOT",
                                                      style: TextStyles
                                                          .errorStyle),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //TS4
                                  Visibility(
                                    visible: true,
                                   //  visible: showts4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                // ts4Set && !ts4ErrorFlag
                                                //   ? Padding(
                                                //       padding: const EdgeInsets
                                                //               .symmetric(
                                                //           horizontal: 5.0),
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                //         child: Icon(
                                                //             Icons.edit_off,
                                                //             size: 20),
                                                //       ),
                                                //     )
                                                //   : Icon(Icons.edit, size: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            dateTimePickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts4Set &&
                                                              !ts4ErrorFlag,
                                                          child:
                                                              CupertinoDatePicker(
                                                            minimumDate:
                                                                DateTime.now(),
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .dateAndTime,
                                                            initialDateTime: ts4 !=null? ts4:DateTime.now(),
                                                             
                                                            onDateTimeChanged:
                                                                (DateTime
                                                                    newTimeslot) {
                                                              setState(() {
                                                                ts4Changed++;
                                                                ts4 =
                                                                    newTimeslot;
                                                                ts4State = TsState.UNSET;
                                                              });
                                                            },
                                                            use24hFormat: true,
                                                             minuteInterval: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            pickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts4Set &&
                                                              !ts4ErrorFlag,
                                                          child:
                                                              CupertinoPicker(
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                ts4Duration =
                                                                    value;
                                                                ts4Changed++;
                                                                ts4State = TsState.UNSET;
                                                              });
                                                            },
                                                            itemExtent: 30.0,
                                                            children: const [
                                                              Text('10 mins'),
                                                              Text('15 mins'),
                                                              Text('20 mins'),
                                                            ],
                                                            scrollController: ts4Duration!=null? FixedExtentScrollController(initialItem: ts4Duration):FixedExtentScrollController(initialItem: 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          ts4Set = !ts4Set;

                                                          if (ts4Set &&
                                                              ts4Changed > 1) {
                                                            showts5 = true;

                                                            ttSlots[3] = ts4;
                                                            ttDurations[3] =
                                                                ts4Duration;

                                                            ts4ErrorFlag =
                                                                false;
                                                                ts4State = TsState.SET;
                                                          } else {
                                                            ts4ErrorFlag = true;
                                                          }
                                                        });
                                                      },
                                                      child: ts4State == TsState.SET
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .gold2)
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .grey1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: ts3ErrorFlag,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13.0),
                                                child: Center(
                                                  child: Text(
                                                      "SET CORRECT DURATION AND TIMESLOT",
                                                      style: TextStyles
                                                          .errorStyle),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS5
                                  Visibility(
                                    visible: true,
                                   // visible: showts5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                // ts5Set && !ts5ErrorFlag
                                                //   ? Padding(
                                                //       padding: const EdgeInsets
                                                //               .symmetric(
                                                //           horizontal: 5.0),
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                //         child: Icon(
                                                //             Icons.edit_off,
                                                //             size: 20),
                                                //       ),
                                                //     )
                                                //   : Icon(Icons.edit, size: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            dateTimePickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts5Set &&
                                                              !ts5ErrorFlag,
                                                          child:
                                                              CupertinoDatePicker(
                                                            minimumDate:
                                                                DateTime.now(),
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .dateAndTime,
                                                            initialDateTime: ts5 !=null? ts5:DateTime.now(),
                                                               
                                                            onDateTimeChanged:
                                                                (DateTime
                                                                    newTimeslot) {
                                                              setState(() {
                                                                ts5Changed++;
                                                                ts5 =
                                                                    newTimeslot;
                                                                ts5State = TsState.UNSET;
                                                              });
                                                            },
                                                            use24hFormat: true,
                                                             minuteInterval: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            pickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts5Set &&
                                                              !ts5ErrorFlag,
                                                          child:
                                                              CupertinoPicker(
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                ts5Duration =
                                                                    value;
                                                                ts5Changed++;
                                                                 ts5State = TsState.UNSET;
                                                              });
                                                            },
                                                            itemExtent: 30.0,
                                                            children: const [
                                                              Text('10 mins'),
                                                              Text('15 mins'),
                                                              Text('20 mins'),
                                                            ],
                                                            scrollController: ts5Duration!=null? FixedExtentScrollController(initialItem: ts5Duration):FixedExtentScrollController(initialItem: 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          ts5Set = !ts5Set;

                                                          if (ts5Set &&
                                                              ts5Changed > 1) {
                                                            showts6 = true;

                                                            ttSlots[4] = ts5;
                                                            ttDurations[4] =
                                                                ts5Duration;

                                                            ts5ErrorFlag =
                                                                false;
                                                                 ts5State = TsState.SET;
                                                          } else {
                                                            ts5ErrorFlag = true;
                                                          }
                                                        });
                                                      },
                                                      child:  ts5State == TsState.SET
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .gold2)
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .grey1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: ts5ErrorFlag,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13.0),
                                                child: Center(
                                                  child: Text(
                                                      "SET CORRECT DURATION AND TIMESLOT",
                                                      style: TextStyles
                                                          .errorStyle),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //TS6
                                  Visibility(
                                    visible: true,
                                   // visible: showts6,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                // ts6Set && !ts6ErrorFlag
                                                //   ? Padding(
                                                //       padding: const EdgeInsets
                                                //               .symmetric(
                                                //           horizontal: 5.0),
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                //         child: Icon(
                                                //             Icons.edit_off,
                                                //             size: 20),
                                                //       ),
                                                //     )
                                                //   : Icon(Icons.edit, size: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            dateTimePickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts6Set &&
                                                              !ts6ErrorFlag,
                                                          child:
                                                              CupertinoDatePicker(
                                                            minimumDate:
                                                                DateTime.now(),
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .dateAndTime,
                                                            initialDateTime: ts6 !=null? ts6:DateTime.now(),
                                                               
                                                            onDateTimeChanged:
                                                                (DateTime
                                                                    newTimeslot) {
                                                              setState(() {
                                                                ts6Changed++;
                                                                ts6 =
                                                                    newTimeslot;
                                                                 ts6State = TsState.UNSET;
                                                              });
                                                            },
                                                            use24hFormat: true,
                                                             minuteInterval: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            pickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts6Set &&
                                                              !ts6ErrorFlag,
                                                          child:
                                                              CupertinoPicker(
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                ts6Duration =
                                                                    value;
                                                                ts6Changed++;
                                                                ts6State = TsState.UNSET;
                                                              });
                                                            },
                                                            itemExtent: 30.0,
                                                            children: const [
                                                              Text('10 mins'),
                                                              Text('15 mins'),
                                                              Text('20 mins'),
                                                            ],
                                                            scrollController: ts6Duration!=null? FixedExtentScrollController(initialItem: ts6Duration):FixedExtentScrollController(initialItem: 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          ts6Set = !ts6Set;

                                                          if (ts6Set &&
                                                              ts6Changed > 1) {
                                                            showts7 = true;

                                                            ttSlots[5] = ts6;
                                                            ttDurations[5] =
                                                                ts6Duration;

                                                            ts6ErrorFlag =
                                                                false;
                                                             ts6State = TsState.SET;
                                                          } else {
                                                            ts6ErrorFlag = true;
                                                          }
                                                        });
                                                      },
                                                      child:  ts6State == TsState.SET
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .gold2)
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .grey1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: ts6ErrorFlag,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13.0),
                                                child: Center(
                                                  child: Text(
                                                      "SET CORRECT DURATION AND TIMESLOT",
                                                      style: TextStyles
                                                          .errorStyle),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS7
                                  Visibility(
                                    visible: true,
                                   // visible: showts7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                // ts7Set && !ts7ErrorFlag
                                                //   ? Padding(
                                                //       padding: const EdgeInsets
                                                //               .symmetric(
                                                //           horizontal: 5.0),
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                //         child: Icon(
                                                //             Icons.edit_off,
                                                //             size: 20),
                                                //       ),
                                                //     )
                                                //   : Icon(Icons.edit, size: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            dateTimePickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts7Set &&
                                                              !ts7ErrorFlag,
                                                          child:
                                                              CupertinoDatePicker(
                                                            minimumDate:
                                                                DateTime.now(),
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .dateAndTime,
                                                            initialDateTime: ts7 !=null? ts7:DateTime.now(),
                                                             
                                                            onDateTimeChanged:
                                                                (DateTime
                                                                    newTimeslot) {
                                                              setState(() {
                                                                ts7Changed++;
                                                                ts7 =
                                                                    newTimeslot;
                                                                 ts7State = TsState.UNSET;
                                                              });
                                                            },
                                                            use24hFormat: true,
                                                             minuteInterval: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: Container(
                                                      height: 50,
                                                      width: screenWidth / 2,
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            pickerTextStyle:
                                                                TextStyles
                                                                    .timeTextStyle,
                                                          ),
                                                        ),
                                                        child: AbsorbPointer(
                                                          absorbing: ts7Set &&
                                                              !ts7ErrorFlag,
                                                          child:
                                                              CupertinoPicker(
                                                            backgroundColor:
                                                                UniversalVariables
                                                                    .transparent,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                ts7Duration =
                                                                    value;
                                                                ts7Changed++;
                                                                 ts7State = TsState.UNSET;
                                                              });
                                                            },
                                                            itemExtent: 30.0,
                                                            children: const [
                                                              Text('10 mins'),
                                                              Text('15 mins'),
                                                              Text('20 mins'),
                                                            ],
                                                            scrollController: ts7Duration!=null? FixedExtentScrollController(initialItem: ts7Duration):FixedExtentScrollController(initialItem: 0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Visibility(
                                                    //visible: show1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          ts7Set = !ts7Set;

                                                          if (ts7Set &&
                                                              ts7Changed > 1) {
                                                            showts8 = true;

                                                            ttSlots[6] = ts7;
                                                            ttDurations[6] =
                                                                ts7Duration;

                                                            ts7ErrorFlag =
                                                                false;
                                                                 ts7State = TsState.SET;
                                                          } else {
                                                            ts7ErrorFlag = true;
                                                          }
                                                        });
                                                      },
                                                      child:  ts7State == TsState.SET
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled_solid,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .gold2)
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .check_mark_circled,
                                                              size: 30.0,
                                                              color:
                                                                  UniversalVariables
                                                                      .grey1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: ts7ErrorFlag,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13.0),
                                                child: Center(
                                                  child: Text(
                                                      "SET CORRECT DURATION AND TIMESLOT",
                                                      style: TextStyles
                                                          .errorStyle),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: showts8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            "Get premium to set more timeslots",
                                            style:
                                                TextStyles.getPremiumTimeslots,
                                            textAlign: TextAlign.left),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height:50,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
