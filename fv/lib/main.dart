import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infv1/provider/image_upload_provider.dart';
import 'package:infv1/provider/user_provider.dart';
import 'package:infv1/resources/firebase_repository.dart';
import 'package:infv1/screens/editProfile.dart';

import 'package:infv1/screens/home_screen.dart';
import 'package:infv1/screens/landing_screen.dart';

import 'package:infv1/screens/list_influencer.dart';
import 'package:infv1/screens/pageviews/chat_list_screen.dart';
import 'package:infv1/screens/profile_screen.dart';
import 'package:infv1/screens/search_screen.dart';
import 'package:infv1/screens/settingsScreen.dart';
import 'package:infv1/utils/universal_variables.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    //_repository.signOut();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: "Faveez",
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          '/landing_screen': (context) => LandingScreen(),
          '/search_screen': (context) => SearchScreen(),
          '/list_influencer_screen': (context) => ListInfluencerPage(),
          '/messages_screen': (context) => ChatListScreen(),
          '/profile_screen': (context) => ProfileScreen(),
          '/edit_profile_screen': (context) => EditProfile(),
          '/settings_screen': (context) => SettingsScreen(),
          '/home_screen': (context) => HomeScreen(),
        },
        theme: ThemeData(
          primaryColor: UniversalVariables.gold2,
          brightness: Brightness.light,
        ),
        home: FutureBuilder(
          future: _repository.getCurrentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LandingScreen();
            }
          },
        ),
      ),
    );
  }
}
