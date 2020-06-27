import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/models/order.dart';
import 'package:fv/provider/user_provider.dart';
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
import 'dart:math';
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
  }

  String dateMaker(Timestamp theSetDate) {
    if (theSetDate != null) 
    {
      var temp = theSetDate.toDate();
      var formatter = new DateFormat('MMMM d, HH:mm');
      String convertedDate = formatter.format(temp);
      return convertedDate;
    }
    else{
      var nullDate= "nullDate";
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
        mins = 25;
        break;
      case 2:
        mins = 45;
        break;
      default:
        mins = 5;
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

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    setState(() {
      ts1 = widget.selectedInfluencer.timeSlots['ttSlots']== null? "nullDate": dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][0]);
      ts2 = widget.selectedInfluencer.timeSlots['ttSlots']== null? "nullDate": dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][1]);
      ts3 = widget.selectedInfluencer.timeSlots['ttSlots']== null? "nullDate": dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][2]);
      ts4 = widget.selectedInfluencer.timeSlots['ttSlots']== null? "nullDate": dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][3]);
      ts5 = widget.selectedInfluencer.timeSlots['ttSlots']== null? "nullDate": dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][4]);
      ts6 = widget.selectedInfluencer.timeSlots['ttSlots']== null? "nullDate": dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][5]);
      ts7 = widget.selectedInfluencer.timeSlots['ttSlots']== null? "nullDate": dateMaker(widget.selectedInfluencer.timeSlots['ttSlots'][6]);

      ts1Duration =durationMaker(widget.selectedInfluencer.timeSlots['ttDurations'][0]);
      ts2Duration =
          durationMaker(widget.selectedInfluencer.timeSlots['ttDurations'][1]);
      ts3Duration =
          durationMaker(widget.selectedInfluencer.timeSlots['ttDurations'][2]);
      ts4Duration =
          durationMaker(widget.selectedInfluencer.timeSlots['ttDurations'][3]);
      ts5Duration =
          durationMaker(widget.selectedInfluencer.timeSlots['ttDurations'][4]);
      ts6Duration =
          durationMaker(widget.selectedInfluencer.timeSlots['ttDurations'][5]);
      ts7Duration =
          durationMaker(widget.selectedInfluencer.timeSlots['ttDurations'][6]);
    });

    sendOrder(int sTime, int sDuration) {
      int orderPrice;

      int _generatePrice() {
        int basePrice = widget.selectedInfluencer.answerPrice3;

        switch (widget.selectedInfluencer.timeSlots['ttDurations'][sDuration]) {
          case 1:
            {
              setState(() {
                orderPrice = basePrice * 1.333.ceil();
              });
            }
            break;

          case 2:
            {
              setState(() {
                orderPrice = basePrice * 2.667.ceil();
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

      String _randomString() {
        var rand = new Random();
        var codeUnits = new List.generate(9, (index) {
          return rand.nextInt(33) + 89;
        });

        return new String.fromCharCodes(codeUnits);
      }


      Order _order = Order(
          uid: _randomString(),
          isBought: true,
          buyerId: userProvider.getUser.uid,
          buyerName: userProvider.getUser.name,
          buyerPhoto: userProvider.getUser.profilePhoto,
          sellerId: widget.selectedInfluencer.uid,
          boughtOn: Timestamp.now(),
          slotTime: widget.selectedInfluencer.timeSlots['ttSlots'][sTime],
          slotDuration: widget.selectedInfluencer.timeSlots['ttDurations'][sDuration],
          price: _generatePrice());

      // Order _sellerOrder = Order(
      //     uid: widget.selectedInfluencer.uid,
      //     isBought: true,
      //     buyerId: userProvider.getUser.uid,
      //     sellerId: widget.selectedInfluencer.uid,
      //     boughtOn: Timestamp.now(),
      //     slotTime: widget.selectedInfluencer.timeSlots['ttSlots'][sTime],
      //     slotDuration: widget.selectedInfluencer.timeSlots['ttDurations'][sDuration],
      //     price: _generatePrice());

      // Order _buyerOrder = Order(
      //     uid: userProvider.getUser.uid,
      //     isBought: true,
      //     buyerId: userProvider.getUser.uid,
      //     sellerId: widget.selectedInfluencer.uid,
      //     boughtOn: Timestamp.now(),
      //     slotTime: widget.selectedInfluencer.timeSlots['ttSlots'][sTime],
      //     slotDuration: widget.selectedInfluencer.timeSlots['ttDurations'][sDuration],
      //     price: _generatePrice());

      _orderMethods.addOrderToDb(_order);
      // _orderMethods.addOrderToSellerDb(_sellerOrder);
      // _orderMethods.addOrderToBuyerDb(_buyerOrder);
    }

    //bool showAppBar = true;

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      // Text('Read More',
                      //   style: GoogleFonts.sourceSansPro(
                      //     fontSize: 14.0,
                      //     fontWeight: FontWeight.w400,
                      //     color: Color(0xFFF36F32)
                      //   )
                      // ),
                      SizedBox(height: 15.0),
                      Container(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                         height: screenHeight*0.8,
                        width: screenWidth * 0.90,
                        color: UniversalVariables.transparent,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: <Widget>[
                              //TS1
                              Visibility(
                                visible: (ts1!="nullDate" && ts1Duration!=5),
                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: UniversalVariables.standardWhite,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      topRight: Radius.circular(100),
                                      //   bottomLeft: Radius.circular(10),
                                      //   bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0,
                                        left: 15,
                                        right: 8,
                                        bottom: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                              child: Row(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("$ts1",
                                                  style: TextStyles.timeTextDetailStyle),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                    child: Text("$ts1Duration mins",
                                                    style: TextStyles.timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                        ),

                                        Padding(
                                         padding: const EdgeInsets.only(left:8.0,right:25.0,top:8.0,bottom:8.0),
                                          child: InkWell(
                                          onTap: () =>{
                                            sendOrder(0, 0),
                                          },
                                                child: Container(
                                              // color:Colors.orange,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: UniversalVariables.separatorColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Center(
                                                  child: Text("BOOK",
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
                              Visibility(
                               visible: (ts2!="nullDate" && ts2Duration!=5),
                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: UniversalVariables.standardWhite,
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:15.0,right:8.0,top:8.0,bottom:8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                         MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                              child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("$ts2",
                                                  style: TextStyles.timeTextDetailStyle),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                    child: Text("$ts2Duration mins",
                                                    style: TextStyles.timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left:8.0,right:25.0,top:8.0,bottom:8.0),
                                          child: InkWell(
                                            onTap: () =>{
                                            sendOrder(1, 1),
                                          },
                                                                                      child: Container(
                                              // color:Colors.orange,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: UniversalVariables.separatorColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Center(
                                                  child: Text("BOOK",
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
                              Visibility(
                                 visible: (ts3!="nullDate" && ts3Duration!=5),
                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: UniversalVariables.standardWhite,
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  child: Padding(
                                   padding: const EdgeInsets.only(left:15.0,right:8.0,top:8.0,bottom:8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                         MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("$ts3",
                                                  style: TextStyles.timeTextDetailStyle),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                    child: Text("$ts3Duration mins",
                                                    style: TextStyles.timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:25.0,top:8.0,bottom:8.0),
                                          child: InkWell(
                                            onTap: () =>{
                                            sendOrder(2, 2),
                                          },
                                                                                      child: Container(
                                              // color:Colors.orange,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: UniversalVariables.separatorColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Center(
                                                  child: Text("BOOK",
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
                              Visibility(
                                 visible: (ts4!="nullDate" && ts4Duration!=5),
                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: UniversalVariables.standardWhite,
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  child: Padding(
                                   padding: const EdgeInsets.only(left:15.0,right:8.0,top:8.0,bottom:8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                       Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("$ts4",
                                                  style: TextStyles.timeTextDetailStyle),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                    child: Text("$ts4Duration mins",
                                                    style: TextStyles.timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                        ),
                                        Padding(
                                           padding: const EdgeInsets.only(left:8.0,right:25.0,top:8.0,bottom:8.0),
                                          child: InkWell(
                                            onTap: () =>{
                                            sendOrder(3, 3),
                                          },
                                                                                      child: Container(
                                              // color:Colors.orange,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: UniversalVariables.separatorColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Center(
                                                  child: Text("BOOK",
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
                              Visibility(
                                 visible: (ts5!="nullDate" && ts5Duration!=5),
                                                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: UniversalVariables.standardWhite,
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:15.0,right:8.0,top:8.0,bottom:8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("$ts5",
                                                  style: TextStyles.timeTextDetailStyle),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                    child: Text("$ts5Duration mins",
                                                    style: TextStyles.timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                        ),
                                        Padding(
                                           padding: const EdgeInsets.only(left:8.0,right:25.0,top:8.0,bottom:8.0),
                                          child: Container(
                                            // color:Colors.orange,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: UniversalVariables.separatorColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Center(
                                                child: Text("BOOK",
                                                    style: TextStyles
                                                        .timeSlotDetails),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                 visible: (ts6!="nullDate" && ts6Duration!=5),
                                                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: UniversalVariables.standardWhite,
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(10),
                                    //   topRight: Radius.circular(10),
                                    //   bottomLeft: Radius.circular(10),
                                    //   bottomRight: Radius.circular(10),
                                    // ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:15.0,right:8.0,top:8.0,bottom:8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("$ts6",
                                                  style: TextStyles.timeTextDetailStyle),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                    child: Text("$ts6Duration mins",
                                                    style: TextStyles.timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:25.0,top:8.0,bottom:8.0),
                                          child: Container(
                                            // color:Colors.orange,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: UniversalVariables.separatorColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Center(
                                                child: Text("BOOK",
                                                    style: TextStyles
                                                        .timeSlotDetails),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                 visible: (ts7!="nullDate" && ts7Duration!=5),
                                                                  child: Container(
                                  decoration: BoxDecoration(
                                    color: UniversalVariables.standardWhite,
                                    borderRadius: BorderRadius.only(
                                      //  topLeft: Radius.circular(10),
                                      //   topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 15,
                                        right: 8,
                                        bottom: 80),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                       Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    
                                                    child: Text("$ts7",
                                                    style: TextStyles.timeTextDetailStyle),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                    child: Text("$ts7Duration mins",
                                                    style: TextStyles.timeDurationDetailStyle),
                                                  ),
                                                ],
                                              ),
                                        ),
                                                
                                        Padding(
                                        padding: const EdgeInsets.only(left:8.0,right:25.0,top:8.0,bottom:8.0),
                                          child: Container(
                                           
                                            // color:Colors.orange,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: UniversalVariables.separatorColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Center(
                                                child: Text("BOOK",
                                                    style: TextStyles
                                                        .timeSlotDetails),
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
                      // Container(
                      //   width: 325,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Container(
                      //             height: 75.0,
                      //             width: 150.0,
                      //             child: Center(
                      //                 child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                   Icon(
                      //                     Icons.text_format,
                      //                     color: Colors.white,
                      //                     size: 30,
                      //                   ),
                      //                   Text(Strings.TEXT_MESSAGE,
                      //                       style: GoogleFonts.sourceSansPro(
                      //                           fontSize: 12.0,
                      //                           fontWeight: FontWeight.w500,
                      //                           color: UniversalVariables
                      //                               .standardCream))
                      //                 ])),
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.all(
                      //                   Radius.circular(35.0),
                      //                 ),
                      //                 color: UniversalVariables.standardPink),
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Container(
                      //             height: 75.0,
                      //             width: 150.0,
                      //             child: Center(
                      //                 child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                   Icon(
                      //                     Icons.videocam,
                      //                     color: Colors.white,
                      //                     size: 30,
                      //                   ),
                      //                   Text(Strings.VIDEO_MESSAGE,
                      //                       style: GoogleFonts.sourceSansPro(
                      //                           fontSize: 12.0,
                      //                           fontWeight: FontWeight.w500,
                      //                           color: UniversalVariables
                      //                               .standardCream))
                      //                 ])),
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.all(
                      //                   Radius.circular(35.0),
                      //                 ),
                      //                 color: UniversalVariables.standardPink),
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // )
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
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //       height: 70.0,
            //       width: MediaQuery.of(context).size.width,
            //       child: Center(
            //           child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //               //crossAxisAlignment: CrossAxisAlignment.stretch,
            //               children: [
            //             Icon(
            //               Icons.expand_less,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //             Icon(
            //               Icons.star_border,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //             Icon(
            //               Icons.expand_more,
            //               color: Colors.white,
            //               size: 30,
            //             ),
            //           ])),
            //       decoration: BoxDecoration(
            //           //borderRadius: BorderRadius.only(topLeft: Radius.circular(55.0)),
            //           color: UniversalVariables.standardWhite),
            //     ),
            //     ),
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
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 15.0, top: 30.0, right: 15.0),
            //     child: Container(
            //       height: 40.0,
            //       width: 40.0,
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle, color: UniversalVariables.white2),
            //       child: Center(
            //         child: Icon(Icons.edit,
            //             size: 20.0, color: UniversalVariables.grey1),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: (screenHeight - screenHeight / 3) / 2,
            //   left: (screenWidth /2) - 75.0,
            //   child: Container(
            //     height: 40.0,
            //     width: 150.0,
            //     decoration: BoxDecoration(
            //       color: Color(0xFFA4B2AE),
            //       borderRadius: BorderRadius.circular(20.0)
            //     ),
            //     child: Center(
            //       child: Text('Add Your intro video here',
            //       style: GoogleFonts.sourceSansPro(
            //         fontSize: 14.0,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.white
            //       )
            //       )
            //     )
            //   )
            // ),
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
                  Container(
                    child: Row(
                      children: <Widget>[
                        widget.selectedInfluencer.username != null
                            ? Text(
                                widget.selectedInfluencer.username,
                                // style: TextStyles.usernameStyle,
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
                  )
                ],
              ),
            ),

            // Positioned(
            //   top: screenHeight - screenHeight / 3.5,
            //   left: 10,
            //   right: 10,
            //   child: Center(
            //     child: Row(
            //       children: <Widget>[
            //         Padding(
            //           padding: EdgeInsets.all(20.0),
            //           child: Stack(
            //             children: <Widget>[
            //               Container(
            //                   height: 110.0,
            //                   width: 126.0,
            //                   color: UniversalVariables.transparent),
            //               Positioned(
            //                   left: 1.0,
            //                   top: 1.0,
            //                   child: Column(
            //                     children: <Widget>[
            //                       GestureDetector(
            //                         onTap: () {
            //                           Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                               builder: (context) => ChatScreen(
            //                                 receiver: widget.selectedInfluencer,
            //                               ),
            //                             ),
            //                           );
            //                         },
            //                         child: Container(
            //                           height: 78.0,
            //                           width: 115.0,
            //                           decoration: BoxDecoration(

            //                               //gradient: UniversalVariables.fabGradient,

            //                               borderRadius: BorderRadius.only(
            //                                 topLeft: Radius.circular(10.0),
            //                                 topRight: Radius.circular(10.0),
            //                               ),
            //                               //color: UniversalVariables.white2
            //                               color: mC,
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                   color: mCD,
            //                                   offset: Offset(-10, 10),
            //                                   blurRadius: 10,
            //                                 ),
            //                                 BoxShadow(
            //                                   color: mCL,
            //                                   offset: Offset(0, -10),
            //                                   blurRadius: 10,
            //                                 ),
            //                               ]),
            //                           child: Padding(
            //                             padding: const EdgeInsets.symmetric(
            //                                 vertical: 2.0),
            //                             child: Align(
            //                               alignment: Alignment.center,
            //                               child: widget.selectedInfluencer
            //                                           .answerPrice1 !=
            //                                       null
            //                                   ? Text(
            //                                       "\$ ${widget.selectedInfluencer.answerPrice1}",
            //                                       style: TextStyles.priceNumber,
            //                                       textAlign: TextAlign.center)
            //                                   : Text("Not Set",
            //                                       style: TextStyles
            //                                           .notSetPriceNumber,
            //                                       textAlign: TextAlign.center),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 27.0,
            //                         width: 115.0,
            //                         decoration: BoxDecoration(
            //                             //gradient: UniversalVariables.fabGradient,
            //                             borderRadius: BorderRadius.only(
            //                               bottomLeft: Radius.circular(10.0),
            //                               bottomRight: Radius.circular(10.0),
            //                             ),
            //                             color: UniversalVariables.white2),
            //                         child: Padding(
            //                           padding: const EdgeInsets.symmetric(
            //                               vertical: 2.0),
            //                           child: Align(
            //                             alignment: Alignment.center,
            //                             child: Text("Text Reply",
            //                                 style: TextStyles.priceType,
            //                                 textAlign: TextAlign.center),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ))
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.all(20.0),
            //           child: Stack(
            //             children: <Widget>[
            //               Container(
            //                   height: 110.0,
            //                   width: 132.0,
            //                   color: UniversalVariables.transparent),
            //               Positioned(
            //                   right: 1,
            //                   top: 1.0,
            //                   child: Column(
            //                     children: <Widget>[
            //                       GestureDetector(
            //                         onTap: () {
            //                           Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                               builder: (context) => ChatScreen(
            //                                 receiver: widget.selectedInfluencer,
            //                               ),
            //                             ),
            //                           );
            //                         },
            //                         child: Container(
            //                           height: 78.0,
            //                           width: 120.0,
            //                           decoration: BoxDecoration(

            //                               //gradient: UniversalVariables.fabGradient,

            //                               borderRadius: BorderRadius.only(
            //                                 topLeft: Radius.circular(10.0),
            //                                 topRight: Radius.circular(10.0),
            //                               ),
            //                               //color: UniversalVariables.white2
            //                               color: mC,
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                   color: mCD,
            //                                   offset: Offset(-10, 10),
            //                                   blurRadius: 10,
            //                                 ),
            //                                 BoxShadow(
            //                                   color: mCL,
            //                                   offset: Offset(0, -10),
            //                                   blurRadius: 10,
            //                                 ),
            //                               ]),
            //                           child: Padding(
            //                             padding: const EdgeInsets.symmetric(
            //                                 vertical: 2.0),
            //                             child: Align(
            //                               alignment: Alignment.center,
            //                               child: widget.selectedInfluencer
            //                                           .answerPrice2 !=
            //                                       null
            //                                   ? Text(
            //                                       "\$ ${widget.selectedInfluencer.answerPrice2}",
            //                                       style: TextStyles.priceNumber,
            //                                       textAlign: TextAlign.center)
            //                                   : Text("Not Set",
            //                                       style: TextStyles
            //                                           .notSetPriceNumber,
            //                                       textAlign: TextAlign.center),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 27.0,
            //                         width: 120.0,
            //                         decoration: BoxDecoration(
            //                             //gradient: UniversalVariables.fabGradient,
            //                             borderRadius: BorderRadius.only(
            //                               bottomLeft: Radius.circular(10.0),
            //                               bottomRight: Radius.circular(10.0),
            //                             ),
            //                             color: UniversalVariables.white2),
            //                         child: Padding(
            //                           padding: const EdgeInsets.symmetric(
            //                               vertical: 2.0),
            //                           child: Align(
            //                             alignment: Alignment.center,
            //                             child: Text("Video Reply",
            //                                 style: TextStyles.priceType,
            //                                 textAlign: TextAlign.center),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ))
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/search_screen");
      //   },
      //   backgroundColor: UniversalVariables.standardWhite,
      //   child: Icon(Icons.search, size: 45, color: UniversalVariables.grey2),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //     shape: CircularNotchedRectangle(),
      //     color: UniversalVariables.standardWhite,
      //     elevation: 9.0,
      //     clipBehavior: Clip.antiAlias,
      //     notchMargin: 6.0,
      //     child: Container(
      //       height: 60,
      //       child: Ink(
      // decoration: BoxDecoration(),
      // child: CupertinoTabBar(
      //   backgroundColor: Colors.transparent,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: GestureDetector(
      //             onTap: () {
      //               Navigator.pushNamed(context, "/home_screen");
      //             },
      //             child: Icon(Icons.home,
      //                 color: UniversalVariables.grey2))),
      //     BottomNavigationBarItem(
      //         icon: GestureDetector(
      //             onTap: () {
      //               //  Navigator.pushNamed(context, "/profile_screen");
      //             },
      //             child: Icon(Icons.person,
      //                 color: UniversalVariables.grey1))),
      //   ],
      //   //onTap: navigationTapped,
      //   //currentIndex: _page,
      // ),
      //       ),
      //     ),
      //   ),
    );
  }
}
