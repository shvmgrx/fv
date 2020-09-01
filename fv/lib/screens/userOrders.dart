import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/orderTile.dart';

import 'package:provider/provider.dart';

class UserOrders extends StatefulWidget {
  @override
  _UserOrderseState createState() => _UserOrderseState();
}

class _UserOrderseState extends State<UserOrders> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final influencers = allInfluencers;

  FirebaseRepository _repository = FirebaseRepository();
  FirebaseUser loggedUser;
  String loggedUserDisplayName;

  String loggedUserUserName;
  String loggedUserProfilePic;

  bool loggedUserisInfCert;

  int loggedUserinfWorth;
  int loggedUserinfReceived;
  bool loggedUserisInfluencer;

  bool showVideocalls = true;
  bool showMessages = false;

  void initState() {
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserDisplayName = loggedUser['name'];

          loggedUserUserName = loggedUser['username'];

          loggedUserProfilePic = loggedUser['profilePhoto'];

          loggedUserisInfCert = loggedUser['isInfCert'];

          loggedUserinfWorth = loggedUser['infWorth'];

          loggedUserinfReceived = loggedUser['infReceived'];
          loggedUserisInfluencer = loggedUser['isInfluencer'];
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

  // buildSuggestions(String query) {
  //   final List<User> suggestionHashList = (query.isEmpty)
  //       ? []
  //       : userAllList.where((User user) {
  //           String _getHashtags =
  //               user.hashtags == null ? "none" : user.hashtags.toLowerCase();
  //           String _filteredHashtags = _getHashtags.replaceAll("#", "");
  //           String _filteredQuery = query.replaceAll("#", "");
  //           _filteredQuery = _filteredQuery.toLowerCase();
  //           bool matchesHashtags = _filteredHashtags.contains(_filteredQuery);
  //           return (matchesHashtags);
  //         }).toList();

  //   final List<User> suggestionList = (query.isEmpty)
  //       ? []
  //       : userAllList.where((User user) {
  //           String _getUsername =
  //               user.username == null ? "none" : user.username.toLowerCase();
  //           String _query = query.toLowerCase();
  //           String _getName =
  //               user.name == null ? "none" : user.name.toLowerCase();
  //           bool matchesUsername = _getUsername.contains(_query);
  //           bool matchesName = _getName.contains(_query);
  //           return (matchesUsername || matchesName);
  //         }).toList();

  //   return ListView.builder(
  //     itemCount: suggestionHashList.length > 0
  //         ? suggestionHashList.length
  //         : suggestionList.length,
  //     itemBuilder: ((context, index) {
  //       User searchedUser = User(
  //           uid: suggestionHashList.length > 0
  //               ? suggestionHashList[index].uid
  //               : suggestionList[index].uid,
  //           profilePhoto: suggestionHashList.length > 0
  //               ? suggestionHashList[index].profilePhoto
  //               : suggestionList[index].profilePhoto,
  //           name: suggestionHashList.length > 0
  //               ? suggestionHashList[index].name
  //               : suggestionList[index].name,
  //           username: suggestionHashList.length > 0
  //               ? suggestionHashList[index].username
  //               : suggestionList[index].username);

  //       return CustomTile(
  //         mini: false,
  //         onTap: () {
  //           // Navigator.of(context).push(MaterialPageRoute(
  //           //     builder: (context) =>
  //           //         InfluencerDetails(selectedInfluencer: searchedUser)));
  //         },
  //         leading: CircleAvatar(
  //           backgroundImage: NetworkImage("${searchedUser.profilePhoto}"),
  //           backgroundColor: Colors.grey,
  //         ),
  //         title: Text(
  //           searchedUser.username,
  //           style: TextStyle(
  //             color: UniversalVariables.blackColor,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         subtitle: Text(
  //           searchedUser.name,
  //           style: TextStyle(color: UniversalVariables.gold2),
  //         ),
  //       );
  //     }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: UniversalVariables.backgroundGrey,
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: UniversalVariables.grey2,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(ConStrings.ORDERS,
                    style: TextStyles.appNameLogoStyle,
                    textAlign: TextAlign.center),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: UniversalVariables.backgroundGrey,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showVideocalls = true;
                      showMessages = false;
                    });
                  },
                  child: Text(ConStrings.VIDEOCALLS,
                      style: showVideocalls
                          ? TextStyles.selectedOrdersStyle
                          : TextStyles.ordersStyle,
                      textAlign: TextAlign.center),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showVideocalls = false;
                      showMessages = true;
                    });
                  },
                  child: Text(ConStrings.MESSAGES,
                      style: showMessages
                          ? TextStyles.selectedOrdersStyle
                          : TextStyles.ordersStyle,
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          OrderTile()
        ],
      ),
    );
  }
}
