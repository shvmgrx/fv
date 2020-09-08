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
import 'package:fv/widgets/influencerOrderTile.dart';
import 'package:fv/widgets/orderTile.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class InfluencerOrders extends StatefulWidget {
  @override
  _InfluencerOrdersState createState() => _InfluencerOrdersState();
}

class _InfluencerOrdersState extends State<InfluencerOrders> {
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

  List<Order> sellerOrderList;

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

    _repository.fetchSellerOrders(loggedUserUID).then((List<Order> list) {
      setState(() {
        sellerOrderList = list;
        print("happu: $list");
        for (var i = 0; i < list.length; i++) {
          sellerOrderList.add(list[i]);

          print("ghg: ${list[i].buyerName}");
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
    return sellerOrderList[i] != null
        ? OrderTile(
            sellerPhoto: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${sellerOrderList[i].sellerPhoto}"),
                ),
              ),
            ),
            sellerName: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${sellerOrderList[i].sellerName}"),
            ),
            buyerPhoto: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${sellerOrderList[i].buyerPhoto}"),
                ),
              ),
            ),
            buyerName: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${sellerOrderList[i].buyerName}"),
            ),
            slotTime: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${dateMaker(sellerOrderList[i].slotTime)}",
                style: TextStyles.hintTextStyle,
              ),
            ),
            slotDuration: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${durationMaker(sellerOrderList[i].slotDuration)} mins",
                style: TextStyles.hintTextStyle,
              ),
            ),
            orderId: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${sellerOrderList[i].uid}",
                style: TextStyles.orderIDStyle,
              ),
            ),
            price: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: sellerOrderList[i].currency == 0
                  ? Text(
                      "\$ ${sellerOrderList[i].price}",
                      style: TextStyles.hintTextStyle,
                    )
                  : Text(
                      "€ ${sellerOrderList[i].price}",
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
                    _repository.fetchSellerOrders(loggedUserUID);
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
          // InfluencerOrderTile(
          //   buyerPhotoName: Row(
          //     children: [
          //       Container(
          //         width: 40.0,
          //         height: 40.0,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           image: DecorationImage(
          //             fit: BoxFit.cover,
          //             image: NetworkImage("${sellerOrderList[0].buyerPhoto}"),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 8.0),
          //         child: Text("${sellerOrderList[0].buyerName}"),
          //       ),
          //     ],
          //   ),
          //   slotTime: Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: Text(
          //       "${dateMaker(sellerOrderList[0].slotTime)}",
          //       style: TextStyles.hintTextStyle,
          //     ),
          //   ),
          //   slotDuration: Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: Text(
          //       "${durationMaker(sellerOrderList[0].slotDuration)} mins",
          //       style: TextStyles.hintTextStyle,
          //     ),
          //   ),
          //   orderId: Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: Text(
          //       "${sellerOrderList[0].uid}",
          //       style: TextStyles.orderIDStyle,
          //     ),
          //   ),
          //   price: Padding(
          //     padding: const EdgeInsets.only(left: 8.0),
          //     child: sellerOrderList[0].currency == 0
          //         ? Text(
          //             "\$ ${sellerOrderList[0].price}",
          //             style: TextStyles.hintTextStyle,
          //           )
          //         : Text(
          //             "€ ${sellerOrderList[0].price}",
          //             style: TextStyles.hintTextStyle,
          //           ),
          //   ),
          // )
        ],
      ),
    );
  }
}
