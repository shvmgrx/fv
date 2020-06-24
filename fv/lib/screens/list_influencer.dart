import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:fv/enum/user_state.dart';
import 'package:fv/models/user.dart';
// import 'package:fv/onboarding/strings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/resources/auth_methods.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/influencer_detail.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/screens/login_screen.dart';
// import 'package:fv/screens/pageviews/chat_list_screen.dart';
import 'package:fv/utils/universal_variables.dart';
// import 'package:fv/widgets/goldMask.dart';
import 'package:fv/widgets/nmBox.dart';
import 'package:fv/widgets/nmButton.dart';
// import 'package:fv/widgets/nmCard.dart';
// import 'package:fv/widgets/slideRoute.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ListInfluencerPage extends StatefulWidget {
  @override
  _ListInfluencerPageState createState() => _ListInfluencerPageState();
}

class _ListInfluencerPageState extends State<ListInfluencerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final influencers = allInfluencers;

  FirebaseRepository _repository = FirebaseRepository();

  List<User> influencerList;
  List<User> featuredList;
  List<User> trendingList;
  List<User> newList;
  List<User> mostActiveList;

  String loggedUserDisplayName;
  String loggedUserProfilePic;
  bool paymentPressed = false;
  bool profilePressed = false;
  bool settingsPressed = false;
  bool category1Pressed = true;
  bool category2Pressed = false;
  bool category3Pressed = false;
  bool category4Pressed = false;
  bool loggedUserisInfCert =false;
  int loggedUseranswerPrice3;
  String pageCategory;
  var loggedUserData;
  String loggedInname;
  String loggedInprofilePhoto;

  void initState() {
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedInname = loggedUser['name'];

          loggedInprofilePhoto = loggedUser['profilePhoto'];
          loggedUserisInfCert = loggedUser['isInfCert'];
        });
      });
    });

    super.initState();
    pageCategory = "featured";
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
      // loggedUserDisplayName = user.displayName;
      // loggedUserProfilePic = user.photoUrl;
      _repository.fetchFeaturedInfluencers(user).then((List<User> list) {
        setState(() {
          featuredList = list;
        });
      });
      _repository.fetchTrendingInfluencers(user).then((List<User> list) {
        setState(() {
          trendingList = list;
        });
      });
      _repository.fetchNewInfluencers(user).then((List<User> list) {
        setState(() {
          newList = list;
        });
      });
      _repository.fetchMostActiveInfluencers(user).then((List<User> list) {
        setState(() {
          mostActiveList = list;
        });
      });
    });
  }

  Future<Null> refresh() {
    return _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchFeaturedInfluencers(user).then((List<User> list) {
        setState(() {
          featuredList = list;
        });
      });
      _repository.fetchTrendingInfluencers(user).then((List<User> list) {
        setState(() {
          trendingList = list;
        });
      });
      _repository.fetchNewInfluencers(user).then((List<User> list) {
        setState(() {
          newList = list;
        });
      });
      _repository.fetchMostActiveInfluencers(user).then((List<User> list) {
        setState(() {
          mostActiveList = list;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    final AuthMethods authMethods = AuthMethods();

    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();
      if (isLoggedOut) {
        // set userState to offline as the user logs out'
        authMethods.setUserState(
          userId: userProvider.getUser.uid,
          userState: UserState.Offline,
        );

        // move the user to login screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: UniversalVariables.backgroundGrey,
      drawer: Drawer(
        elevation: 15,
        child: Container(
          color: UniversalVariables.backgroundGrey,
          child: new ListView(
            children: <Widget>[
              // Container(
              //   height: 150,
              //   width: 150,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //       image: NetworkImage(loggedInprofilePhoto != null
              //           ? loggedInprofilePhoto
              //           : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Crystal_Clear_kdm_user_female.svg/1200px-Crystal_Clear_kdm_user_female.svg.png"),
              //       fit: BoxFit.fitHeight,
              //     ),
              //   ),
              // ),
           Container(
          margin: EdgeInsets.only(left:70,right: 70,top:20),
          width: 90,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
           image: DecorationImage(
                    image: NetworkImage(loggedInprofilePhoto != null
                        ? loggedInprofilePhoto
                        : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Crystal_Clear_kdm_user_female.svg/1200px-Crystal_Clear_kdm_user_female.svg.png"),
                    fit: BoxFit.fill,
                  ),
          ),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Align(
                  alignment: Alignment.center,
                  child: loggedInname != null
                      ? GradientText(loggedInname,
                          gradient: LinearGradient(colors: [
                            UniversalVariables.gold1,
                            UniversalVariables.gold2,
                            UniversalVariables.gold3,
                            UniversalVariables.gold4
                          ]),
                          style: TextStyles.profileName,
                          textAlign: TextAlign.center)
                      : Text(""),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          profilePressed = !profilePressed;
                          if (profilePressed) {
                            Navigator.pushNamed(
                                context, "/edit_profile_screen");
                          }
                        });
                      },
                      child: NMButton(
                        down: profilePressed,
                        icon: Icons.person,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          settingsPressed = !settingsPressed;
                          if (settingsPressed) {
                            Navigator.pushNamed(context, "/settings_screen");
                          }
                        });
                      },
                      child: NMButton(
                        down: settingsPressed,
                        icon: Icons.settings,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          paymentPressed = !paymentPressed;
                        });
                      },
                      child: NMButton(
                        down: paymentPressed,
                        icon: Icons.attach_money,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height:20),
              ListTile(
                  title: new Text(
                    "Feedback",
                    style: TextStyle(
                        color: category4Pressed ? fCDD : fCLL,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  trailing: new Icon(Icons.feedback),
                  onTap: () {
                    Navigator.of(context).pop();
                    //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                  }),
              ListTile(
                  title: new Text(
                    "Terms of Service",
                    style: TextStyle(
                        color: category4Pressed ? fCDD : fCLL,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  trailing: new Icon(Icons.description),
                  onTap: () {
                    Navigator.of(context).pop();
                    //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                  }),
              ListTile(
                title: new Text(
                  "Log Out",
                  style: TextStyle(
                      color: category4Pressed ? fCDD : fCLL,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                trailing: new Icon(Icons.exit_to_app),
                onTap: () => signOut(),
              )
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        color: UniversalVariables.gold2,
        backgroundColor: UniversalVariables.standardWhite,
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: UniversalVariables.grey2,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                      setState(() {
                        paymentPressed = false;
                        profilePressed = false;
                        settingsPressed = false;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GradientText("",
                      gradient: LinearGradient(colors: [
                        UniversalVariables.gold1,
                        UniversalVariables.gold2,
                        UniversalVariables.gold3,
                        UniversalVariables.gold4
                      ]),
                      style: TextStyles.appNameLogoStyle,
                      textAlign: TextAlign.center),
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: loggedUserisInfCert==null? false: loggedUserisInfCert,
                    child: Row(
                      children: <Widget>[
                       
                        // IconButton(
                        // icon: Icon(
                        //     Icons.attach_money,
                        //     color: UniversalVariables.gold2,
                        // ),
                        // onPressed: () {
                        //     Navigator.pushNamed(context, "/messages_screen");
                        // },
                  // ),
                   Text("\$ 243",
                   
                   style: TextStyles.moneyStyle,),

                      ],
                    ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.message,
                          color: UniversalVariables.grey2,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/messages_screen");
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Container(
            //   //margin: EdgeInsets.only(bottom:45),
            //   padding: EdgeInsets.only(bottom: 5),
            //   child: Padding(
            //     padding: EdgeInsets.all(15),
            //     child: SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: <Widget>[
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 5),
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     setState(() {
            //                       category1Pressed = !category1Pressed;
            //                     });
            //                   },
            //                   child: Container(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: 15, vertical: 7),
            //                     decoration: category1Pressed
            //                         ? buttonPressed
            //                         : buttonNotPressed,
            //                     child: Row(
            //                       children: <Widget>[
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: Text(
            //                             "ALL",
            //                             style: TextStyle(
            //                                 color:
            //                                     category1Pressed ? fCDD : fCLL,
            //                                 fontWeight: FontWeight.w600,
            //                                 fontFamily: 'PoppinsEL',
            //                                 fontSize: 14),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 5),
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     setState(() {
            //                       category2Pressed = !category2Pressed;
            //                       if (category2Pressed == true) {
            //                         category1Pressed = false;
            //                         category3Pressed = false;
            //                         category4Pressed = false;
            //                       }
            //                     });
            //                   },
            //                   child: Container(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: 15, vertical: 7),
            //                     decoration: category2Pressed
            //                         ? buttonPressed
            //                         : buttonNotPressed,
            //                     child: Row(
            //                       children: <Widget>[
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: Text(
            //                             "TRENDING",
            //                             style: TextStyle(
            //                                 color:
            //                                     category2Pressed ? fCDD : fCLL,
            //                                 fontFamily: 'PoppinsEL',
            //                                 fontWeight: FontWeight.w600,
            //                                 fontSize: 14),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 5),
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     setState(() {
            //                       category3Pressed = !category3Pressed;
            //                       if (category3Pressed == true) {
            //                         category1Pressed = false;
            //                         category2Pressed = false;
            //                         category4Pressed = false;
            //                       }
            //                     });
            //                   },
            //                   child: Container(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: 15, vertical: 7),
            //                     decoration: category3Pressed
            //                         ? buttonPressed
            //                         : buttonNotPressed,
            //                     child: Row(
            //                       children: <Widget>[
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: Text(
            //                             "NEW",
            //                             style: TextStyle(
            //                                 color:
            //                                     category3Pressed ? fCDD : fCLL,
            //                                 fontWeight: FontWeight.w600,
            //                                 fontFamily: 'PoppinsEL',
            //                                 fontSize: 14),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 5),
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     setState(() {
            //                       category4Pressed = !category4Pressed;
            //                       if (category4Pressed == true) {
            //                         category1Pressed = false;
            //                         category2Pressed = false;
            //                         category3Pressed = false;
            //                       }
            //                     });
            //                   },
            //                   child: Container(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: 15, vertical: 7),
            //                     decoration: category4Pressed
            //                         ? buttonPressed
            //                         : buttonNotPressed,
            //                     child: Row(
            //                       children: <Widget>[
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: Text(
            //                             "MOST ACTIVE",
            //                             style: TextStyle(
            //                                 color:
            //                                     category4Pressed ? fCDD : fCLL,
            //                                 fontWeight: FontWeight.w600,
            //                                 fontFamily: 'PoppinsEL',
            //                                 fontSize: 14),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ])),
            //   ),
            // ),
            //  Row(
            //    children: <Widget>[
            //      DummyUser(),
            //      DummyUser2(),
            //      DummyUser3(),
            //    ],
            //  ),
            //   Row(
            //    children: <Widget>[
            //      DummyUser4(),
            //      DummyUser5(),
            //      DummyUser6(),
            //    ],
            //  ),
            //   Row(
            //    children: <Widget>[
            //      DummyUser7(),
            //      DummyUser8(),
            //      DummyUser9(),
            //    ],
            //  ),
             

            Container(
              margin: EdgeInsets.only(left: 5),
              height: MediaQuery.of(context).size.height - 200.0,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 2,
                childAspectRatio: 0.65,
                primary: false,
                children: <Widget>[
                  // Text("Main screen"),
                  // CupertinoButton(
                  //     child: Text("update data"),
                  //     onPressed: () {
                  //       _repository.getCurrentUser().then((FirebaseUser user) {
                  //         print(user.displayName);
                  //         _repository.updateDatatoDb(
                  //             user, user.displayName, user.displayName, 6);
                  //       });
                  //     }),
                  if (category1Pressed)
                    if (featuredList != null)
                      ...featuredList.map((e) {
                        return buildInfluencerGrid(e);
                      }).toList(),

                  if (category2Pressed)
                    if (trendingList != null)
                      ...trendingList.map((e) {
                        return buildInfluencerGrid(e);
                      }).toList(),

                  if (category3Pressed)
                    if (newList != null)
                      ...newList.map((e) {
                        return buildInfluencerGrid(e);
                      }).toList(),

                  if (category4Pressed)
                    if (mostActiveList != null)
                      ...mostActiveList.map((e) {
                        return buildInfluencerGrid(e);
                      }).toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildInfluencerGrid(User influencer) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                InfluencerDetails(selectedInfluencer: influencer)));
      },
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Stack(
          children: <Widget>[
            Container(
                height: 170.0,
                width: MediaQuery.of(context).size.width/3,
                color: UniversalVariables.transparent),
            // Positioned(
            //     left: 15.0,
            //     top: 1.0,
            //     child: Container(
            //         height: 180.0,
            //         width: 101.0,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(25.0),
            //               topRight: Radius.circular(25.0),
            //             ),
            //             boxShadow: [
            //               BoxShadow(
            //                   blurRadius: 7.0,
            //                   color: Colors.grey.withOpacity(0.65),
            //                   offset: Offset(10, 25),
            //                   spreadRadius: 8.0)
            //             ]))),
            Positioned(
              left: 1.0,
              top: 1.0,
              child: Opacity(
                opacity: 1,
                child: Container(
                  height: 150.0,
                  width: 109.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    image: DecorationImage(
                        image: NetworkImage("${influencer.profilePhoto}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(influencer.name,
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser extends StatelessWidget {
  const DummyUser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top:20.0,left:3,right:3,bottom:3),
        child: Stack(
          children: <Widget>[
            Container(
                height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Era Church",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser2 extends StatelessWidget {
  const DummyUser2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top:20.0,left:3,right:3,bottom:3),
        child: Stack(
          children: <Widget>[
            Container(
                 height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/4580470/pexels-photo-4580470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                              fit: BoxFit.fitWidth))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Matt Gilfoyle",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser3 extends StatelessWidget {
  const DummyUser3({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top:20.0,left:3,right:3,bottom:3),
        child: Stack(
          children: <Widget>[
            Container(
                 height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/3768918/pexels-photo-3768918.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Joyce Quinn",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser4 extends StatelessWidget {
  const DummyUser4({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Stack(
          children: <Widget>[
            Container(
                  height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/3814446/pexels-photo-3814446.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Zac Ducker",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser5 extends StatelessWidget {
  const DummyUser5({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Stack(
          children: <Widget>[
            Container(
                  height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/38554/girl-people-landscape-sun-38554.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Iris Jones",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),
                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser6 extends StatelessWidget {
  const DummyUser6({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Stack(
          children: <Widget>[
            Container(
                 height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/2182970/pexels-photo-2182970.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Larry Olsen",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser7 extends StatelessWidget {
  const DummyUser7({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Stack(
          children: <Widget>[
            Container(
                 height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/247322/pexels-photo-247322.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Lara Dufour",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser8 extends StatelessWidget {
  const DummyUser8({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Stack(
          children: <Widget>[
            Container(
                 height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Dominik Roy",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DummyUser9 extends StatelessWidget {
  const DummyUser9({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Stack(
          children: <Widget>[
            Container(
                 height: 170.0,
                width: MediaQuery.of(context).size.width/3.2,
                color: UniversalVariables.transparent),
            Positioned(
                left: 1.0,
                top: 1.0,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                      height: 150.0,
                      width: 109.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/2787341/pexels-photo-2787341.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                              fit: BoxFit.cover))),
                )),
            Positioned(
                left: 1.0,
                top: 126.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          //gradient: UniversalVariables.fabGradient,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: UniversalVariables.white2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Julie Corina",
                              // gradient: LinearGradient(colors: [
                              //   UniversalVariables.grey1,
                              //   UniversalVariables.white1,
                              //   UniversalVariables.grey3,
                              // ]
                              // ),

                              style: TextStyles.mainScreenProfileName,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

