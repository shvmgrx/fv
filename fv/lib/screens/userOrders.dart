import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fv/constants/conStrings.dart';
// import 'package:fv/constants/strings.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/txtOrder.dart';
// import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/resources/order_methods.dart';
import 'package:fv/screens/home_screen.dart';
import 'package:fv/models/influencer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/messageTile.dart';
import 'package:fv/widgets/orderTile.dart';
import 'package:intl/intl.dart';

// import 'package:provider/provider.dart';

class UserOrders extends StatefulWidget {
  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
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

  bool showVideocalls = false;
  bool showPreVideocalls = true;
  bool showMessages = false;
  bool showPreMessages = false;

  List<Order> buyerOrderList;
  List<TxtOrder> buyerTxtOrderList;

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

    showVideoOrders();
    showTxtOrders();

    _repository.getCurrentUser().then((FirebaseUser user) {
      setState(() {
        loggedUserDisplayName = user.displayName;
        loggedUserProfilePic = user.photoUrl;
      });
    });

    _repository.fetchBuyerOrders(loggedUserUID).then((List<Order> list) {
      setState(() {
        buyerOrderList = list;
      });
    });

    super.initState();
  }

  void showVideoOrders() {
    _repository.fetchBuyerOrders(loggedUserUID).then((List<Order> list) {
      setState(() {
        buyerOrderList = list;
      });
    });
  }

  void showTxtOrders() {
    _repository
        .fetchBuyerTxtOrders(loggedUserUID)
        .then((List<TxtOrder> txtlist) {
      setState(() {
        buyerTxtOrderList = txtlist;
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

  Widget getOrderWidgets(List<Order> buyerOrderList) {
    List<Widget> list = new List<Widget>();

    for (var i = 0; i < buyerOrderList.length; i++) {
      list.add(OrderTile(
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
      ));
    }
    return new Column(children: list);
  }

  Widget getTxtOrderWidgets(List<TxtOrder> buyerTxtOrderList) {
    List<Widget> txtList = new List<Widget>();

    print("cvdjh: ${buyerTxtOrderList.length}");

    for (var i = 0; i < buyerTxtOrderList.length; i++) {
      txtList.add(
          // Text(buyerTxtOrderList[i].sellerName)

          MessageTile(
        sellerPhoto: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("${buyerTxtOrderList[i].sellerPhoto}"),
            ),
          ),
        ),
        sellerName: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("${buyerTxtOrderList[i].sellerName}"),
        ),
        buyerPhoto: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("${buyerTxtOrderList[i].buyerPhoto}"),
            ),
          ),
        ),
        buyerName: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("${buyerTxtOrderList[i].buyerName}"),
        ),
        orderId: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "${buyerTxtOrderList[i].uid}",
            style: TextStyles.orderIDStyle,
          ),
        ),
        price: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: buyerTxtOrderList[i].currency == 0
              ? Text(
                  "\$ ${buyerTxtOrderList[i].price}",
                  style: TextStyles.hintTextStyle,
                )
              : Text(
                  "€ ${buyerTxtOrderList[i].price}",
                  style: TextStyles.hintTextStyle,
                ),
        ),
      ));
    }
    return new Column(children: txtList);
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
                      showVideocalls = false;
                      showMessages = false;
                      showPreMessages = false;
                      showPreVideocalls = true;
                    });

                    if (showVideocalls) {
                      showVideoOrders();
                    }
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
          SizedBox(height: screenHeight * 0.04),
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
                              showVideoOrders()
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
              visible: showVideocalls, child: getOrderWidgets(buyerOrderList)),
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
                              showTxtOrders(),
                              setState(() {
                                showPreVideocalls = false;
                                showPreMessages = false;
                                showVideocalls = false;
                                showMessages = true;
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
              child: getTxtOrderWidgets(buyerTxtOrderList)),
        ],
      ),
    );
  }
}
