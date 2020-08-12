import 'dart:io';
// import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
// import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/enum/crop_state.dart';
import 'package:fv/screens/onBoardExpert.dart';
import 'package:fv/screens/registerChoice.dart';
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

class VerifyExpert extends StatefulWidget {
  @override
  _VerifyExpertState createState() => _VerifyExpertState();
}

class _VerifyExpertState extends State<VerifyExpert> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String verifyCode;



  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
   var screenWidth = MediaQuery.of(context).size.width;

   //  final snackBar = SnackBar(content: Container(color: UniversalVariables.white2 ,child: Text(ConStrings.FZCODEINFO,style: TextStyles.fzCodeHeading,)));

  //   final snackBar = SnackBar(content: Text(ConStrings.FZCODEINFO,style: TextStyles.fzCodeHeading,));

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: UniversalVariables.backgroundGrey,
      body: Column(
         mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex:1,
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(left:8.0),
             child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: UniversalVariables.grey2,
                      ),
                      onPressed: () {
                      

                        Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterChoice()),
                                  (Route<dynamic> route) => false,
                                );
                      },
                    ),
           ),
                  
                Align(
                  alignment: Alignment.center,
                  child: Text("FAVEEZ",
                      style: TextStyles.appNameLogoStyle,
                      textAlign: TextAlign.center),
                  
                ),
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: UniversalVariables.backgroundGrey,
                    ),
                    onPressed: () {
                    

                    },
                  ),

                //       Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(builder: (context) => HomeScreen()),
                //         (Route<dynamic> route) => false,
                //       );

              ],
            ),
          ),
          Expanded(
            flex:1,
            child: Container()),


          Expanded(
            flex:3,
                      child: Center(
              child: Container(
                
                child: Column(
                 
                  children: <Widget>[
                  // Container(
                  //      color:UniversalVariables.white2,
                  //   width:screenWidth*0.8,
                  //       child: OutlineButton(
                  //          padding: EdgeInsets.all(5),
                  //          color:UniversalVariables.receiverColor,
                  //         splashColor: UniversalVariables.gold4,
                  //         highlightColor: UniversalVariables.receiverColor,
                  //         highlightedBorderColor: UniversalVariables.gold2,
                  //         visualDensity: VisualDensity.adaptivePlatformDensity,
                  //         onPressed: () => {
                      
                            
                  //         },
                  //         child: Text(
                  //           "REGISTER AS USER",
                  //           style: TextStyles.registerChoice,
                  //         ),
                  //       ),
                  //     ),
                  Form(
                    key: _verifyKey,
        autovalidate: _autoValidate,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("FZ-CODE",
                                              style: TextStyles.fzCodeHeading,
                                              textAlign: TextAlign.left),
                              IconButton(
                      icon: Icon(
                        Icons.info,
                        color: UniversalVariables.grey2,
                      ),
                      onPressed: () {
     final snackBar = SnackBar(content: Text(ConStrings.FZCODEINFO,style: TextStyles.fzSnackbar,));

_scaffoldKey.currentState.showSnackBar(snackBar);
                       
                      },
                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:18.0),
                            child: Container(
                              color:UniversalVariables.white2,
                              //width: screenHeight*0.3,
                              child: TextField(
                                cursorColor: UniversalVariables.gold2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                  hintText: verifyCode,
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
                                    verifyCode=value;
                                  });
                                    print(verifyCode);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),),
           
                      SizedBox(height: 25),
                      Container(
                        width:screenWidth*0.3,
                        child: OutlineButton(
                         padding: EdgeInsets.all(5),
                          color:UniversalVariables.white2,
                          splashColor: UniversalVariables.gold4,
                          highlightColor: UniversalVariables.white2,
                           highlightedBorderColor: UniversalVariables.gold2,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          onPressed: () => {
                       
                             Navigator.pushNamed(
                                context, "/onboard_expert_screen")
                          },
                          child: Text(
                            ConStrings.NEXT,
                            style: TextStyles.registerChoice,
                          ),
                        ),
                      ),
                    
                    
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
