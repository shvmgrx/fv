import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:fv/models/user.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/influencer_detail.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/custom_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PageController pageController;
  int _page = 0;
  bool showBottomBar = true;
  FirebaseRepository _repository = FirebaseRepository();

  List<User> userAllList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchAllUsers(user).then((List<User> list) {
        setState(() {
          userAllList = list;
        });
      });
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    switch (page) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
      case 0:
        Navigator.pop(context);
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  searchAppBar(BuildContext context) {
    return GradientAppBar(
      backgroundColorStart: UniversalVariables.standardWhite,
      backgroundColorEnd: UniversalVariables.standardWhite,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: UniversalVariables.grey1),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: UniversalVariables.grey2,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: UniversalVariables.grey2,
              fontSize: 25,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: UniversalVariables.grey1),
                onPressed: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => searchController.clear());
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: UniversalVariables.grey1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query) {
    final List<User> suggestionHashList = (query.isEmpty)
        ? []
        : userAllList.where((User user) {
            String _getHashtags =
                user.hashtags == null ? "none" : user.hashtags.toLowerCase();
            String _filteredHashtags = _getHashtags.replaceAll("#", "");
            String _filteredQuery = query.replaceAll("#", "");
            _filteredQuery = _filteredQuery.toLowerCase();
            bool matchesHashtags = _filteredHashtags.contains(_filteredQuery);
            return (matchesHashtags);
          }).toList();

    final List<User> suggestionList = (query.isEmpty)
        ? []
        : userAllList.where((User user) {
            String _getUsername =
                user.username == null ? "none" : user.username.toLowerCase();
            String _query = query.toLowerCase();
            String _getName =
                user.name == null ? "none" : user.name.toLowerCase();
            bool matchesUsername = _getUsername.contains(_query);
            bool matchesName = _getName.contains(_query);
            return (matchesUsername || matchesName);
          }).toList();

    return ListView.builder(
      itemCount: suggestionHashList.length > 0
          ? suggestionHashList.length
          : suggestionList.length,
      itemBuilder: ((context, index) {
        User searchedUser = User(
          uid: suggestionHashList.length > 0
              ? suggestionHashList[index].uid
              : suggestionList[index].uid,
          bio: suggestionHashList.length > 0
              ? suggestionHashList[index].bio
              : suggestionList[index].bio,
          profilePhoto: suggestionHashList.length > 0
              ? suggestionHashList[index].profilePhoto
              : suggestionList[index].profilePhoto,
          name: suggestionHashList.length > 0
              ? suggestionHashList[index].name
              : suggestionList[index].name,
          username: suggestionHashList.length > 0
              ? suggestionHashList[index].username
              : suggestionList[index].username,
          answerPrice1: suggestionHashList.length > 0
              ? suggestionHashList[index].answerPrice1
              : suggestionList[index].answerPrice1,
          answerPrice2: suggestionHashList.length > 0
              ? suggestionHashList[index].answerPrice2
              : suggestionList[index].answerPrice2,
          answerPrice3: suggestionHashList.length > 0
              ? suggestionHashList[index].answerPrice3
              : suggestionList[index].answerPrice3,
          timeSlots: suggestionHashList.length > 0
              ? suggestionHashList[index].timeSlots
              : suggestionList[index].timeSlots,
        );

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    InfluencerDetails(selectedInfluencer: searchedUser)));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage("${searchedUser.profilePhoto}"),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.username,
            style: TextStyle(
              color: UniversalVariables.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(searchedUser.name, style: TextStyles.editHeadingName),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/search_screen");
          },
          backgroundColor: UniversalVariables.standardWhite,
          child: Icon(Icons.search, size: 45, color: UniversalVariables.grey2),
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
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     UniversalVariables.gold1,
                  //     UniversalVariables.gold2,
                  //     UniversalVariables.gold3,
                  //   ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomRight,
                  // ),
                  //    borderRadius: BorderRadius.circular(30.0)
                  ),
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
    );
  }
}
