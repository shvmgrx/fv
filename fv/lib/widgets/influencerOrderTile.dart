import 'package:flutter/material.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/utils/universal_variables.dart';

class InfluencerOrderTile extends StatefulWidget {
  final Widget buyerPhotoName;
  final Widget orderId;
  final Widget slotTime;
  final Widget slotDuration;
  final Widget price;

  InfluencerOrderTile({
    this.buyerPhotoName,
    this.orderId,
    this.slotTime,
    this.slotDuration,
    this.price,
  });

  @override
  _InfluencerOrderTileState createState() => _InfluencerOrderTileState();
}

class _InfluencerOrderTileState extends State<InfluencerOrderTile> {
  bool arrowUp = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void pullDown() {
    setState(() {
      arrowUp = true;
    });
  }

  void pullUp() {
    setState(() {
      arrowUp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: UniversalVariables.white2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [widget.buyerPhotoName],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 5.0),
                      child: Row(
                        children: [
                          Text("Time:",
                              style: TextStyles.orderDetailsStyle,
                              textAlign: TextAlign.left),
                          widget.slotTime
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: () {
                          if (arrowUp) {
                            pullUp();
                          } else if (!arrowUp) {
                            pullDown();
                          }
                        },
                        child: Icon(
                          arrowUp
                              ? Icons.arrow_circle_up
                              : Icons.arrow_circle_down,
                          color: UniversalVariables.grey2,
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: arrowUp,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 5.0),
                    child: Row(
                      children: [
                        Text("Duration:",
                            style: TextStyles.orderDetailsStyle,
                            textAlign: TextAlign.left),
                        widget.slotDuration
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: arrowUp,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 5.0),
                    child: Row(
                      children: [
                        Text("Price:",
                            style: TextStyles.orderDetailsStyle,
                            textAlign: TextAlign.left),
                        widget.price
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: arrowUp,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 5.0),
                    child: Row(
                      children: [
                        Text("Order ID:",
                            style: TextStyles.orderDetailsStyle,
                            textAlign: TextAlign.left),
                        widget.orderId
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
