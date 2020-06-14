import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/strings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/screens/chatscreens/chat_screen.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/nmBox.dart';
import 'package:fv/widgets/priceCard.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:fv/models/influencer.dart';

class InfluencerDetails extends StatefulWidget {
  final User selectedInfluencer;

  InfluencerDetails({this.selectedInfluencer});

  @override
  _InfluencerDetailsState createState() => _InfluencerDetailsState();
}

class _InfluencerDetailsState extends State<InfluencerDetails> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.transparent),
          Container(
            height: screenHeight - screenHeight / 3,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/surfing.jpg'), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: screenHeight - (screenHeight / 2.5) - 25,
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              height: screenHeight / 3 + 25.0,
              width: screenWidth,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.0),
                    widget.selectedInfluencer.name != null
                        ? Text(
                            widget.selectedInfluencer.name,
                            style: TextStyles.theNameStyle,
                          )
                        : Text(
                            "Favees User",
                            style: TextStyles.theNameStyle,
                          ),
                    SizedBox(height: 7.0),
                    // Row(
                    //   children: <Widget>[
                    //     Text(
                    //       widget.selectedInfluencer.username,
                    //       style: TextStyles.usernameStyle,
                    //     ),
                    //     Icon(
                    //       Icons.verified_user,
                    //       color: UniversalVariables.gold2,
                    //       size: 20,
                    //     ),
                    //   ],
                    // ),
                    // Text('Santa Monica, CA',
                    // style: GoogleFonts.sourceSansPro(
                    //   fontSize: 15.0,
                    //   fontWeight: FontWeight.w400,
                    //   color: Color(0xFF5E5B54)
                    // )
                    // ),
                    SizedBox(height: 7.0),
                    Row(
                      children: <Widget>[
                        // SmoothStarRating(
                        //   allowHalfRating: false,
                        //   starCount: 5,
                        //   rating: 4.0,
                        //   size: 15.0,
                        //   color: Color(0xFFF36F32),
                        //   borderColor: Color(0xFFF36F32),
                        //   spacing:0.0
                        // ),
                        SizedBox(width: 3.0),
                        // Text('4.7',
                        //   style: GoogleFonts.sourceSansPro(
                        //           fontSize: 14.0,
                        //           fontWeight: FontWeight.w400,
                        //           color: Color(0xFFD57843)
                        //         )
                        // ),
                        // SizedBox(width: 3.0),
                        // Text('(200 Reviews)',
                        //   style: GoogleFonts.sourceSansPro(
                        //           fontSize: 14.0,
                        //           fontWeight: FontWeight.w400,
                        //           color: Color(0xFFC2C0B6)
                        //         )
                        // )
                      ],
                    ),
                    SizedBox(height: 1.0),
                    widget.selectedInfluencer.bio != null
                        ? Container(
                          width: 180,
                          child: Text(widget.selectedInfluencer.bio,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF201F1C))),
                        )
                        : Text("Faveez user bio",
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF201F1C))),

                    SizedBox(height: 15.0),
                    // Text('Read More',
                    //   style: GoogleFonts.sourceSansPro(
                    //     fontSize: 14.0,
                    //     fontWeight: FontWeight.w400,
                    //     color: Color(0xFFF36F32)
                    //   )
                    // ),
                    SizedBox(height: 10.0),

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
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Container(
          //       height: 70.0,
          //       width: MediaQuery.of(context).size.width,
          //       child: Center(
          //           child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               //crossAxisAlignment: CrossAxisAlignment.stretch,
          //               children: [
          //             Icon(
          //               Icons.expand_less,
          //               color: Colors.white,
          //               size: 30,
          //             ),
          //             Icon(
          //               Icons.star_border,
          //               color: Colors.white,
          //               size: 30,
          //             ),
          //             Icon(
          //               Icons.expand_more,
          //               color: Colors.white,
          //               size: 30,
          //             ),
          //           ])),
          //       decoration: BoxDecoration(
          //           //borderRadius: BorderRadius.only(topLeft: Radius.circular(55.0)),
          //           color: UniversalVariables.standardWhite),
          //     ),
          //     ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 30.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.pop(context),
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: UniversalVariables.white2),
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
            top: screenHeight - screenHeight / 2.5 - 65.0,
            right: 35.0,
            child: Hero(
              tag: widget.selectedInfluencer.profilePhoto,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 110.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            widget.selectedInfluencer.profilePhoto),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Row(
                      children: <Widget>[
                        widget.selectedInfluencer.username != null
                            ? Text(
                                widget.selectedInfluencer.username,
                                style: TextStyles.usernameStyle,
                              )
                            : Text(
                                "faveezUsername",
                                style: TextStyles.usernameStyle,
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

          Positioned(
            top: screenHeight - screenHeight / 3.5,
            left: 10,
            right: 10,
            child: Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            height: 110.0,
                            width: 126.0,
                            color: UniversalVariables.transparent),
                        Positioned(
                            left: 1.0,
                            top: 1.0,
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          receiver: widget.selectedInfluencer,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 78.0,
                                    width: 115.0,
                                    decoration: BoxDecoration(

                                        //gradient: UniversalVariables.fabGradient,

                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: widget.selectedInfluencer
                                                    .answerPrice1 !=
                                                null
                                            ? Text(
                                                "\$ ${widget.selectedInfluencer.answerPrice1}",
                                                style: TextStyles.priceNumber,
                                                textAlign: TextAlign.center)
                                            : Text("Not Set",
                                                style: TextStyles
                                                    .notSetPriceNumber,
                                                textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 27.0,
                                  width: 115.0,
                                  decoration: BoxDecoration(
                                      //gradient: UniversalVariables.fabGradient,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                      color: UniversalVariables.white2),
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
                              ],
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            height: 110.0,
                            width: 132.0,
                            color: UniversalVariables.transparent),
                        Positioned(
                            right: 1,
                            top: 1.0,
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          receiver: widget.selectedInfluencer,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 78.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(

                                        //gradient: UniversalVariables.fabGradient,

                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: widget.selectedInfluencer
                                                    .answerPrice2 !=
                                                null
                                            ? Text(
                                                "\$ ${widget.selectedInfluencer.answerPrice2}",
                                                style: TextStyles.priceNumber,
                                                textAlign: TextAlign.center)
                                            : Text("Not Set",
                                                style: TextStyles
                                                    .notSetPriceNumber,
                                                textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 27.0,
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                      //gradient: UniversalVariables.fabGradient,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                      color: UniversalVariables.white2),
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
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: Visibility(
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.pushNamed(context, "/search_screen");
      //     },
      //     backgroundColor: UniversalVariables.standardWhite,
      //     child: Icon(Icons.search, size: 45, color: UniversalVariables.grey2),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Visibility(
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: UniversalVariables.standardWhite,
          elevation: 9.0,
          clipBehavior: Clip.antiAlias,
          notchMargin: 6.0,
          child: Container(
            height: 60,
            child: Ink(
              decoration: BoxDecoration(),
              child: CupertinoTabBar(
                backgroundColor: Colors.transparent,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(
                                context, "/home_screen");
                          },
                          child: Icon(Icons.home, color: UniversalVariables.grey2))),
                  BottomNavigationBarItem(
                      icon: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/profile_screen");
                          },
                          child: Icon(Icons.person_outline,
                              color: UniversalVariables.grey1))),
                ],
                //onTap: navigationTapped,
                //currentIndex: _page,
              ),
            ),
          ),
        ),
      ),
    );
  }
}