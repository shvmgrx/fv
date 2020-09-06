import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/resources/order_methods.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/orderTile.dart';
import 'package:intl/intl.dart';

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

  List<Order> buyerOrderList;

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
      loggedUserDisplayName = user.displayName;
      loggedUserProfilePic = user.photoUrl;
    });

    _repository.fetchBuyerOrders(loggedUserUID).then((List<Order> list) {
      setState(() {
        buyerOrderList = list;
        print(list);
        for (var i = 0; i < list.length; i++) {
          buyerOrderList.add(list[i]);

          print("ghg: ${buyerOrderList[i].buyerName}");
        }
      });
    });
  }

  String dateMaker(Timestamp theSetDate) {
    if (theSetDate != null) {
      var temp = theSetDate.toDate();
      var formatter = new DateFormat('MMMM d, HH:mm');
      String convertedDate = formatter.format(temp);
      return convertedDate;
    } else {
      var nullDate = "nullDate";
      return nullDate;
    }
  }

  int durationMaker(int durationType) {
    int mins;

    switch (durationType) {
      case 0:
        mins = 10;
        break;
      case 1:
        mins = 15;
        break;
      case 2:
        mins = 20;
        break;
      default:
        mins = 10;
    }

    return mins;
  }

  Widget orderMaker(int i) {
    return buyerOrderList[i] != null
        ? OrderTile(
            sellerPhoto: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${buyerOrderList[i].sellerPhoto}"),
                ),
              ),
            ),
            sellerName: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${buyerOrderList[i].sellerName}"),
            ),
            buyerPhoto: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${buyerOrderList[i].buyerPhoto}"),
                ),
              ),
            ),
            buyerName: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${buyerOrderList[i].buyerName}"),
            ),
            slotTime: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${dateMaker(buyerOrderList[i].slotTime)}",
                style: TextStyles.hintTextStyle,
              ),
            ),
            slotDuration: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${durationMaker(buyerOrderList[i].slotDuration)} mins",
                style: TextStyles.hintTextStyle,
              ),
            ),
            orderId: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${buyerOrderList[i].uid}",
                style: TextStyles.orderIDStyle,
              ),
            ),
            price: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: buyerOrderList[i].currency == 0
                  ? Text(
                      "\$ ${buyerOrderList[i].price}",
                      style: TextStyles.hintTextStyle,
                    )
                  : Text(
                      "€ ${buyerOrderList[i].price}",
                      style: TextStyles.hintTextStyle,
                    ),
            ),
          )
        : Container();
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
          // orderMaker(0)
        ],
      ),
    );
  }
}
