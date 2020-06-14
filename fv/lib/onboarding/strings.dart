import 'package:flutter/material.dart';

class Strings {
  Strings._();

    static List<BoxShadow> neumorpShadow = [
    BoxShadow(
        color: Colors.white.withOpacity(0.5), spreadRadius: -5, offset: Offset(-5, -5), blurRadius: 30),
    BoxShadow(
        color: Colors.blue[900].withOpacity(.2),
        spreadRadius: 2,
        offset: Offset(7, 7),
        blurRadius: 20)
  ];

  static const String INFLUNECT = "izLits";
  static const String APP_NAME = "izLits";
  //static const String TAG_LINE = "We love the planet";
  static const String VIDEO_MESSAGE = "Get Video Reply";
  static const String TEXT_MESSAGE = "Get Text Reply";
  static const String READY_TO_CONNECT = "Ready to connect?";
  static const String READY_TO_CONNECT_DESC =
      "Your favorite influencers are waiting for you, get onboard and start interacting.";
  static const String START_ENJOYING = "Start Enjoying";
  static const String LAST_STEP_TO_ENJOY = "Last step to enjoy";
  static const String chooseAPlan = "Choose a plan";
  static const String weekSubscription = "Week subscription";
  static const String oneMonthSubscription = "1 Month subscription";
  static const String threeMonthSubscription = "3 Month subscription";
  static const String sixMonthSubscription = "6 Month subscription";
  static const String welcomeToAPlanet = "Welcome to New Aplanet";
  static const String relatedToYou = "Related to you";
  static const String lifeWithATiger = "Life with a Tiger";
  static const String wildAnimals = "Wild animals";
  static const String quickCategories = "Quick categories";
  static const String bear = "BEAR";
  static const String lion = "LION";
  static const String reptiles = "REPTILES";
  static const String pets = "PETS";
  static const String loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tempor erat in arcu finibus vulputate.";
}