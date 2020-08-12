import 'dart:io';
// import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
// import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/enum/crop_state.dart';
import 'package:fv/screens/verifyExpert.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gradient_text/gradient_text.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:fv/utils/utilities.dart';
// import 'package:fv/widgets/goldMask.dart';
// import 'package:fv/widgets/nmBox.dart';
// import 'package:fv/widgets/nmButton.dart';
// import 'package:fv/widgets/nmCard.dart';
// import 'package:fv/widgets/slideRoute.dart';
import 'package:flutter/services.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:provider/provider.dart';

class OnBoardExpert extends StatefulWidget {
  @override
  _OnBoardExpertState createState() => _OnBoardExpertState();
}

class _OnBoardExpertState extends State<OnBoardExpert> {
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
  int loggedUserinfReceived;//used for currency
  bool loggedUserisInfluencer;
  String loggedUserHashtags;
  Map loggedUserTimeSlots;

  bool nameFilled = false;
  bool userNameFilled = false;
  bool bioFilled = false;
  bool hashFilled = false;
  CropState state;

  String tempCurrency;

  File tempProfilePicture;
  String tempProfilePictureUrl;

  void pickProfilePhoto({@required ImageSource source}) async {
    File selectedImage = await Utils.pickImage(source: source);

    _repository.getCurrentUser().then((user) {
      _repository.changeProfilePhoto(
          image: selectedImage,
          imageUploadProvider: _imageUploadProvider,
          currentUser: user);
    });
  }

  StorageReference _storageReference;
  Future<String> uploadImageToStorage(File tempProfilePicture) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');

      StorageUploadTask storageUploadTask =
          _storageReference.putFile(tempProfilePicture);
      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

      return url;
    } catch (e) {
      return null;
    }
  }

  Future<File> pickProPic({@required ImageSource source}) async {
    File selectedProPic = await Utils.pickImage(source: source);

    //File compImgHigh;
    //   File compImgLow;

    // compImgLow = await compressImageLow(selectedImg);

    setState(() {
      tempProfilePicture = selectedProPic;
    });

    if (selectedProPic != null) {
      setState(() {
        state = CropState.picked;
      });
    }
    // // compImgHigh = await compressImageHigh(selectedImg);

    tempProfilePictureUrl = await uploadImageToStorage(tempProfilePicture);

    setState(() {
      loggedUserProfilePic = tempProfilePictureUrl;
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
          //  loggedUseranswerPrice1 = loggedUser['answerPrice1'];
          // loggedUseranswerPrice2 = loggedUser['answerPrice2'];
          //   loggedUseranswerPrice3 = loggedUser['answerPrice3'];
          loggedUseranswerDuration = loggedUser['answerDuration'];
          loggedUserBio = loggedUser['bio'];
          loggedUserisInfCert = loggedUser['isInfCert'];
          loggedUsermaxQuestionCharcount = loggedUser['maxQuestionCharcount'];
          loggedUserRating = loggedUser['rating'];
          loggedUserCategory = loggedUser['category'];
          loggedUserReviews = loggedUser['reviews'];
          loggedUserinfWorth = loggedUser['infWorth'];
          loggedUserinfSent = loggedUser['infSent'];
         // loggedUserinfReceived = loggedUser['infReceived'];
          loggedUserisInfluencer = loggedUser['isInfluencer'];
          loggedUserHashtags = loggedUser['hashtags'];
        });
      });
    });

    loggedUseranswerPrice1 = 1;
    loggedUseranswerPrice2 = 2;
    loggedUseranswerPrice3 = 5;

    tempCurrency="\$ Dollar";
    loggedUserinfReceived = 0;

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
            Container(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: UniversalVariables.grey2,
                      ),
                      onPressed: () {
                      

                        Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifyExpert()),
                                  (Route<dynamic> route) => false,
                                );
                      },
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
                IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: UniversalVariables.backgroundGrey,
                      ),
                      onPressed: () {
                      

                       
                      },
                    ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: IconButton(
                //     icon: Icon(
                //       Icons.done,
                //       color: UniversalVariables.grey2,
                //     ),
                //     onPressed: () {
                //       if (!_formKey.currentState.validate()) {
                //         return;
                //       }

                //       _formKey.currentState.save();

                //       _repository.getCurrentUser().then((FirebaseUser user) {

                //         _repository.updateProfiletoDb(
                //           user,
                //           loggedUserDisplayName,
                //           loggedUserEmail,
                //           loggedUserUserName,
                //           loggedUserStatus,
                //           loggedUserState,
                //           loggedUserProfilePic,
                //           loggedUseranswerPrice1,
                //           loggedUseranswerPrice2,
                //           loggedUseranswerPrice3,
                //           loggedUseranswerDuration,
                //           loggedUserBio,
                //           loggedUserisInfCert,
                //           loggedUsermaxQuestionCharcount,
                //           loggedUserRating,
                //           loggedUserCategory,
                //           loggedUserReviews,
                //           loggedUserinfWorth,
                //           loggedUserinfSent,
                //           loggedUserinfReceived,
                //           loggedUserisInfluencer,
                //           loggedUserHashtags,
                //           loggedUserTimeSlots

                //         );
                //       });

                //      Navigator.pushAndRemoveUntil(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => HomeScreen()),
                //                 (Route<dynamic> route) => false,
                //               );
                //     },
                //   ),
                // )
              ],
            ),
            Container(height: screenHeight * 0.05),
            Container(
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
                          image: NetworkImage(
                              "https://w0.pngwave.com/png/27/394/computer-icons-user-user-png-clip-art.png"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: OutlineButton(
                      onPressed: () => {
                        pickProPic(source: ImageSource.gallery),
                      },
                      child: Text(
                        "Add Profile Picture",
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
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    hintText: loggedUserDisplayName,
                                    hintStyle: TextStyles.hintTextStyle,
                                  ),
                                  //  maxLength: 20,
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
                                      if (loggedUserDisplayName != null &&
                                          loggedUserDisplayName != "") {
                                        nameFilled = true;
                                      }
                                      if (loggedUserDisplayName == null ||
                                          loggedUserDisplayName == "") {
                                        nameFilled = false;
                                      }
                                    });
                                  },
                                ),
                              )
                              // Text(loggedUserDisplayName)
                            ],
                          ),
                          SizedBox(height: 15),
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
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    hintText: loggedUserUserName,
                                    hintStyle: TextStyles.hintTextStyle,
                                  ),
                                  //   maxLength: 10,
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
                                      if (loggedUserUserName != null &&
                                          loggedUserUserName != "") {
                                        userNameFilled = true;
                                      }
                                      if (loggedUserUserName == null ||
                                          loggedUserUserName == "") {
                                        userNameFilled = false;
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
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
                                  // keyboardType: TextInputType.multiline,
                                  cursorColor: UniversalVariables.gold2,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    hintText: loggedUserBio,
                                    hintStyle: TextStyles.hintTextStyle,
                                  ),
                                  //  maxLength: 120,
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
                                      if (loggedUserBio != null &&
                                          loggedUserBio != "") {
                                        bioFilled = true;
                                      } else if (loggedUserBio == null ||
                                          loggedUserBio == "") {
                                        bioFilled = false;
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(ConStrings.CATEGORY,
                                    style: TextStyles.editHeadingName,
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                flex: 3,
                                child: DropdownButton<String>(
                                  value: loggedUserCategory,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  //   elevation: 16,
                                  // style: TextStyle(color: Colors.deepPurple),
                                  // underline: Container(
                                  //   height: 2,
                                  //   color: Colors.deepPurpleAccent,
                                  // ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      loggedUserCategory = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'GENERAL',
                                    'FASHION',
                                    'TRAVEL',
                                    'LIFESTYLE',
                                    'ART',
                                    'HEALTH',
                                    'FOOD',
                                    'BUSINESS',
                                    'MUSIC',
                                    'PHOTOGRAPHY',
                                    'OTHER'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyles.hintTextStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                              // Text(loggedUserDisplayName)
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(ConStrings.HASHTAGS,
                                    style: TextStyles.editHeadingName,
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  // keyboardType: TextInputType.multiline,
                                  cursorColor: UniversalVariables.gold2,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    hintText: loggedUserHashtags,
                                    hintStyle: TextStyles.hintTextStyle,
                                  ),
                                  //  maxLength: 120,
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
                                      if (loggedUserHashtags != null &&
                                          loggedUserHashtags != "") {
                                        hashFilled = true;
                                      } else if (loggedUserHashtags == null ||
                                          loggedUserHashtags == "") {
                                        hashFilled = false;
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Text(ConStrings.PREFERREDCURRENCY,
                                    style: TextStyles.editHeadingName,
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                flex: 2,
                                child: DropdownButton<String>(
                                  value: tempCurrency,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  //   elevation: 16,
                                  // style: TextStyle(color: Colors.deepPurple),
                                  // underline: Container(
                                  //   height: 2,
                                  //   color: Colors.deepPurpleAccent,
                                  // ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      if(newValue=="€ Euro")
                                      {
                                        loggedUserinfReceived = 1;
                                        tempCurrency=newValue;
                                      }
                                      else{
                                        loggedUserinfReceived = 0;
                                         tempCurrency=newValue;
                                      }
                                      
                                    });
                                  },
                                  items: <String>[
                                    '\$ Dollar',
                                    '€ Euro',
                                    
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyles.hintTextStyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                              // Text(loggedUserDisplayName)
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(ConStrings.TXTRPLYPRICE,
                                    style: TextStyles.editHeadingName,
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        CupertinoIcons.minus_circled,
                                        color: UniversalVariables.gold2,
                                      ),
                                      onPressed: () {
                                        if (loggedUseranswerPrice1 > 1) {
                                          setState(() {
                                            loggedUseranswerPrice1--;
                                          });
                                        }
                                      },
                                    ),
                                    Text(
                                      loggedUserinfReceived>0?  "€ $loggedUseranswerPrice1": "\$ $loggedUseranswerPrice1",
                                      style: TextStyles.hintTextStyle,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        CupertinoIcons.add_circled,
                                        color: UniversalVariables.gold2,
                                      ),
                                      onPressed: () {
                                        //  if(loggedUseranswerPrice1 >0){
                                        setState(() {
                                          loggedUseranswerPrice1++;
                                        });

                                        //  }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(ConStrings.VIDRPLYPRICE,
                                    style: TextStyles.editHeadingName,
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        CupertinoIcons.minus_circled,
                                        color: UniversalVariables.gold2,
                                      ),
                                      onPressed: () {
                                        if (loggedUseranswerPrice2 > 1) {
                                          setState(() {
                                            loggedUseranswerPrice2--;
                                          });
                                        }
                                      },
                                    ),
                                    Text(
                                     loggedUserinfReceived>0?  "€ $loggedUseranswerPrice2": "\$ $loggedUseranswerPrice2",
                                      style: TextStyles.hintTextStyle,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        CupertinoIcons.add_circled,
                                        color: UniversalVariables.gold2,
                                      ),
                                      onPressed: () {
                                        //  if(loggedUseranswerPrice1 >0){
                                        setState(() {
                                          loggedUseranswerPrice2++;
                                        });

                                        //  }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(ConStrings.VIDCALLPRICE,
                                    style: TextStyles.editHeadingName,
                                    textAlign: TextAlign.left),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        CupertinoIcons.minus_circled,
                                        color: UniversalVariables.gold2,
                                      ),
                                      onPressed: () {
                                        if (loggedUseranswerPrice3 > 1) {
                                          setState(() {
                                            loggedUseranswerPrice3--;
                                          });
                                        }
                                      },
                                    ),
                                    Text(
                                    loggedUserinfReceived>0?  "€ $loggedUseranswerPrice3": "\$ $loggedUseranswerPrice3",
                                      style: TextStyles.hintTextStyle,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        CupertinoIcons.add_circled,
                                        color: UniversalVariables.gold2,
                                      ),
                                      onPressed: () {
                                        //  if(loggedUseranswerPrice1 >0){
                                        setState(() {
                                          loggedUseranswerPrice3++;
                                        });

                                        //  }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  Container(height: screenHeight * 0.06),
                  CupertinoButton(
                    color: (nameFilled && userNameFilled && bioFilled)
                        ? UniversalVariables.gold2
                        : UniversalVariables.grey2,
                    onPressed: () => {
                      print("nameFilled: $nameFilled"),
                      print("bioFill: $bioFilled"),
                      print("userNameFilled: $userNameFilled"),
                      print("loggedUserCategory: $loggedUserCategory"),
                      print("loggedUserinfReceived: $loggedUserinfReceived")
                    },
                    child: Text(
                      ConStrings.NEXT,
                      style: TextStyles.nextButton,
                    ),
                  ),
                  Container(height: screenHeight * 0.06),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
