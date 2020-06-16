import 'dart:io';
import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/strings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/screens/influencer_detail.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/screens/pageviews/chat_list_screen.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/utils/utilities.dart';
import 'package:fv/widgets/goldMask.dart';
import 'package:fv/widgets/nmBox.dart';
import 'package:fv/widgets/nmButton.dart';
import 'package:fv/widgets/nmCard.dart';
import 'package:fv/widgets/slideRoute.dart';
import 'package:flutter/services.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:provider/provider.dart';

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
  Map tempTimeslots;

  bool showts1 = true;
  bool ts1Set = false;
  DateTime ts1;

  bool showts2 = false;
  bool ts2Set = false;
  DateTime ts2;

  bool showts3 = false;
  bool ts3Set = false;
  DateTime ts3;

  bool showts4 = false;
  bool ts4Set = false;
  DateTime ts4;

  bool showts5 = false;
  bool ts5Set = false;
  DateTime ts5;

  bool showts6 = false;
  bool ts6Set = false;
  DateTime ts6;

  bool showts7 = false;
  bool ts7Set = false;
  DateTime ts7;

  bool showts8 = false;
  bool ts8Set = false;
  DateTime ts8;

  bool expertMode;
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

  updateTimeFunction(TimeOfDay ts, int tsNum) {
    setState(() {
      loggedUserTimeSlots = {tsNum: ts};
    });
  }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;
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
                Align(
                  alignment: Alignment.center,
                  child: Text("FAVEEZ",
                      style: TextStyles.appNameLogoStyle,
                      textAlign: TextAlign.center),
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
                        );
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
                                      value: expertMode,
                                      activeColor: UniversalVariables.gold2,
                                      onChanged: (value) {
                                        setState(() {
                                          expertMode = value;
                                          loggedUserisInfluencer = value;
                                        });
                                      },
                                    ))
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
                                        value: textMode,
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
                                        value: videoMode,
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
                                          icon: Icon(Icons.attach_money,
                                              size: 20),
                                          contentPadding:
                                              EdgeInsets.only(bottom: 5),
                                          hintText: '$loggedUseranswerPrice1',
                                          hintStyle: TextStyles.hintTextStyle,
                                        ),
                                        keyboardType: TextInputType.number,
                                        style: TextStyles.whileEditing,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        onChanged: (input) => {
                                              loggedUseranswerPrice1 =
                                                  num.tryParse(input)
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
                                            icon: Icon(Icons.attach_money,
                                                size: 20),
                                            contentPadding:
                                                EdgeInsets.only(bottom: 5),
                                            hintText: '$loggedUseranswerPrice2',
                                            hintStyle: TextStyles.hintTextStyle,
                                          ),
                                          keyboardType: TextInputType.number,
                                          style: TextStyles.whileEditing,
                                          inputFormatters: <TextInputFormatter>[
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ],
                                          onChanged: (input) => {
                                                loggedUseranswerPrice2 =
                                                    num.tryParse(input)
                                              }),
                                    ),
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
                                            icon: Icon(Icons.attach_money,
                                                size: 20),
                                            contentPadding:
                                                EdgeInsets.only(bottom: 5),
                                            hintText: '$loggedUseranswerPrice3',
                                            hintStyle: TextStyles.hintTextStyle,
                                          ),
                                          keyboardType: TextInputType.number,
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Visibility(
                                      visible: expertMode && videoCallMode,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
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
                                                    absorbing: ts1Set,
                                                    child: CupertinoDatePicker(
                                                      backgroundColor:
                                                          UniversalVariables
                                                              .transparent,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .dateAndTime,
                                                      initialDateTime:
                                                          DateTime.now(),
                                                      onDateTimeChanged:
                                                          (DateTime
                                                              newTimeslot) {
                                                        setState(() {
                                                          ts1 = newTimeslot;
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
                                                    absorbing: ts1Set,
                                                    child: CupertinoPicker(
                                                      backgroundColor:
                                                          UniversalVariables
                                                              .transparent,
                                                      onSelectedItemChanged:
                                                          (value) {
                                                        setState(() {
                                                          print("value");
                                                          print(value);
                                                        });
                                                      },
                                                      itemExtent: 30.0,
                                                      children: const [
                                                        Text('10 mins'),
                                                        Text('25 mins'),
                                                        Text('45 mins'),
                                                      ],
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
                                                    showts2 = true;
                                                  });
                                                },
                                                child: ts1Set
                                                    ? Icon(
                                                        CupertinoIcons
                                                            .check_mark_circled_solid,
                                                        size: 20.0,
                                                        color:
                                                            UniversalVariables
                                                                .gold2)
                                                    : Icon(
                                                        CupertinoIcons
                                                            .check_mark_circled,
                                                        size: 20.0,
                                                        color:
                                                            UniversalVariables
                                                                .grey1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: showts2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
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
                                                      absorbing: ts2Set,
                                                      child:
                                                          CupertinoDatePicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .dateAndTime,
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        onDateTimeChanged:
                                                            (DateTime
                                                                newTimeslot) {
                                                          setState(() {
                                                            ts1 = newTimeslot;
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
                                                      absorbing: ts2Set,
                                                      child: CupertinoPicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          setState(() {
                                                            print("value");
                                                            print(value);
                                                          });
                                                        },
                                                        itemExtent: 30.0,
                                                        children: const [
                                                          Text('10 mins'),
                                                          Text('25 mins'),
                                                          Text('45 mins'),
                                                        ],
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
                                                      showts3 = true;
                                                    });
                                                  },
                                                  child: ts2Set
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .gold2)
                                                      : Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .grey1),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
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
                                                      absorbing: ts3Set,
                                                      child:
                                                          CupertinoDatePicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .dateAndTime,
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        onDateTimeChanged:
                                                            (DateTime
                                                                newTimeslot) {
                                                          setState(() {
                                                            ts1 = newTimeslot;
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
                                                      absorbing: ts3Set,
                                                      child: CupertinoPicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          setState(() {
                                                            print("value");
                                                            print(value);
                                                          });
                                                        },
                                                        itemExtent: 30.0,
                                                        children: const [
                                                          Text('10 mins'),
                                                          Text('25 mins'),
                                                          Text('45 mins'),
                                                        ],
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
                                                      showts4= true;
                                                    });
                                                  },
                                                  child: ts3Set
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .gold2)
                                                      : Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .grey1),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
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
                                                      absorbing: ts4Set,
                                                      child:
                                                          CupertinoDatePicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .dateAndTime,
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        onDateTimeChanged:
                                                            (DateTime
                                                                newTimeslot) {
                                                          setState(() {
                                                            ts1 = newTimeslot;
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
                                                      absorbing: ts4Set,
                                                      child: CupertinoPicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          setState(() {
                                                            print("value");
                                                            print(value);
                                                          });
                                                        },
                                                        itemExtent: 30.0,
                                                        children: const [
                                                          Text('10 mins'),
                                                          Text('25 mins'),
                                                          Text('45 mins'),
                                                        ],
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
                                                      showts5 = true;
                                                    });
                                                  },
                                                  child: ts4Set
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .gold2)
                                                      : Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .grey1),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
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
                                                      absorbing: ts5Set,
                                                      child:
                                                          CupertinoDatePicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .dateAndTime,
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        onDateTimeChanged:
                                                            (DateTime
                                                                newTimeslot) {
                                                          setState(() {
                                                            ts1 = newTimeslot;
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
                                                      absorbing: ts5Set,
                                                      child: CupertinoPicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          setState(() {
                                                            print("value");
                                                            print(value);
                                                          });
                                                        },
                                                        itemExtent: 30.0,
                                                        children: const [
                                                          Text('10 mins'),
                                                          Text('25 mins'),
                                                          Text('45 mins'),
                                                        ],
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
                                                      showts6= true;
                                                    });
                                                  },
                                                  child: ts5Set
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .gold2)
                                                      : Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .grey1),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
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
                                                      absorbing: ts6Set,
                                                      child:
                                                          CupertinoDatePicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .dateAndTime,
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        onDateTimeChanged:
                                                            (DateTime
                                                                newTimeslot) {
                                                          setState(() {
                                                            ts1 = newTimeslot;
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
                                                      absorbing: ts6Set,
                                                      child: CupertinoPicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          setState(() {
                                                            print("value");
                                                            print(value);
                                                          });
                                                        },
                                                        itemExtent: 30.0,
                                                        children: const [
                                                          Text('10 mins'),
                                                          Text('25 mins'),
                                                          Text('45 mins'),
                                                        ],
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
                                                      showts7= true;
                                                    });
                                                  },
                                                  child: ts6Set
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .gold2)
                                                      : Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .grey1),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25.0,bottom:20),
                                      child: Visibility(
                                        visible: expertMode && videoCallMode,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
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
                                                      absorbing: ts7Set,
                                                      child:
                                                          CupertinoDatePicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .dateAndTime,
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        onDateTimeChanged:
                                                            (DateTime
                                                                newTimeslot) {
                                                          setState(() {
                                                            ts1 = newTimeslot;
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
                                                      absorbing: ts7Set,
                                                      child: CupertinoPicker(
                                                        backgroundColor:
                                                            UniversalVariables
                                                                .transparent,
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          setState(() {
                                                            print("value");
                                                            print(value);
                                                          });
                                                        },
                                                        itemExtent: 30.0,
                                                        children: const [
                                                          Text('10 mins'),
                                                          Text('25 mins'),
                                                          Text('45 mins'),
                                                        ],
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
                                                      showts8= true;
                                                    });
                                                  },
                                                  child: ts7Set
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled_solid,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .gold2)
                                                      : Icon(
                                                          CupertinoIcons
                                                              .check_mark_circled,
                                                          size: 20.0,
                                                          color:
                                                              UniversalVariables
                                                                  .grey1),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Get premium to set more timeslots",
                                            style: TextStyles.getPremiumTimeslots,
                                            textAlign: TextAlign.left),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),

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
