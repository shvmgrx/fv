import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/models/order.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/resources/order_methods.dart';
// import 'package:fv/widgets/nmButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fv/models/user.dart';
// import 'package:fv/onboarding/strings.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/screens/chatscreens/chat_screen.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/nmBox.dart';
import 'package:provider/provider.dart';
// import 'package:fv/widgets/priceCard.dart';

import 'package:intl/intl.dart';

// import 'package:smooth_star_rating/smooth_star_rating.dart';
// import 'package:fv/models/influencer.dart';
import 'package:swipedetector/swipedetector.dart';

class InfluencerDetails extends StatefulWidget {
  final User selectedInfluencer;

  InfluencerDetails({this.selectedInfluencer});

  @override
  _InfluencerDetailsState createState() => _InfluencerDetailsState();
}

class _InfluencerDetailsState extends State<InfluencerDetails>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation anim;
  final OrderMethods _orderMethods = OrderMethods();
  FirebaseRepository _repository = FirebaseRepository();

  bool showts1 = false;
  bool ts1Bought = false;
  String ts1;
  int ts1Duration;

  bool showts2 = false;
  bool ts2Bought = false;
  String ts2;
  int ts2Duration;

  bool showts3 = false;
  bool ts3Bought = false;
  String ts3;
  int ts3Duration;

  bool showts4 = false;
  bool ts4Bought = false;
  String ts4;
  int ts4Duration;

  bool showts5 = false;
  bool ts5Bought = false;
  String ts5;
  int ts5Duration;

  bool showts6 = false;
  bool ts6Bought = false;
  String ts6;
  int ts6Duration;

  bool showts7 = false;
  bool ts7Bought = false;
  String ts7;
  int ts7Duration;

  int selectedUserinfReceived;
  //used for currency

  List<Order> sellerOrderList;
  List<String> compareList = [];

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    anim = TextStyleTween(
            begin: TextStyles.usernameStyleBegin,
            end: TextStyles.usernameStyleEnd)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    getIVideoOrders();
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

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void pullUp() {
    controller.forward();
  }

  void pullDown() {
    controller.reverse();
  }

  void getIVideoOrders() {
    _repository
        .fetchSellerOrders(widget.selectedInfluencer.uid)
        .then((List<Order> list) {
      setState(() {
        sellerOrderList = list;
      });

      for (int i = 0; i < sellerOrderList.length; i++) {
        setState(() {
          compareList.add(sellerOrderList[i].uid);
        });
      }

      for (int i = 0; i < compareList.length; i++) {
        print(compareList[i]);
        //case1
        if (widget.selectedInfluencer.timeSlots['ttIds'][0] == compareList[i]) {
          setState(() {
            ts1Bought = true;
          });
        }
        if (widget.selectedInfluencer.timeSlots['ttIds'][1] == compareList[i]) {
          setState(() {
            ts2Bought = true;
          });
        }
        if (widget.selectedInfluencer.timeSlots['ttIds'][2] == compareList[i]) {
          setState(() {
            ts3Bought = true;
          });
        }
        if (widget.selectedInfluencer.timeSlots['ttIds'][3] == compareList[i]) {
          setState(() {
            ts4Bought = true;
          });
        }
        if (widget.selectedInfluencer.timeSlots['ttIds'][4] == compareList[i]) {
          setState(() {
            ts5Bought = true;
          });
        }
        if (widget.selectedInfluencer.timeSlots['ttIds'][5] == compareList[i]) {
          setState(() {
            ts6Bought = true;
          });
        }
        if (widget.selectedInfluencer.timeSlots['ttIds'][6] == compareList[i]) {
          setState(() {
            ts7Bought = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    setState(() {
      selectedUserinfReceived = widget.selectedInfluencer.infReceived;

      ts1 = widget.selectedInfluencer.timeSlots == null
          ? "nullDate"
          : dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][0]);
      ts2 = widget.selectedInfluencer.timeSlots == null
          ? "nullDate"
          : dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][1]);
      ts3 = widget.selectedInfluencer.timeSlots == null
          ? "nullDate"
          : dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][2]);
      ts4 = widget.selectedInfluencer.timeSlots == null
          ? "nullDate"
          : dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][3]);
      ts5 = widget.selectedInfluencer.timeSlots == null
          ? "nullDate"
          : dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][4]);
      ts6 = widget.selectedInfluencer.timeSlots == null
          ? "nullDate"
          : dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][5]);
      ts7 = widget.selectedInfluencer.timeSlots == null
          ? "nullDate"
          : dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][6]);

      if (ts1 != "nullDate") {
        var now = DateTime.now();

        var t = widget.selectedInfluencer.timeSlots['ttSlots'][0].seconds;
        var t1 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

        if (t1.isBefore(now)) {
          showts1 = false;
        } else if (now.isBefore(t1)) {
          showts1 = true;
        }
      }

      if (ts2 != "nullDate") {
        var now = DateTime.now();

        var t = widget.selectedInfluencer.timeSlots['ttSlots'][0].seconds;
        var t2 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

        if (t2.isBefore(now)) {
          showts2 = false;
        } else if (now.isBefore(t2)) {
          showts2 = true;
        }
      }

      if (ts3 != "nullDate") {
        var now = DateTime.now();

        var t = widget.selectedInfluencer.timeSlots['ttSlots'][0].seconds;
        var t3 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

        if (t3.isBefore(now)) {
          showts3 = false;
        } else if (now.isBefore(t3)) {
          showts3 = true;
        }
      }

      if (ts4 != "nullDate") {
        var now = DateTime.now();

        var t = widget.selectedInfluencer.timeSlots['ttSlots'][0].seconds;
        var t4 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

        if (t4.isBefore(now)) {
          showts4 = false;
        } else if (now.isBefore(t4)) {
          showts4 = true;
        }
      }

      if (ts5 != "nullDate") {
        var now = DateTime.now();

        var t = widget.selectedInfluencer.timeSlots['ttSlots'][0].seconds;
        var t5 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

        if (t5.isBefore(now)) {
          showts5 = false;
        } else if (now.isBefore(t5)) {
          showts5 = true;
        }
      }

      if (ts6 != "nullDate") {
        var now = DateTime.now();

        var t = widget.selectedInfluencer.timeSlots['ttSlots'][0].seconds;
        var t6 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

        if (t6.isBefore(now)) {
          showts6 = false;
        } else if (now.isBefore(t6)) {
          showts6 = true;
        }
      }

      if (ts7 != "nullDate") {
        var now = DateTime.now();

        var t = widget.selectedInfluencer.timeSlots['ttSlots'][0].seconds;
        var t7 = new DateTime.fromMillisecondsSinceEpoch(t * 1000);

        if (t7.isBefore(now)) {
          showts7 = false;
        } else if (now.isBefore(t7)) {
          showts7 = true;
        }
      }

      ts1Duration = widget.selectedInfluencer.timeSlots == null
          ? 0
          : widget.selectedInfluencer.timeSlots['ttDurations'][0];
      ts2Duration = widget.selectedInfluencer.timeSlots == null
          ? 0
          : widget.selectedInfluencer.timeSlots['ttDurations'][1];
      ts3Duration = widget.selectedInfluencer.timeSlots == null
          ? 0
          : widget.selectedInfluencer.timeSlots['ttDurations'][2];
      ts4Duration = widget.selectedInfluencer.timeSlots == null
          ? 0
          : widget.selectedInfluencer.timeSlots['ttDurations'][3];
      ts5Duration = widget.selectedInfluencer.timeSlots == null
          ? 0
          : widget.selectedInfluencer.timeSlots['ttDurations'][4];
      ts6Duration = widget.selectedInfluencer.timeSlots == null
          ? 0
          : widget.selectedInfluencer.timeSlots['ttDurations'][5];
      ts7Duration = widget.selectedInfluencer.timeSlots == null
          ? 0
          : widget.selectedInfluencer.timeSlots['ttDurations'][6];
    });

    sendOrder(int sTime, int sDuration, int infReceived) {
      int orderPrice;

      int _generatePrice() {
        int basePrice = widget.selectedInfluencer.answerPrice3;

        switch (sDuration) {
          case 1:
            {
              setState(() {
                orderPrice = (basePrice * 1.333).ceil();
              });
            }
            break;

          case 2:
            {
              setState(() {
                orderPrice = (basePrice * 2.667).ceil();
              });
            }
            break;

          default:
            {
              setState(() {
                orderPrice = basePrice;
              });
            }
            break;
        }
        return orderPrice;
      }

      Order _order = Order(
        uid: widget.selectedInfluencer.timeSlots['ttIds'][sTime],
        isBought: true,
        buyerId: userProvider.getUser.uid,
        buyerName: userProvider.getUser.name,
        buyerPhoto: userProvider.getUser.profilePhoto,
        sellerId: widget.selectedInfluencer.uid,
        sellerName: widget.selectedInfluencer.name,
        sellerPhoto: widget.selectedInfluencer.profilePhoto,
        boughtOn: Timestamp.now(),
        slotTime: widget.selectedInfluencer.timeSlots['ttSlots'][sTime] != null
            ? widget.selectedInfluencer.timeSlots['ttSlots'][sTime]
            : null,
        slotDuration: sDuration,
        price: _generatePrice(),
        currency: infReceived,
      );

      Order _sellerOrder = Order(
          uid: widget.selectedInfluencer.timeSlots['ttIds'][sTime],
          isBought: true,
          buyerId: userProvider.getUser.uid,
          sellerId: widget.selectedInfluencer.uid,
          sellerName: widget.selectedInfluencer.name,
          sellerPhoto: widget.selectedInfluencer.profilePhoto,
          buyerName: userProvider.getUser.name,
          buyerPhoto: userProvider.getUser.profilePhoto,
          currency: infReceived,
          boughtOn: Timestamp.now(),
          slotTime: widget.selectedInfluencer.timeSlots['ttSlots'][sTime],
          slotDuration: sDuration,
          price: _generatePrice());

      Order _buyerOrder = Order(
          uid: widget.selectedInfluencer.timeSlots['ttIds'][sTime],
          isBought: true,
          buyerId: userProvider.getUser.uid,
          sellerId: widget.selectedInfluencer.uid,
          sellerName: widget.selectedInfluencer.name,
          sellerPhoto: widget.selectedInfluencer.profilePhoto,
          buyerName: userProvider.getUser.name,
          buyerPhoto: userProvider.getUser.profilePhoto,
          currency: infReceived,
          boughtOn: Timestamp.now(),
          slotTime: widget.selectedInfluencer.timeSlots['ttSlots'][sTime],
          slotDuration: sDuration,
          price: _generatePrice());

      _orderMethods.addOrderToDb(_order);
      _orderMethods.addOrderToSellerDb(
        _sellerOrder,
      );
      _orderMethods.addOrderToBuyerDb(_buyerOrder);
    }

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final snackBar = SnackBar(
        content: Text(
      ConStrings.ALREADYBOOKED,
      style: TextStyles.fvSnackbar,
    ));

    return Scaffold(
      key: _scaffoldKey,
      body: SwipeDetector(
        onSwipeUp: () {
          pullUp();
        },
        onSwipeDown: () {
          pullDown();
        },
        swipeConfiguration: SwipeConfiguration(
          verticalSwipeMinVelocity: 2.0,
          verticalSwipeMinDisplacement: 1.0,
          verticalSwipeMaxWidthThreshold: 120.0,
        ),
        child: Stack(
          children: <Widget>[
            Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.transparent),
            GestureDetector(
              onTap: () {
                pullDown();
              },
              child: Container(
                height: screenHeight - screenHeight / 3,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.rd.com%2Fwp-content%2Fuploads%2Fsites%2F2%2F2016%2F03%2F03-nighttime-habits-great-skin-products.jpg&f=1&nofb=1'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              top: screenHeight - (screenHeight / 2) - controller.value * 300,
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                height: screenHeight,
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

                      // SizedBox(height: 7.0),

                      // SizedBox(height: 1.0),
                      widget.selectedInfluencer.bio != null
                          ? Container(
                              width: 180,
                              child: Text(widget.selectedInfluencer.bio,
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: UniversalVariables.grey2)),
                            )
                          : Container(
                              width: 175,
                              child: Text(
                                "Nam quis nulla. Integer malesuada. In in enim a arcu imperdiet malesuada. Sed vel lectus. Donec odio urna, tempus molest",
                                style: GoogleFonts.sourceSansPro(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: UniversalVariables.grey2),
                              ),
                            ),

                      SizedBox(height: 5.0),

                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80.0,
                                    width: screenWidth / 4,
                                    decoration: BoxDecoration(

                                        //gradient: UniversalVariables.fabGradient,

                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(5.0),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: widget.selectedInfluencer
                                                        .answerPrice1 !=
                                                    null
                                                ? Text(
                                                    "\$ ${widget.selectedInfluencer.answerPrice1}",
                                                    style:
                                                        TextStyles.priceNumber,
                                                    textAlign: TextAlign.center)
                                                : Text("Not Set",
                                                    style: TextStyles
                                                        .notSetPriceNumber,
                                                    textAlign:
                                                        TextAlign.center),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                                  height: 80.0,
                                  width: screenWidth / 4,
                                  decoration: BoxDecoration(

                                      //gradient: UniversalVariables.fabGradient,

                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0),
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: widget.selectedInfluencer
                                                      .answerPrice1 !=
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
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pullUp();
                                },
                                child: Container(
                                  height: 80.0,
                                  width: screenWidth / 4,
                                  decoration: BoxDecoration(

                                      //gradient: UniversalVariables.fabGradient,

                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0),
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Videocall",
                                                style: TextStyles.priceType,
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: widget.selectedInfluencer
                                                      .answerPrice1 !=
                                                  null
                                              ? Text(
                                                  "\$ ${widget.selectedInfluencer.answerPrice3}",
                                                  style: TextStyles.priceNumber,
                                                  textAlign: TextAlign.center)
                                              : Text("Not Set",
                                                  style: TextStyles
                                                      .notSetPriceNumber,
                                                  textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                            height: screenHeight * 0.9,
                            width: screenWidth * 0.9,
                            color: UniversalVariables.transparent,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: <Widget>[
                                  //TS1
                                  Visibility(
                                    visible: showts1,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 0, bottom: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text("$ts1",
                                                      style: TextStyles
                                                          .timeTextDetailStyle),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Text(
                                                        "${durationMaker(ts1Duration)} mins",
                                                        style: TextStyles
                                                            .timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 1.0,
                                              ),
                                              child: InkWell(
                                                onTap: () => {
                                                  if (!ts1Bought)
                                                    {
                                                      sendOrder(0, ts1Duration,
                                                          selectedUserinfReceived)
                                                    }
                                                  else if (ts1Bought)
                                                    {
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar)
                                                    }
                                                },
                                                child: Container(
                                                  // color:Colors.orange,
                                                  //    width: 75,
                                                  decoration: BoxDecoration(
                                                    color: ts1Bought
                                                        ? UniversalVariables
                                                            .offline
                                                        : UniversalVariables
                                                            .online,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: Center(
                                                      child: ts1Bought
                                                          ? Text(
                                                              ConStrings
                                                                  .bookUnavailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails)
                                                          : Text(
                                                              ConStrings
                                                                  .bookAvailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS2
                                  Visibility(
                                    visible: showts2,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 0, bottom: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text("$ts2",
                                                      style: TextStyles
                                                          .timeTextDetailStyle),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Text(
                                                        "${durationMaker(ts2Duration)} mins",
                                                        style: TextStyles
                                                            .timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 1.0,
                                              ),
                                              child: InkWell(
                                                onTap: () => {
                                                  if (!ts2Bought)
                                                    {
                                                      sendOrder(1, ts2Duration,
                                                          selectedUserinfReceived),
                                                    }
                                                  else if (ts2Bought)
                                                    {
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar)
                                                    }
                                                },
                                                child: Container(
                                                  //  color:Colors.orange,
                                                  //    width: 75,
                                                  decoration: BoxDecoration(
                                                    color: ts2Bought
                                                        ? UniversalVariables
                                                            .offline
                                                        : UniversalVariables
                                                            .online,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: Center(
                                                      child: ts2Bought
                                                          ? Text(
                                                              ConStrings
                                                                  .bookUnavailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails)
                                                          : Text(
                                                              ConStrings
                                                                  .bookAvailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS3
                                  Visibility(
                                    visible: showts3,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 0, bottom: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text("$ts3",
                                                      style: TextStyles
                                                          .timeTextDetailStyle),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Text(
                                                        "${durationMaker(ts3Duration)} mins",
                                                        style: TextStyles
                                                            .timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 1.0,
                                              ),
                                              child: InkWell(
                                                onTap: () => {
                                                  if (!ts3Bought)
                                                    {
                                                      sendOrder(2, ts3Duration,
                                                          selectedUserinfReceived),
                                                    }
                                                  else if (ts3Bought)
                                                    {
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar)
                                                    }
                                                },
                                                child: Container(
                                                  // color:Colors.orange,
                                                  //    width: 75,
                                                  decoration: BoxDecoration(
                                                    color: ts3Bought
                                                        ? UniversalVariables
                                                            .offline
                                                        : UniversalVariables
                                                            .online,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: Center(
                                                      child: ts3Bought
                                                          ? Text(
                                                              ConStrings
                                                                  .bookUnavailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails)
                                                          : Text(
                                                              ConStrings
                                                                  .bookAvailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS4
                                  Visibility(
                                    visible: showts4,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 0, bottom: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text("$ts4",
                                                      style: TextStyles
                                                          .timeTextDetailStyle),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Text(
                                                        "${durationMaker(ts4Duration)} mins",
                                                        style: TextStyles
                                                            .timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 1.0,
                                              ),
                                              child: InkWell(
                                                onTap: () => {
                                                  if (!ts4Bought)
                                                    {
                                                      sendOrder(3, ts4Duration,
                                                          selectedUserinfReceived),
                                                    }
                                                  else if (ts4Bought)
                                                    {
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar)
                                                    }
                                                },
                                                child: Container(
                                                  // color:Colors.orange,
                                                  //    width: 75,
                                                  decoration: BoxDecoration(
                                                    color: ts4Bought
                                                        ? UniversalVariables
                                                            .offline
                                                        : UniversalVariables
                                                            .online,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: Center(
                                                      child: ts4Bought
                                                          ? Text(
                                                              ConStrings
                                                                  .bookUnavailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails)
                                                          : Text(
                                                              ConStrings
                                                                  .bookAvailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS5
                                  Visibility(
                                    visible: showts5,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 0, bottom: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text("$ts5",
                                                      style: TextStyles
                                                          .timeTextDetailStyle),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Text(
                                                        "${durationMaker(ts5Duration)} mins",
                                                        style: TextStyles
                                                            .timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 1.0,
                                              ),
                                              child: InkWell(
                                                onTap: () => {
                                                  if (!ts5Bought)
                                                    {
                                                      sendOrder(4, ts5Duration,
                                                          selectedUserinfReceived),
                                                    }
                                                  else if (ts5Bought)
                                                    {
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar)
                                                    }
                                                },
                                                child: Container(
                                                  // color:Colors.orange,
                                                  //    width: 75,
                                                  decoration: BoxDecoration(
                                                    color: ts5Bought
                                                        ? UniversalVariables
                                                            .offline
                                                        : UniversalVariables
                                                            .online,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: Center(
                                                      child: ts5Bought
                                                          ? Text(
                                                              ConStrings
                                                                  .bookUnavailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails)
                                                          : Text(
                                                              ConStrings
                                                                  .bookAvailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS6
                                  Visibility(
                                    visible: showts6,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 0, bottom: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text("$ts6",
                                                      style: TextStyles
                                                          .timeTextDetailStyle),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Text(
                                                        "${durationMaker(ts6Duration)} mins",
                                                        style: TextStyles
                                                            .timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 1.0,
                                              ),
                                              child: InkWell(
                                                onTap: () => {
                                                  if (!ts6Bought)
                                                    {
                                                      sendOrder(5, ts6Duration,
                                                          selectedUserinfReceived),
                                                    }
                                                  else if (ts6Bought)
                                                    {
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar)
                                                    }
                                                },
                                                child: Container(
                                                  // color:Colors.orange,
                                                  //    width: 75,
                                                  decoration: BoxDecoration(
                                                    color: ts6Bought
                                                        ? UniversalVariables
                                                            .offline
                                                        : UniversalVariables
                                                            .online,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: Center(
                                                      child: ts6Bought
                                                          ? Text(
                                                              ConStrings
                                                                  .bookUnavailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails)
                                                          : Text(
                                                              ConStrings
                                                                  .bookAvailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TS7
                                  Visibility(
                                    visible: showts7,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 0, bottom: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text("$ts7",
                                                      style: TextStyles
                                                          .timeTextDetailStyle),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Text(
                                                        "${durationMaker(ts7Duration)} mins",
                                                        style: TextStyles
                                                            .timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 1.0,
                                              ),
                                              child: InkWell(
                                                onTap: () => {
                                                  if (!ts7Bought)
                                                    {
                                                      sendOrder(6, ts7Duration,
                                                          selectedUserinfReceived),
                                                    }
                                                  else if (ts7Bought)
                                                    {
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar)
                                                    }
                                                },
                                                child: Container(
                                                  // color:Colors.orange,
                                                  //    width: 75,
                                                  decoration: BoxDecoration(
                                                    color: ts7Bought
                                                        ? UniversalVariables
                                                            .offline
                                                        : UniversalVariables
                                                            .online,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: Center(
                                                      child: ts7Bought
                                                          ? Text(
                                                              ConStrings
                                                                  .bookUnavailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails)
                                                          : Text(
                                                              ConStrings
                                                                  .bookAvailable,
                                                              style: TextStyles
                                                                  .timeSlotDetails),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 30.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalVariables.white2),
                    child: Center(
                      child: Icon(Icons.arrow_back,
                          size: 20.0, color: UniversalVariables.grey1),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight -
                  screenHeight / 2.5 -
                  65.0 -
                  (controller.value * 300) -
                  50,
              right: 35.0,
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
                  InkWell(
                    onTap: () {
                      getIVideoOrders();
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          widget.selectedInfluencer.username != null
                              ? Text(
                                  widget.selectedInfluencer.username,
                                  //style: TextStyles.usernameStyleEnd,
                                  style: anim.value,
                                )
                              : Text(
                                  "faveezUsername",
                                  style: TextStyles.usernameStyleEnd,
                                ),
                          Icon(
                            Icons.verified_user,
                            color: UniversalVariables.gold2,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
