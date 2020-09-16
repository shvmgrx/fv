import 'package:flutter/material.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/utils/utilities.dart';
import 'package:provider/provider.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.gold2,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              Utils.getInitials(userProvider.getUser.name),
              style: TextStyle(
                fontFamily: 'Adam',
                fontWeight: FontWeight.bold,
                color: UniversalVariables.white2,
                fontSize: 17,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: UniversalVariables.transparent, width: 2),
                  color: UniversalVariables.onlineDotColor),
            ),
          )
        ],
      ),
    );
  }
}
