import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/txtOrder.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/resources/order_methods.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/influencerMessageTile.dart';
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

  bool showPreVideocalls = true;
  bool showVideocalls = false;

  bool showMessages = false;
  bool showPreMessages = false;

  int loggedUserWorth;

  List<Order> sellerOrderList;
  List<TxtOrder> sellerTxtOrderList;

  void initState() {
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserDisplayName = loggedUser['name'];
          loggedUserUID = loggedUser['uid'];

          loggedUserUserName = loggedUser['username'];

          loggedUserProfilePic = loggedUser['profilePhoto'];

          loggedUserisInfCert = loggedUser['isInfCert'];

          //loggedUserinfWorth = loggedUser['infWorth'];

          loggedUserinfReceived = loggedUser['infReceived'];
          loggedUserisInfluencer = loggedUser['isInfluencer'];
          // loggedUserWorth = loggedUser['infWorth'];
        });
      });
    });

    incomeRevealer();

    super.initState();

    _repository.getCurrentUser().then((FirebaseUser user) {
      loggedUserDisplayName = user.displayName;
      loggedUserProfilePic = user.photoUrl;
    });
  }

  void incomeRevealer() {
    _orderMethods.fetchIncome(loggedUserUID).then((List worthValues) {
      var tempWorth = 0;

      for (int i = 0; i < worthValues.length; i++) {
        tempWorth = tempWorth + worthValues[i][0];
      }
      setState(() {
        loggedUserWorth = tempWorth;
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

  void showIVideoOrders() {
    _repository.fetchSellerOrders(loggedUserUID).then((List<Order> list) {
      setState(() {
        sellerOrderList = list;
      });
    });
  }

  void showITxtOrders() {
    _repository
        .fetchSellerTxtOrders(loggedUserUID)
        .then((List<TxtOrder> txtlist) {
      setState(() {
        sellerTxtOrderList = txtlist;
      });
    });
  }

  Widget getIOrderWidgets(List<Order> sellerOrderList) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> list = new List<Widget>();

    if (sellerOrderList != null) {
      if (sellerOrderList.length > 0) {
        for (var i = 0; i < sellerOrderList.length; i++) {
          list.add(InfluencerOrderTile(
            buyerPhotoName: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${sellerOrderList[i].buyerPhoto}"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "${sellerOrderList[i].buyerName}",
                    style: TextStyles.hintTextStyle,
                  ),
                ),
              ],
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
          ));
        }
      }
    }

    return new Column(children: list);
  }

  Widget getITxtOrderWidgets(List<TxtOrder> sellerTxtOrderList) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> list = new List<Widget>();

    if (sellerTxtOrderList != null) {
      if (sellerTxtOrderList.length > 0) {
        for (var i = 0; i < sellerTxtOrderList.length; i++) {
          list.add(InfluencerMessageTile(
            buyerPhotoName: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage("${sellerTxtOrderList[i].buyerPhoto}"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "${sellerTxtOrderList[i].buyerName}",
                    style: TextStyles.hintTextStyle,
                  ),
                ),
              ],
            ),
            orderId: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${sellerTxtOrderList[i].uid}",
                style: TextStyles.orderIDStyle,
              ),
            ),
            price: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: sellerTxtOrderList[i].currency == 0
                  ? Text(
                      "\$ ${sellerTxtOrderList[i].price}",
                      style: TextStyles.hintTextStyle,
                    )
                  : Text(
                      "€ ${sellerTxtOrderList[i].price}",
                      style: TextStyles.hintTextStyle,
                    ),
            ),
          ));
        }
      }
    }

    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    incomeRevealer();
    // showIVideoOrders();

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
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: loggedUserinfReceived == 1
                      ? loggedUserWorth != null
                          ? Text(
                              "€ $loggedUserWorth",
                              style: TextStyles.moneyStyle,
                            )
                          : Text(
                              "€ 0",
                              style: TextStyles.moneyStyle,
                            )
                      : loggedUserWorth != null
                          ? Text(
                              "\$ $loggedUserWorth",
                              style: TextStyles.moneyStyle,
                            )
                          : Text(
                              "\$ 0",
                              style: TextStyles.moneyStyle,
                            ),
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
                      showVideocalls = false;
                      showPreVideocalls = true;
                      showMessages = false;
                      showPreMessages = false;
                    });
                  },
                  child: Text(ConStrings.VIDEOCALLS,
                      style: showPreVideocalls || showVideocalls
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
                      showMessages = false;
                      showPreMessages = true;
                      showPreVideocalls = false;
                    });
                  },
                  child: Text(ConStrings.MESSAGES,
                      style: showPreMessages || showMessages
                          ? TextStyles.selectedOrdersStyle
                          : TextStyles.ordersStyle,
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Visibility(
            visible: showPreVideocalls,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                    color: UniversalVariables.white2,
                  ),
                  height: screenHeight * 0.45,
                  width: screenWidth * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: SvgPicture.asset(
                            "assets/vr.svg",
                            height: screenHeight * 0.08,
                            // width: 25,
                            // alignment: Alignment.topCenter,
                            color: UniversalVariables.gold2,
                          )),
                      Expanded(
                        flex: 3,
                        child: Text(ConStrings.VIDEOCALLS_DETAIL,
                            style: TextStyles.fvCodeHeading,
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Expanded(
                          // flex: 3,
                          child: OutlineButton(
                            onPressed: () => {
                              setState(() {
                                showPreVideocalls = false;
                                showVideocalls = true;
                                showMessages = false;
                              }),
                              showIVideoOrders()
                            },
                            child: Text(
                              ConStrings.SHOW_VIDEOCALLS,
                              style: TextStyles.editHeadingName,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
              visible: showVideocalls,
              child: getIOrderWidgets(sellerOrderList)),
          Visibility(
            visible: showPreMessages,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                    color: UniversalVariables.white2,
                  ),
                  height: screenHeight * 0.45,
                  width: screenWidth * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: SvgPicture.asset(
                            "assets/tr.svg",
                            height: screenHeight * 0.08,
                            // width: 25,
                            // alignment: Alignment.topCenter,
                            color: UniversalVariables.gold2,
                          )),
                      Expanded(
                        flex: 3,
                        child: Text(ConStrings.MESSAGES_DETAIL,
                            style: TextStyles.fvCodeHeading,
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Expanded(
                          // flex: 3,
                          child: OutlineButton(
                            onPressed: () => {
                              showITxtOrders(),
                              setState(() {
                                showPreVideocalls = false;
                                showVideocalls = false;
                                showMessages = true;
                                showPreMessages = false;
                              }),
                            },
                            child: Text(
                              ConStrings.SHOW_MESSAGES,
                              style: TextStyles.editHeadingName,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
              visible: showMessages,
              child: getITxtOrderWidgets(sellerTxtOrderList)),
        ],
      ),
    );
  }
}
