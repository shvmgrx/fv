import 'dart:io';
// import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
// import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fv/enum/crop_state.dart';
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

class RegisterChoice extends StatefulWidget {
  @override
  _RegisterChoiceState createState() => _RegisterChoiceState();
}

class _RegisterChoiceState extends State<RegisterChoice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();





  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
   var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: UniversalVariables.backgroundGrey,
      body: Column(
         mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex:1,
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            
                Align(
                  alignment: Alignment.center,
                  child: Text("FAVEEZ",
                      style: TextStyles.appNameLogoStyle,
                      textAlign: TextAlign.center),
                  
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
                  Container(
                    width:screenWidth*0.8,
                        child: OutlineButton(
                           padding: EdgeInsets.all(5),
                           color:UniversalVariables.white2,
                          splashColor: UniversalVariables.gold4,
                          highlightColor: UniversalVariables.white2,
                          highlightedBorderColor: UniversalVariables.gold2,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          onPressed: () => {
                       Navigator.pushNamed(
                                context, "/onboard_user_screen")
                            
                          },
                          child: Text(
                            "REGISTER AS USER",
                            style: TextStyles.registerChoice,
                          ),
                        ),
                      ),
                       SizedBox(height: 25),
                      Container(
                        width:screenWidth*0.8,
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
                            "REGISTER AS EXPERT",
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
