import 'package:flutter/material.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/custom_tile.dart';
import 'package:fv/widgets/nmBox.dart';

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  const ModalTile(
      {@required this.title,
      @required this.subtitle,
      @required this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTile(
        mini: false,
        onTap: onTap,
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: UniversalVariables.transparent,
          ),
          padding: EdgeInsets.all(10),
          child: Container(
            width: 55,
            height: 55,
            decoration: nMbox,
            child: Icon(
              icon,
              color: fCDD,
              size: 38,
            ),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: UniversalVariables.grey1,
            fontSize: 14,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: UniversalVariables.grey1,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
