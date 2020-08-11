// import 'dart:io';
// // import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
// // import 'package:avatar_glow/avatar_glow.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fv/constants/conStrings.dart';
// import 'package:fv/enum/crop_state.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:gradient_text/gradient_text.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:fv/models/user.dart';
// // import 'package:fv/onboarding/strings.dart';
// import 'package:fv/onboarding/text_styles.dart';
// import 'package:fv/resources/firebase_repository.dart';
// import 'package:fv/screens/home_screen.dart';
// // import 'package:fv/screens/influencer_detail.dart';
// import 'package:fv/models/influencer.dart';
// import 'package:flutter/cupertino.dart';
// // import 'package:fv/screens/pageviews/chat_list_screen.dart';
// import 'package:fv/utils/universal_variables.dart';
// import 'package:fv/utils/utilities.dart';
// // import 'package:fv/widgets/goldMask.dart';
// // import 'package:fv/widgets/nmBox.dart';
// // import 'package:fv/widgets/nmButton.dart';
// // import 'package:fv/widgets/nmCard.dart';
// // import 'package:fv/widgets/slideRoute.dart';
// import 'package:flutter/services.dart';
// import 'package:fv/provider/image_upload_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';


// class OnBoardUser extends StatefulWidget {
//   @override
//   _OnBoardUserState createState() => _OnBoardUserState();
// }

// class _OnBoardUserState extends State<OnBoardUser> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final influencers = allInfluencers;

//   FirebaseRepository _repository = FirebaseRepository();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _autoValidate = false;
//   ImageUploadProvider _imageUploadProvider;

//   FirebaseUser loggedUser;
//   String loggedUserDisplayName;
//   String loggedUserEmail;
//   String loggedUserUserName;
//   String loggedUserStatus;
//   int loggedUserState;
//   String loggedUserProfilePic;
//   int loggedUseranswerPrice1;
//   int loggedUseranswerPrice2;
//   int loggedUseranswerPrice3;
//   int loggedUseranswerDuration;
//   String loggedUserBio;
//   bool loggedUserisInfCert;
//   int loggedUsermaxQuestionCharcount;
//   int loggedUserRating;
//   String loggedUserCategory;
//   int loggedUserReviews;
//   int loggedUserinfWorth;
//   int loggedUserinfSent;
//   int loggedUserinfReceived;
//   bool loggedUserisInfluencer;
//   String loggedUserHashtags;
//   Map loggedUserTimeSlots;

//   CropState state;

//   File tempProfilePicture;
//   String tempProfilePictureUrl;
//    final GlobalKey<FormBuilderState> _settingsFormKey =
//       GlobalKey<FormBuilderState>();

//   void pickProfilePhoto({@required ImageSource source}) async {
    
//    File selectedImage = await Utils.pickImage(source: source);

//     _repository.getCurrentUser().then((user) {
//       _repository.changeProfilePhoto(
//           image: selectedImage,
//           imageUploadProvider: _imageUploadProvider,
//           currentUser: user);
//     });
//   }
  

//     StorageReference _storageReference;
//   Future<String> uploadImageToStorage(File tempProfilePicture) async {
//     try {
//       _storageReference = FirebaseStorage.instance
//           .ref()
//           .child('${DateTime.now().millisecondsSinceEpoch}');

//       StorageUploadTask storageUploadTask =
//           _storageReference.putFile(tempProfilePicture);
//       var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

//       return url;
//     } catch (e) {
//       return null;
//     }
//   }

//     Future<File> pickProPic({@required ImageSource source}) async {
//     File selectedProPic = await Utils.pickImage(source: source);

//     //File compImgHigh;
//     //   File compImgLow;

//     // compImgLow = await compressImageLow(selectedImg);

//     setState(() {
//       tempProfilePicture = selectedProPic;
//     });

//     if (selectedProPic != null) {
//       setState(() {
//         state = CropState.picked;
//       });
//     }
//     // // compImgHigh = await compressImageHigh(selectedImg);

//     tempProfilePictureUrl = await uploadImageToStorage(tempProfilePicture);

//     setState(() {
//       loggedUserProfilePic = tempProfilePictureUrl;
//     });
//   }

//   void initState() {
//     _repository.getCurrentUser().then((user) {
//       _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
//         setState(() {
//           loggedUserDisplayName = loggedUser['name'];
//           loggedUserEmail = loggedUser['email'];
//           loggedUserUserName = loggedUser['username'];
//           loggedUserStatus = loggedUser['status'];
//           loggedUserState = loggedUser['state'];
//           loggedUserProfilePic = loggedUser['profilePhoto'];
//           loggedUseranswerPrice1 = loggedUser['answerPrice1'];
//           loggedUseranswerPrice2 = loggedUser['answerPrice2'];
//           loggedUseranswerPrice3 = loggedUser['answerPrice3'];
//           loggedUseranswerDuration = loggedUser['answerDuration'];
//           loggedUserBio = loggedUser['bio'];
//           loggedUserisInfCert = loggedUser['isInfCert'];
//           loggedUsermaxQuestionCharcount = loggedUser['maxQuestionCharcount'];
//           loggedUserRating = loggedUser['rating'];
//           loggedUserCategory = loggedUser['category'];
//           loggedUserReviews = loggedUser['reviews'];
//           loggedUserinfWorth = loggedUser['infWorth'];
//           loggedUserinfSent = loggedUser['infSent'];
//           loggedUserinfReceived = loggedUser['infReceived'];
//           loggedUserisInfluencer = loggedUser['isInfluencer'];
//           loggedUserHashtags = loggedUser['hashtags'];
//         });
//       });
//     });

//     super.initState();

//     _repository.getCurrentUser().then((FirebaseUser user) {
//       _repository.fetchAllUsers(user).then((List<User> list) {
//         setState(() {
//           influencerList = list;
//           print(influencerList);
//           for (var i = 0; i < 1; i++) {
//             if (list[i].isInfluencer == true && list[i].isInfCert == true) {
//               influencerList.add(list[i]);
//             }
//           }
//         });
//       });
//     });

//     _repository.getCurrentUser().then((FirebaseUser user) {
//       loggedUserDisplayName = user.displayName;
//       loggedUserProfilePic = user.photoUrl;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
//      var screenHeight = MediaQuery.of(context).size.height;
//      var screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: UniversalVariables.backgroundGrey,
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//             padding: const EdgeInsets.only(top: 50),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5),
//                   child: Container(
//                     alignment: Alignment.topLeft,
//                     child: Row(
//                       children: <Widget>[
//                         InkWell(
//                           onTap: () {
//                             // if (_settingsFormKey.currentState
//                             //     .saveAndValidate()) {
//                             //   print(_settingsFormKey.currentState.value);
//                             //   updateProfileDataToDb();
//                             //   Navigator.pushAndRemoveUntil(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) => DashboardScreen()),
//                             //     (Route<dynamic> route) => false,
//                             //   );
//                             // } else {
//                             //   print(_settingsFormKey.currentState.value);
//                             //   print('validation failed');
//                             // }
//                           },
//                           child: Icon(
//                             Icons.arrow_back,
//                             size: 35,
//                             color: UniversalVariables.gold2,
//                           ),
//                         ),
//                         SizedBox(width: 20),
                      
//                       ],
//                     ),
//                   ),
//                 ),
//                 FormBuilder(
//                   key: _settingsFormKey,
//                   autovalidate: true,
//                   // initialValue: {
//                   //   'date': DateTime.now(),
//                   //   'accept_terms': false,
//                   // },

//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15.0),
//                         child: Container(
//                           //add image here

//                           child: Stack(
//                             children: <Widget>[
//                               loggedUserProfilePic == "notUploadedYet"
//                                   ? Container(
//                                       width: 170.0,
//                                       height: 170.0,
//                                       decoration: BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(8.0),
//                                           topRight: Radius.circular(8.0),
//                                           bottomLeft: Radius.circular(8.0),
//                                           bottomRight: Radius.circular(25.0),
//                                         ),
//                                         image: DecorationImage(
//                                           fit: BoxFit.cover,
//                                           image: AssetImage(
//                                               "assets/defaultUserPicture.png"),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(
//                                       width: 170.0,
//                                       height: 170.0,
//                                       decoration: BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(8.0),
//                                           topRight: Radius.circular(8.0),
//                                           bottomLeft: Radius.circular(8.0),
//                                           bottomRight: Radius.circular(25.0),
//                                         ),
//                                         image: DecorationImage(
//                                           fit: BoxFit.cover,
//                                           image: NetworkImage(
//                                               loggedUserProfilePic != null
//                                                   ? loggedUserProfilePic
//                                                   : "https://images.pexels.com/photos/1333318/pexels-photo-1333318.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
//                                         ),
//                                       ),
//                                     ),
//                               Positioned(
//                                 top: 137,
//                                 bottom: 0,
//                                 left: 125,
//                                 child: InkWell(
//                                   onTap: () {
//                                    pickProPic(source: ImageSource.gallery);

//                                     //  _cropImage();
//                                     // pickImage(source: ImageSource.gallery);
//                                   },
//                                   child: Icon(
//                                     Icons.add_circle,
//                                     size: 43,
//                                     color: UniversalVariables.blackColor,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),

//                       //NAME
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10.0, top: 20),
//                         child: Row(
//                           //   mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Container(
//                               child: Text(ConStrings.NAME,
//                                   style: TextStyles.editHeadingName),
//                             ),
//                             SizedBox(width: 55),
//                             Container(
//                               width: screenWidth * 0.45,
//                               child: FormBuilderTextField(
//                                 initialValue: loggedUserDisplayName != null
//                                     ? loggedUserDisplayName
//                                     : "",
//                                 attribute: "loggedUserDisplayName",
                               
//                                 keyboardType: TextInputType.text,
//                                 validators: [
//                                   FormBuilderValidators.max(15),
//                                 ],
//                                 onChanged: (value) {
//                                   setState(() {
//                                     loggedUserDisplayName = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
                    
             
//                       //Bio
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10.0, top: 20),
//                         child: Row(
//                           //   mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Container(
//                               child: Text(ConStrings.BIO,
//                                   style: TextStyles.editHeadingName),
//                             ),
//                             SizedBox(width: 70),
//                             Container(
//                               width: screenWidth * 0.60,
//                               child: FormBuilderTextField(
//                                 initialValue:
//                                     loggedUserBio != null ? loggedUserBio : "",
//                                 attribute: "loggedUserBio",
//                                 //    decoration:InputDecoration(labelText: "Recipe Name",helperStyle: TextStyles.recipe),
//                                 keyboardType: TextInputType.multiline,
//                                 validators: [
//                                   // FormBuilderValidators.
//                                   FormBuilderValidators.max(114),
//                                 ],

//                                 onChanged: (value) {
//                                   setState(() {
//                                     loggedUserBio = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       //Category
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10.0, top: 15),
//                         child: Row(
//                           //   mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Container(
//                               child: Text(ConStrings.CATEGORY,
//                                   style: TextStyles.editHeadingName),
//                             ),
//                             SizedBox(width: 15),
//                             Container(
//                               width: screenWidth * 0.60,
//                               child: FormBuilderFilterChip(
//                                 attribute: "loggedUserCategory",
//                                 initialValue: loggedUserCategory != null
//                                     ? loggedUserCategory
//                                     : null,
//                                 options: [
//                                   FormBuilderFieldOption(
//                                       child: Text("Vegan"), value: "Vegan"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Vegetarian"),
//                                       value: "Vegetarian"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Keto"), value: "Keto"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Organic"), value: "Organic"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Healthy Eater"),
//                                       value: "Healthy Eater"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Lactose-free"),
//                                       value: "Lactose-free"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Gluten-free"),
//                                       value: "Gluten-free"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Gourmet"), value: "Gourmet"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Chef"), value: "Chef"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Sweet Tooth"),
//                                       value: "Sweet Tooth"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Raw"), value: "Raw"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Paleo"), value: "Paleo"),
//                                   FormBuilderFieldOption(
//                                       child: Text("Intermittent Fasting"),
//                                       value: "Intermittent Fasting"),
//                                 ],
//                                 onChanged: (value) {
//                                   setState(() {
//                                     print(value);
//                                     loggedUserCategory = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Row(
//                 //   children: <Widget>[
//                 //     MaterialButton(
//                 //       child: Text("Submit"),
//                 //       onPressed: () {
//                 //         if (_settingsFormKey.currentState.saveAndValidate()) {
//                 //           print(_settingsFormKey.currentState.value);
//                 //         }
//                 //       },
//                 //     ),
//                 //     MaterialButton(
//                 //       child: Text("Reset"),
//                 //       onPressed: () {
//                 //         _settingsFormKey.currentState.reset();
//                 //       },
//                 //     ),
//                 //   ],
//                 // )
//               ],
//             ),
//           ),
//       )
      
//       // Form(
//       //   key: _formKey,
//       //   autovalidate: _autoValidate,
//       //   child: ListView(
//       //     children: <Widget>[
//       //       Row(
//       //         mainAxisAlignment: MainAxisAlignment.center,
//       //         children: <Widget>[
             
//       //           Align(
//       //             alignment: Alignment.center,
//       //             child: Text("FAVEEZ",
//       //                 style: TextStyles.appNameLogoStyle,
//       //                 textAlign: TextAlign.center),
//       //             // GradientText("FAVEEZ",
//       //             //     gradient: LinearGradient(colors: [
//       //             //       UniversalVariables.gold1,
//       //             //       UniversalVariables.gold2,
//       //             //       UniversalVariables.gold3,
//       //             //       UniversalVariables.gold4
//       //             //     ]),
//       //             //     style: TextStyles.appNameLogoStyle,
//       //             //     textAlign: TextAlign.center),
//       //           ),
//       //           // Align(
//       //           //   alignment: Alignment.topRight,
//       //           //   child: IconButton(
//       //           //     icon: Icon(
//       //           //       Icons.done,
//       //           //       color: UniversalVariables.grey2,
//       //           //     ),
//       //           //     onPressed: () {
//       //           //       if (!_formKey.currentState.validate()) {
//       //           //         return;
//       //           //       }

//       //           //       _formKey.currentState.save();

//       //           //       _repository.getCurrentUser().then((FirebaseUser user) {
                       
//       //           //         _repository.updateProfiletoDb(
//       //           //           user,
//       //           //           loggedUserDisplayName,
//       //           //           loggedUserEmail,
//       //           //           loggedUserUserName,
//       //           //           loggedUserStatus,
//       //           //           loggedUserState,
//       //           //           loggedUserProfilePic,
//       //           //           loggedUseranswerPrice1,
//       //           //           loggedUseranswerPrice2,
//       //           //           loggedUseranswerPrice3,
//       //           //           loggedUseranswerDuration,
//       //           //           loggedUserBio,
//       //           //           loggedUserisInfCert,
//       //           //           loggedUsermaxQuestionCharcount,
//       //           //           loggedUserRating,
//       //           //           loggedUserCategory,
//       //           //           loggedUserReviews,
//       //           //           loggedUserinfWorth,
//       //           //           loggedUserinfSent,
//       //           //           loggedUserinfReceived,
//       //           //           loggedUserisInfluencer,
//       //           //           loggedUserHashtags,
//       //           //           loggedUserTimeSlots

//       //           //         );
//       //           //       });

//       //           //      Navigator.pushAndRemoveUntil(
//       //           //                 context,
//       //           //                 MaterialPageRoute(
//       //           //                     builder: (context) => HomeScreen()),
//       //           //                 (Route<dynamic> route) => false,
//       //           //               );
//       //           //     },
//       //           //   ),
//       //           // )
//       //         ],
//       //       ),
//       //       SizedBox(height: 25),
//       //       // CupertinoButton(child: Text("Squueze"), onPressed: ()=>{
//       //       //    print(_imageUploadProvider.runtimeType)
//       //       // }),
//       //       Center(
//       //         child: Container(
//       //           child: Column(
//       //             children: <Widget>[
//       //               Container(
//       //                 //add image here

//       //                 child: Container(
//       //                   width: 160.0,
//       //                   height: 160.0,
//       //                   decoration: BoxDecoration(
//       //                     shape: BoxShape.circle,
//       //                     image: DecorationImage(
//       //                       fit: BoxFit.cover,
//       //                       image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/User_font_awesome.svg/1200px-User_font_awesome.svg.png"),
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ),
//       //               Container(
//       //                 child: OutlineButton(
//       //                   onPressed: () => {
                     
//       //                     pickProPic(source: ImageSource.gallery),
//       //                   },
//       //                   child: Text(
//       //                     "Add Profile Picture",
//       //                     style: TextStyles.editHeadingName,
//       //                   ),
//       //                 ),
//       //               ),
//       //               Padding(
//       //                 padding: const EdgeInsets.all(15.0),
//       //                 child: Container(
//       //                   child: Column(
//       //                     children: <Widget>[
//       //                       Row(
//       //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //                         children: <Widget>[
//       //                           Expanded(
//       //                             flex: 3,
//       //                             child: Text("Name:",
//       //                                 style: TextStyles.editHeadingName,
//       //                                 textAlign: TextAlign.left),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 5,
//       //                             child: TextField(
//       //                               cursorColor: UniversalVariables.gold2,
//       //                               decoration: InputDecoration(
//       //                                 contentPadding:
//       //                                     EdgeInsets.only(bottom: 10),
//       //                                 hintText: loggedUserDisplayName,
//       //                                 hintStyle: TextStyles.hintTextStyle,
//       //                               ),
//       //                               maxLength: 20,
//       //                               style: TextStyles.whileEditing,
//       //                               // validator: (String value) {
//       //                               //   if (value.isEmpty) {
//       //                               //     return 'Name is Required';
//       //                               //   }

//       //                               //   return null;
//       //                               // },
//       //                               onChanged: (String value) {
//       //                                 setState(() {
//       //                                   loggedUserDisplayName = value;
//       //                                 });
//       //                               },
//       //                             ),
//       //                           )
//       //                           // Text(loggedUserDisplayName)
//       //                         ],
//       //                       ),
//       //                       Row(
//       //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //                         children: <Widget>[
//       //                           Expanded(
//       //                             flex: 3,
//       //                             child: Text("Username:",
//       //                                 style: TextStyles.editHeadingName,
//       //                                 textAlign: TextAlign.left),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 5,
//       //                             child: TextFormField(
//       //                               cursorColor: UniversalVariables.gold2,
//       //                               decoration: InputDecoration(
//       //                                 contentPadding:
//       //                                     EdgeInsets.only(bottom: 10),
//       //                                 hintText: loggedUserUserName,
//       //                                 hintStyle: TextStyles.hintTextStyle,
//       //                               ),
//       //                               maxLength: 10,
//       //                               style: TextStyles.whileEditing,
//       //                               // validator: (String value) {

//       //                               //   if (value.isEmpty) {
//       //                               //     return 'Enter username';
//       //                               //   }
//       //                               //   return null;
//       //                               // },
//       //                               onChanged: (String value) {
//       //                                 setState(() {
//       //                                   loggedUserUserName = value;
//       //                                   _autoValidate = true;
//       //                                 });
//       //                               },
//       //                             ),
//       //                           )
//       //                         ],
//       //                       ),
//       //                       Row(
//       //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //                         children: <Widget>[
//       //                           Expanded(
//       //                             flex: 3,
//       //                             child: Text("Bio:",
//       //                                 style: TextStyles.editHeadingName,
//       //                                 textAlign: TextAlign.left),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 5,
//       //                             child: TextField(
//       //                               keyboardType: TextInputType.multiline,
//       //                               cursorColor: UniversalVariables.gold2,
//       //                               decoration: InputDecoration(
//       //                                 contentPadding:
//       //                                     EdgeInsets.only(bottom: 10),
//       //                                 hintText: loggedUserBio,
//       //                                 hintStyle: TextStyles.hintTextStyle,
//       //                               ),
//       //                               maxLength: 120,
//       //                               style: TextStyles.whileEditing,
//       //                               // validator: (String value) {
//       //                               //   if (value.isEmpty) {
//       //                               //     return 'Enter bio';
//       //                               //   }
//       //                               //   return null;
//       //                               // },
//       //                               onChanged: (String value) {
//       //                                 setState(() {
//       //                                   loggedUserBio = value;
//       //                                 });
//       //                               },
//       //                             ),
//       //                           )
//       //                         ],
//       //                       ),
                            
                           
//       //                     ],
//       //                   ),
//       //                 ),
//       //               )
//       //             ],
//       //           ),
//       //         ),
//       //       )
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
