import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/resources/order_methods.dart';
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

  final OrderMethods _orderMethods = OrderMethods();

  ScrollController _oController = ScrollController();

  FirebaseUser loggedUser;
  String loggedUserDisplayName;
  String loggedUserUID;

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
          loggedUserUID = loggedUser['uid'];

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

  //   buildOrders(loggedUserUID) {

  //   final List<> suggestionList = (loggedUserUID.isEmpty)
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
  //           Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) =>
  //                   InfluencerDetails(selectedInfluencer: searchedUser)));
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

  Widget oList() {
    print("startoooooo");
    return StreamBuilder(
      stream: Firestore.instance
          .collection("orders")
          // .document(loggedUserUID)
          // .collection(loggedUserUID)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        print("TABLA: ${snapshot.data.documents}");

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.documents.length,
          reverse: true,
          controller: _oController,
          itemBuilder: (context, index) {
            return Text("${snapshot.data}");
          },
        );
      },
    );
  }

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
                    color: UniversalVariables.grey2,
                  ),
                  onPressed: () {
                    _repository.fetchBuyerOrders(loggedUserUID);
                  },
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
          OrderTile(
            sellerPhoto: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                ),
              ),
            ),
            sellerName: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("inf name"),
            ),
            buyerPhoto: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.pexels.com/photos/5119214/pexels-photo-5119214.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                ),
              ),
            ),
            buyerName: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("user name"),
            ),
            slotTime: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "August 20, 20:30",
                style: TextStyles.hintTextStyle,
              ),
            ),
            slotDuration: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "15 mins",
                style: TextStyles.hintTextStyle,
              ),
            ),
            orderId: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "dfvb34r68wfnu3378g4",
                style: TextStyles.hintTextStyle,
              ),
            ),
            price: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "#15",
                style: TextStyles.hintTextStyle,
              ),
            ),
          ),
          Flexible(
            child: oList(),
          ),
        ],
      ),
    );
  }
}
