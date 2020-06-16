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

  bool ts1Filled;
  DateTime ts1;


  bool expertMode;
  bool textMode;
  bool videoMode;
  bool videoCallMode;

  void pickProfilePhoto({@required ImageSource source}) async {
    File selectedImage = await Utils.pickImage(source: source);

    _repository.getCurrentUser().then((user) {
      _repository.changeProfilePhoto(
          image: selectedImage,
          imageUploadProvider: _imageUploadProvider,
          currentUser: user);
    });
  }

  void initState() {
    _repository.getCurrentUser().then((user) {
      //loggedUser = user;
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
                  // GradientText("FAVEEZ",
                  //     gradient: LinearGradient(colors: [
                  //       UniversalVariables.gold1,
                  //       UniversalVariables.gold2,
                  //       UniversalVariables.gold3,
                  //       UniversalVariables.gold4
                  //     ]),
                  //     style: TextStyles.appNameLogoStyle,
                  //     textAlign: TextAlign.center),
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
            // CupertinoButton(child: Text("Squueze"), onPressed: ()=>{
            //    print(_imageUploadProvider.runtimeType)
            // }),
            Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    // Container(
                    //   //add image here

                    //     child: Container(
                    //       width: 160.0,
                    //       height: 160.0,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         image: DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: NetworkImage(loggedUserProfilePic != null
                    //               ? loggedUserProfilePic
                    //               : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Crystal_Clear_kdm_user_female.svg/1200px-Crystal_Clear_kdm_user_female.svg.png"),
                    //         ),
                    //       ),
                    //     ),

                    // ),
                    // Container(
                    //   child: OutlineButton(

                    //     onPressed: () => {
                    //       //buttonDisabled
                    //       //pickProfilePhoto(source: ImageSource.gallery),
                    //     },
                    //     child: Text(
                    //       "Change Profile Picture",
                    //       style: TextStyles.editHeadingName,
                    //     ),
                    //   ),
                    // ),
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
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: <Widget>[
                            //     Expanded(
                            //       flex: 3,
                            //       child: Text("Name:",
                            //           style: TextStyles.editHeadingName,
                            //           textAlign: TextAlign.left),
                            //     ),
                            //     Expanded(
                            //       flex: 5,
                            //       child: TextField(
                            //         cursorColor: UniversalVariables.gold2,
                            //         decoration: InputDecoration(
                            //           contentPadding:
                            //               EdgeInsets.only(bottom: 10),
                            //           hintText: loggedUserDisplayName,
                            //           hintStyle: TextStyles.hintTextStyle,
                            //         ),
                            //         maxLength: 20,
                            //         style: TextStyles.whileEditing,
                            //         // validator: (String value) {
                            //         //   if (value.isEmpty) {
                            //         //     return 'Name is Required';
                            //         //   }

                            //         //   return null;
                            //         // },
                            //         onChanged: (String value) {
                            //           setState(() {
                            //             loggedUserDisplayName = value;
                            //           });
                            //         },
                            //       ),
                            //     )
                            //     // Text(loggedUserDisplayName)
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: <Widget>[
                            //     Expanded(
                            //       flex: 3,
                            //       child: Text("Username:",
                            //           style: TextStyles.editHeadingName,
                            //           textAlign: TextAlign.left),
                            //     ),
                            //     Expanded(
                            //       flex: 5,
                            //       child: TextFormField(
                            //         cursorColor: UniversalVariables.gold2,
                            //         decoration: InputDecoration(
                            //           contentPadding:
                            //               EdgeInsets.only(bottom: 10),
                            //           hintText: loggedUserUserName,
                            //           hintStyle: TextStyles.hintTextStyle,
                            //         ),
                            //         maxLength: 10,
                            //         style: TextStyles.whileEditing,
                            //         // validator: (String value) {

                            //         //   if (value.isEmpty) {
                            //         //     return 'Enter username';
                            //         //   }
                            //         //   return null;
                            //         // },
                            //         onChanged: (String value) {
                            //           setState(() {
                            //             loggedUserUserName = value;
                            //             _autoValidate = true;
                            //           });
                            //         },
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: <Widget>[
                            //     Expanded(
                            //       flex: 3,
                            //       child: Text("Bio:",
                            //           style: TextStyles.editHeadingName,
                            //           textAlign: TextAlign.left),
                            //     ),
                            //     Expanded(
                            //       flex: 5,
                            //       child: TextField(
                            //         cursorColor: UniversalVariables.gold2,
                            //         decoration: InputDecoration(
                            //           contentPadding:
                            //               EdgeInsets.only(bottom: 10),
                            //           hintText: loggedUserBio,
                            //           hintStyle: TextStyles.hintTextStyle,
                            //         ),
                            //         maxLength: 120,
                            //         style: TextStyles.whileEditing,
                            //         // validator: (String value) {
                            //         //   if (value.isEmpty) {
                            //         //     return 'Enter bio';
                            //         //   }

                            //         //   return null;
                            //         // },
                            //         onChanged: (String value) {
                            //           setState(() {
                            //             loggedUserBio = value;
                            //           });
                            //         },
                            //       ),
                            //     )
                            //   ],
                            // ),
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
                                        // Text("\$${loggedUseranswerPrice1*0.65} (post-charges)",
                                        //     style: TextStyles.postCommissionsPrice,
                                        //     textAlign: TextAlign.left),
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
                                        // maxLength: 6,
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
                                        // Text("\$${loggedUseranswerPrice2*0.65} (post-charges)",
                                        //     style: TextStyles.postCommissionsPrice,
                                        //     textAlign: TextAlign.left),
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
                                          // maxLength: 6,
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
                                        // Text("\$${loggedUseranswerPrice2*0.65} (post-charges)",
                                        //     style: TextStyles.postCommissionsPrice,
                                        //     textAlign: TextAlign.left),
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
                                          //maxLength: 6,
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
                                            flex: 1,
                                            child: Icon(
                                                CupertinoIcons.add_circled,
                                                size: 20.0,
                                                color:
                                                    UniversalVariables.grey1),
                                          ),
                                          Expanded(
                                            flex: 5,
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
                                                    //  pickerTextStyle: TextStyles.appNameLogoStyle
                                                  ),
                                                ),
                                                child: CupertinoDatePicker(
                                                  backgroundColor:
                                                      UniversalVariables
                                                          .transparent,
                                                  mode: CupertinoDatePickerMode
                                                      .dateAndTime,
                                                  initialDateTime:
                                                      DateTime.now(),
                                                  onDateTimeChanged:
                                                      (DateTime newTimeslot) {
                                                    setState(() {
                                                      ts1Filled = true;
                                                      ts1 = newTimeslot;
                                                    });
                                                  },
                                                  use24hFormat: true,
                                                  minuteInterval: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 50,
                                              width: screenWidth / 2,
                                              child: CupertinoTheme(
                                                data: CupertinoThemeData(
                                                  textTheme:
                                                      CupertinoTextThemeData(
                                                    pickerTextStyle: TextStyles
                                                        .timeTextStyle,
                                                    //  pickerTextStyle: TextStyles.appNameLogoStyle
                                                  ),
                                                ),
                                                child: CupertinoPicker(
                                                  backgroundColor:UniversalVariables.transparent,
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
                                          Expanded(
                                            //flex: 1,
                                            child: Icon(
                                                CupertinoIcons
                                                    .check_mark_circled,
                                                size: 20.0,
                                                color:
                                                    UniversalVariables.grey1),
                                          ),
                                        ],
                                      ),
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
