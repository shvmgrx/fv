import 'dart:io';
import 'package:infv1/screens/chatscreens/widgets/cached_image.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infv1/models/user.dart';
import 'package:infv1/onboarding/strings.dart';
import 'package:infv1/onboarding/text_styles.dart';
import 'package:infv1/resources/firebase_repository.dart';
import 'package:infv1/screens/home_screen.dart';
import 'package:infv1/screens/influencer_detail.dart';
import 'package:infv1/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:infv1/screens/pageviews/chat_list_screen.dart';
import 'package:infv1/utils/universal_variables.dart';
import 'package:infv1/utils/utilities.dart';
import 'package:infv1/widgets/goldMask.dart';
import 'package:infv1/widgets/nmBox.dart';
import 'package:infv1/widgets/nmButton.dart';
import 'package:infv1/widgets/nmCard.dart';
import 'package:infv1/widgets/slideRoute.dart';
import 'package:flutter/services.dart';
import 'package:infv1/provider/image_upload_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
                    Container(
                      //add image here

                      child: Container(
                        width: 160.0,
                        height: 160.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(loggedUserProfilePic != null
                                ? loggedUserProfilePic
                                : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Crystal_Clear_kdm_user_female.svg/1200px-Crystal_Clear_kdm_user_female.svg.png"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: OutlineButton(
                        onPressed: () => {
                          //buttonDisabled
                          //pickProfilePhoto(source: ImageSource.gallery),
                        },
                        child: Text(
                          "Change Profile Picture",
                          style: TextStyles.editHeadingName,
                        ),
                      ),
                    ),
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
                                  child: Text("Name:",
                                      style: TextStyles.editHeadingName,
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextField(
                                    cursorColor: UniversalVariables.gold2,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      hintText: loggedUserDisplayName,
                                      hintStyle: TextStyles.hintTextStyle,
                                    ),
                                    maxLength: 20,
                                    style: TextStyles.whileEditing,
                                    // validator: (String value) {
                                    //   if (value.isEmpty) {
                                    //     return 'Name is Required';
                                    //   }

                                    //   return null;
                                    // },
                                    onChanged: (String value) {
                                      setState(() {
                                        loggedUserDisplayName = value;
                                      });
                                    },
                                  ),
                                )
                                // Text(loggedUserDisplayName)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text("Username:",
                                      style: TextStyles.editHeadingName,
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    cursorColor: UniversalVariables.gold2,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      hintText: loggedUserUserName,
                                      hintStyle: TextStyles.hintTextStyle,
                                    ),
                                    maxLength: 10,
                                    style: TextStyles.whileEditing,
                                    // validator: (String value) {

                                    //   if (value.isEmpty) {
                                    //     return 'Enter username';
                                    //   }
                                    //   return null;
                                    // },
                                    onChanged: (String value) {
                                      setState(() {
                                        loggedUserUserName = value;
                                        _autoValidate = true;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text("Bio:",
                                      style: TextStyles.editHeadingName,
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextField(
                                    cursorColor: UniversalVariables.gold2,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      hintText: loggedUserBio,
                                      hintStyle: TextStyles.hintTextStyle,
                                    ),
                                    maxLength: 120,
                                    style: TextStyles.whileEditing,
                                    // validator: (String value) {
                                    //   if (value.isEmpty) {
                                    //     return 'Enter bio';
                                    //   }

                                    //   return null;
                                    // },
                                    onChanged: (String value) {
                                      setState(() {
                                        loggedUserBio = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(
                            //       flex: 3,
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: <Widget>[
                            //           Text("Text Reply Price:",
                            //               style: TextStyles.editHeadingName,
                            //               textAlign: TextAlign.left),
                            //               SizedBox(height:5),
                            //           // Text("\$${loggedUseranswerPrice1*0.65} (post-charges)",
                            //           //     style: TextStyles.postCommissionsPrice,
                            //           //     textAlign: TextAlign.left),

                            //         ],
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 5,
                            //       child: TextField(
                            //           cursorColor: UniversalVariables.gold2,
                            //           decoration: InputDecoration(
                            //             contentPadding:
                            //                 EdgeInsets.only(bottom: 10),
                            //             hintText: '\$$loggedUseranswerPrice1',
                            //             hintStyle: TextStyles.hintTextStyle,
                            //           ),
                            //           keyboardType: TextInputType.number,
                            //           style: TextStyles.whileEditing,
                            //           inputFormatters: <TextInputFormatter>[
                            //             WhitelistingTextInputFormatter
                            //                 .digitsOnly
                            //           ],
                            //           maxLength: 9,
                            //           onChanged: (input) => {
                            //                 loggedUseranswerPrice1 =
                            //                     num.tryParse(input)
                            //               }),
                            //     )
                            //   ],
                            // ),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(
                            //       flex: 3,
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: <Widget>[
                            //           Text("Video Reply Price:",
                            //               style: TextStyles.editHeadingName,
                            //               textAlign: TextAlign.left),
                            //                SizedBox(height:5),
                            //           // Text("\$${loggedUseranswerPrice2*0.65} (post-charges)",
                            //           //     style: TextStyles.postCommissionsPrice,
                            //           //     textAlign: TextAlign.left),
                            //         ],
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 5,
                            //       child: TextField(
                            //           cursorColor: UniversalVariables.gold2,
                            //           decoration: InputDecoration(
                            //             contentPadding:
                            //                 EdgeInsets.only(bottom: 10),
                            //             hintText: '\$$loggedUseranswerPrice2',
                            //             hintStyle: TextStyles.hintTextStyle,
                            //           ),
                            //           keyboardType: TextInputType.number,
                            //           style: TextStyles.whileEditing,
                            //           inputFormatters: <TextInputFormatter>[
                            //             WhitelistingTextInputFormatter
                            //                 .digitsOnly
                            //           ],
                            //           maxLength: 9,
                            //           onChanged: (input) => {
                            //                 loggedUseranswerPrice2 =
                            //                     num.tryParse(input)
                            //               }),
                            //     )
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text("Hashtags:",
                                      style: TextStyles.editHeadingName,
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextField(
                                    cursorColor: UniversalVariables.gold2,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      hintText: loggedUserHashtags,
                                      hintStyle: TextStyles.hintTextStyle,
                                    ),
                                    maxLength: 120,
                                    style: TextStyles.whileEditing,
                                    // validator: (String value) {
                                    //   if (value.isEmpty) {
                                    //     return 'Enter bio';
                                    //   }

                                    //   return null;
                                    // },
                                    onChanged: (String value) {
                                      setState(() {
                                        loggedUserHashtags = value;
                                      });
                                    },
                                  ),
                                )
                              ],
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
