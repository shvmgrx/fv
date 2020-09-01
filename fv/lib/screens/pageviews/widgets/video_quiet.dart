import 'package:flutter/material.dart';
import 'package:fv/screens/search_screen.dart';
import 'package:fv/utils/universal_variables.dart';


class VideoQuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: UniversalVariables.white1,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "This is where all the videochats are listed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 25),
              // Text(
              //   "Search for your favorite people and start videocalling or chatting with them.",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     letterSpacing: 1.2,
              //     fontWeight: FontWeight.normal,
              //     fontSize: 18,
              //   ),
              // ),
              SizedBox(height: 25),
              FlatButton(
                color: UniversalVariables.lightBlueColor,
                child: Text("START BROWSING"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}