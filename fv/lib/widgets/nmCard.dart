import 'package:flutter/material.dart';
import 'package:infv1/widgets/nmBox.dart';


class NMCard extends StatelessWidget {
  // final bool active;
  final String label;
  const NMCard({this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: nMbox,
      child: Row(
        children: <Widget>[
       
          SizedBox(width: 15),
          Text(
            label,
            style: TextStyle(
                color: fCD, fontWeight: FontWeight.w700, fontSize: 16),
          ),
          Spacer(),
          // Container(
          //   decoration: active ? nMboxInvertActive : nMboxInvert,
          //   width: 70,
          //   height: 40,
          //   child: Container(
          //     margin: active
          //         ? EdgeInsets.fromLTRB(35, 5, 5, 5)
          //         : EdgeInsets.fromLTRB(5, 5, 35, 5),
          //     decoration: nMbtn,
          //   ),
          // ),
        ],
      ),
    );
  }
}