import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fv/enum/user_state.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/resources/auth_methods.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/callscreens/pickup/pickup_layout.dart';
import 'package:fv/screens/list_influencer.dart';
// import 'package:fv/screens/pageviews/chat_list_screen.dart';
import 'package:fv/screens/profile_screen.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:flutter/cupertino.dart';
// import 'package:fv/widgets/bottom_bar.dart';
// import 'package:fv/widgets/nmBox.dart';
// import 'package:fv/widgets/nmButton.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  PageController pageController;
  int _page = 0;

  final AuthMethods _authMethods = AuthMethods();

  FirebaseRepository _repository = FirebaseRepository();

  UserProvider userProvider;

  bool showBottomBar = true;
  bool loggedUserisInfCert = false;
  String loggedInUID;

  @override
  void initState() {
    // TODO: implement initState

    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserisInfCert = loggedUser['isInfCert'];
          loggedInUID = loggedUser['uid'];
        });
      });
    });

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online,
      );
    });

    WidgetsBinding.instance.addObserver(this);
    pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    // double _labelFontSize = 10;

    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.standardWhite,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(child: ListInfluencerPage()),
            //Center(child: ListInfluencerPage(),),
            Center(child: ProfileScreen()),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        floatingActionButton: Visibility(
          visible: !loggedUserisInfCert,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search_screen");
            },
            backgroundColor: UniversalVariables.standardWhite,
            child:
                Icon(Icons.search, size: 45, color: UniversalVariables.grey2),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Visibility(
          visible: showBottomBar,
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: UniversalVariables.standardWhite,
            elevation: 9.0,
            clipBehavior: Clip.antiAlias,
            notchMargin: 6.0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(25.0),
                  //     topRight: Radius.circular(25.0)
                  //     ),
                  // color: UniversalVariables.gold2,
                  ),
              child: Ink(
                decoration: BoxDecoration(),
                child: CupertinoTabBar(
                  backgroundColor: Colors.transparent,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: (_page == 0)
                          ? Icon(Icons.home, color: UniversalVariables.grey1)
                          : Icon(Icons.home, color: UniversalVariables.grey2),

                      //  icon: Icon(Icons.chat,
                      //     color: (_page == 0)
                      //         ? UniversalVariables.standardCream
                      //         : UniversalVariables.standardCream),
                      // title: Text(
                      //   "Feed",
                      //   style: TextStyle(
                      //       fontSize: _labelFontSize,
                      //       color: (_page == 0)
                      //           ? UniversalVariables.lightBlueColor
                      //           : Colors.grey),
                      // ),
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.add,
                    //       color: (_page == 1)
                    //           ? UniversalVariables.lightBlueColor
                    //           : UniversalVariables.greyColor),
                    //   title: Text(
                    //     "Calls",
                    //     style: TextStyle(
                    //         fontSize: _labelFontSize,
                    //         color: (_page == 1)
                    //             ? UniversalVariables.lightBlueColor
                    //             : Colors.grey),
                    //   ),
                    // ),
                    BottomNavigationBarItem(
                      icon: (_page == 1)
                          ? Icon(Icons.person, color: UniversalVariables.grey1)
                          : Icon(Icons.person_outline,
                              color: UniversalVariables.grey2),
                      // title: Text(
                      //   "Contacts",
                      //   style: TextStyle(
                      //       fontSize: _labelFontSize,
                      //       color: (_page == 2)
                      //           ? UniversalVariables.lightBlueColor
                      //           : Colors.grey),
                      // ),
                    ),
                  ],
                  onTap: navigationTapped,
                  currentIndex: _page,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
