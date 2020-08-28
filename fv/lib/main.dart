// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/resources/auth_methods.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/editProfile.dart';

import 'package:fv/screens/home_screen.dart';
import 'package:fv/screens/landing_screen.dart';

import 'package:fv/screens/list_influencer.dart';
import 'package:fv/screens/onBoardExpert.dart';
import 'package:fv/screens/onBoardUser.dart';
import 'package:fv/screens/pageviews/chat_list_screen.dart';
import 'package:fv/screens/profile_screen.dart';
import 'package:fv/screens/registerChoice.dart';
import 'package:fv/screens/search_screen.dart';
import 'package:fv/screens/settingsScreen.dart';
import 'package:fv/screens/verifyExpert.dart';
import 'package:fv/utils/appleSignInAvailable.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();
  final appleSignInAvailable = await AppleSignInAvailable.check();
    runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
   // _repository.signOut();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthMethods()),
        
        
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
          '/register_choice_screen': (context) => RegisterChoice(),
          '/onboard_user_screen': (context) => OnBoardUser(),
          '/onboard_expert_screen': (context) => OnBoardExpert(),
          '/verify_expert_screen': (context) => VerifyExpert(),
      
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
