import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/enum/ts_state.dart';

import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:flutter/services.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:fv/utils/utilities.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
    "ttIds": ttIds,
    "ttSlots": ttSlots,
    "ttDurations": ttDurations,
  };

  bool showts1 = true;
  bool ts1Set = false;
  int ts1Changed = 0;
  bool ts1ErrorFlag = false;
  DateTime ts1 = DateTime.now();
  int ts1Duration = 0;
  bool isTs1bought = false;
  bool isTS1same = true;
  String ts1orderId;
  var ts1State = TsState.UNSET;

  bool showts2 = false;
  bool ts2Set = false;
  int ts2Changed = 0;
  bool ts2ErrorFlag = false;
  DateTime ts2 = DateTime.now();
  int ts2Duration = 0;
  bool isTs2bought = false;
  bool isTS2same = true;
  String ts2orderId;
  var ts2State = TsState.UNSET;

  bool showts3 = false;
  bool ts3Set = false;
  int ts3Changed = 0;
  bool ts3ErrorFlag = false;
  DateTime ts3 = DateTime.now();
  int ts3Duration = 0;
  bool isTs3bought = false;
  bool isTS3same = true;
  String ts3orderId;
  var ts3State = TsState.UNSET;

  bool showts4 = false;
  bool ts4Set = false;
  int ts4Changed = 0;
  bool ts4ErrorFlag = false;
  DateTime ts4 = DateTime.now();
  int ts4Duration = 0;
  bool isTs4bought = false;
  bool isTS4same = true;
  String ts4orderId;
  var ts4State = TsState.UNSET;

  bool showts5 = false;
  bool ts5Set = false;
  int ts5Changed = 0;
  bool ts5ErrorFlag = false;
  DateTime ts5 = DateTime.now();
  int ts5Duration = 0;
  bool isTs5bought = false;
  bool isTS5same = true;
  String ts5orderId;
  var ts5State = TsState.UNSET;

  bool showts6 = false;
  bool ts6Set = false;
  int ts6Changed = 0;
  bool ts6ErrorFlag = false;
  DateTime ts6 = DateTime.now();
  int ts6Duration = 0;
  bool isTs6bought = false;
  bool isTS6same = true;
  String ts6orderId;
  var ts6State = TsState.UNSET;

  bool showts7 = false;
  bool ts7Set = false;
  int ts7Changed = 0;
  bool ts7ErrorFlag = false;
  DateTime ts7 = DateTime.now();
  int ts7Duration = 0;
  bool isTs7bought = false;
  bool isTS7same = true;
  String ts7orderId;
  var ts7State = TsState.UNSET;

  bool showts8 = false;
  bool ts8Set = false;
  int ts8Changed = 0;
  bool ts8ErrorFlag = false;
  DateTime ts8 = DateTime.now();
  int ts8Duration = 0;
  bool isTs8bought = false;
  String ts8orderId;
  var ts8State = TsState.UNSET;

  bool expertMode = false;
  bool textMode;
  bool videoMode;
  bool videoCallMode;

  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTime = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

          if (loggedUserTimeSlots['ttSlots'][0] != null) {
            ts1 = loggedUserTimeSlots['ttSlots'][0].toDate();
            ts1State = TsState.SET;
          } else {
            ts1 = DateTime.now();
          }

          if (loggedUserTimeSlots['ttSlots'][1] != null) {
            ts2 = loggedUserTimeSlots['ttSlots'][1].toDate();
            ts2State = TsState.SET;
          } else {
            ts2 = DateTime.now();
          }

          if (loggedUserTimeSlots['ttSlots'][2] != null) {
            ts3 = loggedUserTimeSlots['ttSlots'][2].toDate();
            ts3State = TsState.SET;
          } else {
            ts3 = DateTime.now();
          }

          if (loggedUserTimeSlots['ttSlots'][3] != null) {
            ts4 = loggedUserTimeSlots['ttSlots'][3].toDate();
            ts4State = TsState.SET;
          } else {
            ts4 = DateTime.now();
          }

          if (loggedUserTimeSlots['ttSlots'][4] != null) {
            ts5 = loggedUserTimeSlots['ttSlots'][4].toDate();
            ts5State = TsState.SET;
          } else {
            ts5 = DateTime.now();
          }
          if (loggedUserTimeSlots['ttSlots'][5] != null) {
            ts6 = loggedUserTimeSlots['ttSlots'][5].toDate();
            ts6State = TsState.SET;
          } else {
            ts6 = DateTime.now();
          }
          if (loggedUserTimeSlots['ttSlots'][6] != null) {
            ts7 = loggedUserTimeSlots['ttSlots'][6].toDate();
            ts7State = TsState.SET;
          } else {
            ts7 = DateTime.now();
          }

          ts1Duration = loggedUserTimeSlots['ttDurations'][0] != null
              ? loggedUserTimeSlots['ttDurations'][0]
              : 0;
          ts2Duration = loggedUserTimeSlots['ttDurations'][1] != null
              ? loggedUserTimeSlots['ttDurations'][1]
              : 0;
          ts3Duration = loggedUserTimeSlots['ttDurations'][2] != null
              ? loggedUserTimeSlots['ttDurations'][2]
              : 0;
          ts4Duration = loggedUserTimeSlots['ttDurations'][3] != null
              ? loggedUserTimeSlots['ttDurations'][3]
              : 0;
          ts5Duration = loggedUserTimeSlots['ttDurations'][4] != null
              ? loggedUserTimeSlots['ttDurations'][4]
              : 0;
          ts6Duration = loggedUserTimeSlots['ttDurations'][5] != null
              ? loggedUserTimeSlots['ttDurations'][5]
              : 0;
          ts7Duration = loggedUserTimeSlots['ttDurations'][6] != null
              ? loggedUserTimeSlots['ttDurations'][6]
              : 0;

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
                                    value: true,
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
                                        value: true,
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
                                        value: true,
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
                                        value: true,
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
                                        style: TextStyles.whileEditing,
                                        inputFormatters: <TextInputFormatter>[
                                          // WhitelistingTextInputFormatter
                                          //     .digitsOnly
                                          FilteringTextInputFormatter.allow(
                                              RegExp("^[0-9]"))
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

                                  //NTS0
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                flex: 4,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    //height: 50,
                                                    color: Colors.transparent,
                                                    //width: screenWidth / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            DatePicker.showDateTimePicker(
                                                                context,
                                                                theme: DatePickerTheme(
                                                                    backgroundColor:
                                                                        UniversalVariables
                                                                            .white2,
                                                                    headerColor:
                                                                        UniversalVariables
                                                                            .gold2,
                                                                    itemStyle:
                                                                        TextStyles
                                                                            .editHeadingName,
                                                                    cancelStyle:
                                                                        TextStyles
                                                                            .cancelStyle,
                                                                    doneStyle:
                                                                        TextStyles
                                                                            .doneStyle),
                                                                minTime:
                                                                    DateTime
                                                                        .now(),
                                                                showTitleActions:
                                                                    true,
                                                                onChanged:
                                                                    (date) {},
                                                                onConfirm:
                                                                    (date) {
                                                              setState(() {
                                                                selectedDateTime =
                                                                    date;

                                                                ts1Changed++;
                                                                ts1 = date;
                                                                ts1State =
                                                                    TsState
                                                                        .UNSET;
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/timeslot.svg",
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                color:
                                                                    UniversalVariables
                                                                        .gold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  "${DateFormat('MMM d, hh:mm a').format(ts1)}",
                                                                  style: TextStyles
                                                                      .editHeadingName,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

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
                                                        absorbing: ts1Set,
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
                                                              ts1State =
                                                                  TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                          children: const [
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts1Duration !=
                                                                  null
                                                              ? FixedExtentScrollController(
                                                                  initialItem:
                                                                      ts1Duration)
                                                              : FixedExtentScrollController(
                                                                  initialItem:
                                                                      0),
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
                                                        if (ts1Set == false) {
                                                          ts1State =
                                                              TsState.UNSET;
                                                        }
                                                        if (ts1Set == true) {
                                                          ts1State =
                                                              TsState.SET;
                                                        }

                                                        if (ts1State ==
                                                            TsState.SET) {
                                                          showts2 = true;

                                                          ttSlots[0] = ts1;
                                                          ttDurations[0] =
                                                              ts1Duration;

                                                          if (ts1Changed >= 1) {
                                                            ttIds[0] = Utils
                                                                .generateRandomOrderId();
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: ts1State ==
                                                            TsState.SET
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
                                          // Visibility(
                                          //   visible: ts1ErrorFlag,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 13.0),
                                          //     child: Center(
                                          //       child: Text(
                                          //           "SET CORRECT DURATION AND TIMESLOT",
                                          //           style:
                                          //               TextStyles.errorStyle),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //NTS1
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                flex: 4,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    //height: 50,
                                                    color: Colors.transparent,
                                                    //width: screenWidth / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            DatePicker.showDateTimePicker(
                                                                context,
                                                                theme: DatePickerTheme(
                                                                    backgroundColor:
                                                                        UniversalVariables
                                                                            .white2,
                                                                    headerColor:
                                                                        UniversalVariables
                                                                            .gold2,
                                                                    itemStyle:
                                                                        TextStyles
                                                                            .editHeadingName,
                                                                    cancelStyle:
                                                                        TextStyles
                                                                            .cancelStyle,
                                                                    doneStyle:
                                                                        TextStyles
                                                                            .doneStyle),
                                                                minTime:
                                                                    DateTime
                                                                        .now(),
                                                                showTitleActions:
                                                                    true,
                                                                onChanged:
                                                                    (date) {},
                                                                onConfirm:
                                                                    (date) {
                                                              setState(() {
                                                                selectedDateTime =
                                                                    date;

                                                                ts2Changed++;
                                                                ts2 = date;
                                                                ts2State =
                                                                    TsState
                                                                        .UNSET;
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/timeslot.svg",
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                color:
                                                                    UniversalVariables
                                                                        .gold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  "${DateFormat('MMM d, hh:mm a').format(ts2)}",
                                                                  style: TextStyles
                                                                      .editHeadingName,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

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
                                                        absorbing: ts2Set,
                                                        child: CupertinoPicker(
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              ts2Duration =
                                                                  value;
                                                              ts2Changed++;
                                                              ts2State =
                                                                  TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                          children: const [
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts2Duration !=
                                                                  null
                                                              ? FixedExtentScrollController(
                                                                  initialItem:
                                                                      ts2Duration)
                                                              : FixedExtentScrollController(
                                                                  initialItem:
                                                                      0),
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
                                                        if (ts2Set == false) {
                                                          ts2State =
                                                              TsState.UNSET;
                                                        }
                                                        if (ts2Set == true) {
                                                          ts2State =
                                                              TsState.SET;
                                                        }

                                                        if (ts2State ==
                                                            TsState.SET) {
                                                          showts3 = true;

                                                          ttSlots[1] = ts2;
                                                          ttDurations[1] =
                                                              ts2Duration;

                                                          if (ts2Changed >= 1) {
                                                            ttIds[1] = Utils
                                                                .generateRandomOrderId();
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: ts2State ==
                                                            TsState.SET
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
                                          // Visibility(
                                          //   visible: ts1ErrorFlag,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 13.0),
                                          //     child: Center(
                                          //       child: Text(
                                          //           "SET CORRECT DURATION AND TIMESLOT",
                                          //           style:
                                          //               TextStyles.errorStyle),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //NTS2

                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                flex: 4,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    //height: 50,
                                                    color: Colors.transparent,
                                                    //width: screenWidth / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            DatePicker.showDateTimePicker(
                                                                context,
                                                                theme: DatePickerTheme(
                                                                    backgroundColor:
                                                                        UniversalVariables
                                                                            .white2,
                                                                    headerColor:
                                                                        UniversalVariables
                                                                            .gold2,
                                                                    itemStyle:
                                                                        TextStyles
                                                                            .editHeadingName,
                                                                    cancelStyle:
                                                                        TextStyles
                                                                            .cancelStyle,
                                                                    doneStyle:
                                                                        TextStyles
                                                                            .doneStyle),
                                                                minTime:
                                                                    DateTime
                                                                        .now(),
                                                                showTitleActions:
                                                                    true,
                                                                onChanged:
                                                                    (date) {},
                                                                onConfirm:
                                                                    (date) {
                                                              setState(() {
                                                                selectedDateTime =
                                                                    date;

                                                                ts3Changed++;
                                                                ts3 = date;
                                                                ts3State =
                                                                    TsState
                                                                        .UNSET;
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/timeslot.svg",
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                color:
                                                                    UniversalVariables
                                                                        .gold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  "${DateFormat('MMM d, hh:mm a').format(ts3)}",
                                                                  style: TextStyles
                                                                      .editHeadingName,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

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
                                                        absorbing: ts3Set,
                                                        child: CupertinoPicker(
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              ts3Duration =
                                                                  value;
                                                              ts3Changed++;
                                                              ts3State =
                                                                  TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                          children: const [
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts3Duration !=
                                                                  null
                                                              ? FixedExtentScrollController(
                                                                  initialItem:
                                                                      ts3Duration)
                                                              : FixedExtentScrollController(
                                                                  initialItem:
                                                                      0),
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
                                                        if (ts3Set == false) {
                                                          ts3State =
                                                              TsState.UNSET;
                                                        }
                                                        if (ts3Set == true) {
                                                          ts3State =
                                                              TsState.SET;
                                                        }

                                                        if (ts3State ==
                                                            TsState.SET) {
                                                          showts4 = true;

                                                          ttSlots[2] = ts3;
                                                          ttDurations[2] =
                                                              ts3Duration;

                                                          if (ts3Changed >= 1) {
                                                            ttIds[2] = Utils
                                                                .generateRandomOrderId();
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: ts3State ==
                                                            TsState.SET
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
                                          // Visibility(
                                          //   visible: ts1ErrorFlag,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 13.0),
                                          //     child: Center(
                                          //       child: Text(
                                          //           "SET CORRECT DURATION AND TIMESLOT",
                                          //           style:
                                          //               TextStyles.errorStyle),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //nts3

                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                flex: 4,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    //height: 50,
                                                    color: Colors.transparent,
                                                    //width: screenWidth / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            DatePicker.showDateTimePicker(
                                                                context,
                                                                theme: DatePickerTheme(
                                                                    backgroundColor:
                                                                        UniversalVariables
                                                                            .white2,
                                                                    headerColor:
                                                                        UniversalVariables
                                                                            .gold2,
                                                                    itemStyle:
                                                                        TextStyles
                                                                            .editHeadingName,
                                                                    cancelStyle:
                                                                        TextStyles
                                                                            .cancelStyle,
                                                                    doneStyle:
                                                                        TextStyles
                                                                            .doneStyle),
                                                                minTime:
                                                                    DateTime
                                                                        .now(),
                                                                showTitleActions:
                                                                    true,
                                                                onChanged:
                                                                    (date) {},
                                                                onConfirm:
                                                                    (date) {
                                                              setState(() {
                                                                selectedDateTime =
                                                                    date;

                                                                ts4Changed++;
                                                                ts4 = date;
                                                                ts4State =
                                                                    TsState
                                                                        .UNSET;
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/timeslot.svg",
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                color:
                                                                    UniversalVariables
                                                                        .gold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  "${DateFormat('MMM d, hh:mm a').format(ts4)}",
                                                                  style: TextStyles
                                                                      .editHeadingName,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

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
                                                        absorbing: ts4Set,
                                                        child: CupertinoPicker(
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              ts4Duration =
                                                                  value;
                                                              ts4Changed++;
                                                              ts4State =
                                                                  TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                          children: const [
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts4Duration !=
                                                                  null
                                                              ? FixedExtentScrollController(
                                                                  initialItem:
                                                                      ts4Duration)
                                                              : FixedExtentScrollController(
                                                                  initialItem:
                                                                      0),
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
                                                        if (ts4Set == false) {
                                                          ts4State =
                                                              TsState.UNSET;
                                                        }
                                                        if (ts4Set == true) {
                                                          ts4State =
                                                              TsState.SET;
                                                        }

                                                        if (ts4State ==
                                                            TsState.SET) {
                                                          showts5 = true;

                                                          ttSlots[3] = ts4;
                                                          ttDurations[3] =
                                                              ts4Duration;

                                                          if (ts4Changed >= 1) {
                                                            ttIds[3] = Utils
                                                                .generateRandomOrderId();
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: ts4State ==
                                                            TsState.SET
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
                                          // Visibility(
                                          //   visible: ts1ErrorFlag,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 13.0),
                                          //     child: Center(
                                          //       child: Text(
                                          //           "SET CORRECT DURATION AND TIMESLOT",
                                          //           style:
                                          //               TextStyles.errorStyle),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //nts4

                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                flex: 4,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    //height: 50,
                                                    color: Colors.transparent,
                                                    //width: screenWidth / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            DatePicker.showDateTimePicker(
                                                                context,
                                                                theme: DatePickerTheme(
                                                                    backgroundColor:
                                                                        UniversalVariables
                                                                            .white2,
                                                                    headerColor:
                                                                        UniversalVariables
                                                                            .gold2,
                                                                    itemStyle:
                                                                        TextStyles
                                                                            .editHeadingName,
                                                                    cancelStyle:
                                                                        TextStyles
                                                                            .cancelStyle,
                                                                    doneStyle:
                                                                        TextStyles
                                                                            .doneStyle),
                                                                minTime:
                                                                    DateTime
                                                                        .now(),
                                                                showTitleActions:
                                                                    true,
                                                                onChanged:
                                                                    (date) {},
                                                                onConfirm:
                                                                    (date) {
                                                              setState(() {
                                                                selectedDateTime =
                                                                    date;

                                                                ts5Changed++;
                                                                ts5 = date;
                                                                ts5State =
                                                                    TsState
                                                                        .UNSET;
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/timeslot.svg",
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                color:
                                                                    UniversalVariables
                                                                        .gold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  "${DateFormat('MMM d, hh:mm a').format(ts5)}",
                                                                  style: TextStyles
                                                                      .editHeadingName,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

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
                                                        absorbing: ts4Set,
                                                        child: CupertinoPicker(
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              ts5Duration =
                                                                  value;
                                                              ts5Changed++;
                                                              ts5State =
                                                                  TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                          children: const [
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts5Duration !=
                                                                  null
                                                              ? FixedExtentScrollController(
                                                                  initialItem:
                                                                      ts5Duration)
                                                              : FixedExtentScrollController(
                                                                  initialItem:
                                                                      0),
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
                                                        if (ts5Set == false) {
                                                          ts5State =
                                                              TsState.UNSET;
                                                        }
                                                        if (ts5Set == true) {
                                                          ts5State =
                                                              TsState.SET;
                                                        }

                                                        if (ts5State ==
                                                            TsState.SET) {
                                                          showts5 = true;

                                                          ttSlots[4] = ts5;
                                                          ttDurations[4] =
                                                              ts5Duration;

                                                          if (ts5Changed >= 1) {
                                                            ttIds[4] = Utils
                                                                .generateRandomOrderId();
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: ts5State ==
                                                            TsState.SET
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
                                          // Visibility(
                                          //   visible: ts1ErrorFlag,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 13.0),
                                          //     child: Center(
                                          //       child: Text(
                                          //           "SET CORRECT DURATION AND TIMESLOT",
                                          //           style:
                                          //               TextStyles.errorStyle),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //nts5
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                flex: 4,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    //height: 50,
                                                    color: Colors.transparent,
                                                    //width: screenWidth / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            DatePicker.showDateTimePicker(
                                                                context,
                                                                theme: DatePickerTheme(
                                                                    backgroundColor:
                                                                        UniversalVariables
                                                                            .white2,
                                                                    headerColor:
                                                                        UniversalVariables
                                                                            .gold2,
                                                                    itemStyle:
                                                                        TextStyles
                                                                            .editHeadingName,
                                                                    cancelStyle:
                                                                        TextStyles
                                                                            .cancelStyle,
                                                                    doneStyle:
                                                                        TextStyles
                                                                            .doneStyle),
                                                                minTime:
                                                                    DateTime
                                                                        .now(),
                                                                showTitleActions:
                                                                    true,
                                                                onChanged:
                                                                    (date) {},
                                                                onConfirm:
                                                                    (date) {
                                                              setState(() {
                                                                selectedDateTime =
                                                                    date;

                                                                ts6Changed++;
                                                                ts6 = date;
                                                                ts6State =
                                                                    TsState
                                                                        .UNSET;
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/timeslot.svg",
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                color:
                                                                    UniversalVariables
                                                                        .gold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  "${DateFormat('MMM d, hh:mm a').format(ts6)}",
                                                                  style: TextStyles
                                                                      .editHeadingName,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

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
                                                        absorbing: ts4Set,
                                                        child: CupertinoPicker(
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              ts6Duration =
                                                                  value;
                                                              ts6Changed++;
                                                              ts6State =
                                                                  TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                          children: const [
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts6Duration !=
                                                                  null
                                                              ? FixedExtentScrollController(
                                                                  initialItem:
                                                                      ts6Duration)
                                                              : FixedExtentScrollController(
                                                                  initialItem:
                                                                      0),
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
                                                        if (ts6Set == false) {
                                                          ts6State =
                                                              TsState.UNSET;
                                                        }
                                                        if (ts6Set == true) {
                                                          ts6State =
                                                              TsState.SET;
                                                        }

                                                        if (ts6State ==
                                                            TsState.SET) {
                                                          showts7 = true;

                                                          ttSlots[5] = ts6;
                                                          ttDurations[5] =
                                                              ts6Duration;

                                                          if (ts6Changed >= 1) {
                                                            ttIds[5] = Utils
                                                                .generateRandomOrderId();
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: ts6State ==
                                                            TsState.SET
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
                                          // Visibility(
                                          //   visible: ts1ErrorFlag,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 13.0),
                                          //     child: Center(
                                          //       child: Text(
                                          //           "SET CORRECT DURATION AND TIMESLOT",
                                          //           style:
                                          //               TextStyles.errorStyle),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //nts6
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                flex: 4,
                                                child: Visibility(
                                                  //visible: show1,
                                                  child: Container(
                                                    //height: 50,
                                                    color: Colors.transparent,
                                                    //width: screenWidth / 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            DatePicker.showDateTimePicker(
                                                                context,
                                                                theme: DatePickerTheme(
                                                                    backgroundColor:
                                                                        UniversalVariables
                                                                            .white2,
                                                                    headerColor:
                                                                        UniversalVariables
                                                                            .gold2,
                                                                    itemStyle:
                                                                        TextStyles
                                                                            .editHeadingName,
                                                                    cancelStyle:
                                                                        TextStyles
                                                                            .cancelStyle,
                                                                    doneStyle:
                                                                        TextStyles
                                                                            .doneStyle),
                                                                minTime:
                                                                    DateTime
                                                                        .now(),
                                                                showTitleActions:
                                                                    true,
                                                                onChanged:
                                                                    (date) {},
                                                                onConfirm:
                                                                    (date) {
                                                              setState(() {
                                                                selectedDateTime =
                                                                    date;

                                                                ts7Changed++;
                                                                ts7 = date;
                                                                ts7State =
                                                                    TsState
                                                                        .UNSET;
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/timeslot.svg",
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                color:
                                                                    UniversalVariables
                                                                        .gold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  "${DateFormat('MMM d, hh:mm a').format(ts7)}",
                                                                  style: TextStyles
                                                                      .editHeadingName,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

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
                                                        absorbing: ts4Set,
                                                        child: CupertinoPicker(
                                                          backgroundColor:
                                                              UniversalVariables
                                                                  .transparent,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              ts7Duration =
                                                                  value;
                                                              ts7Changed++;
                                                              ts7State =
                                                                  TsState.UNSET;
                                                            });
                                                          },
                                                          itemExtent: 30.0,
                                                          children: const [
                                                            Text('10 mins'),
                                                            Text('15 mins'),
                                                            Text('20 mins'),
                                                          ],
                                                          scrollController: ts7Duration !=
                                                                  null
                                                              ? FixedExtentScrollController(
                                                                  initialItem:
                                                                      ts7Duration)
                                                              : FixedExtentScrollController(
                                                                  initialItem:
                                                                      0),
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
                                                        if (ts7Set == false) {
                                                          ts7State =
                                                              TsState.UNSET;
                                                        }
                                                        if (ts7Set == true) {
                                                          ts7State =
                                                              TsState.SET;
                                                        }

                                                        if (ts7State ==
                                                            TsState.SET) {
                                                          showts8 = true;

                                                          ttSlots[6] = ts7;
                                                          ttDurations[6] =
                                                              ts7Duration;

                                                          if (ts7Changed >= 1) {
                                                            ttIds[6] = Utils
                                                                .generateRandomOrderId();
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: ts7State ==
                                                            TsState.SET
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
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    height: 50,
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
