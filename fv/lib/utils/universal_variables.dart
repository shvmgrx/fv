import 'package:flutter/material.dart';

class UniversalVariables {
  static final Color standardViolet = Color(0xff280072);
  static final Color standardPink = Color(0xffd07155);
  static final Color standardPinkLight = Color(0xffd07155).withOpacity(0.8);
  static final Color standardCream = Color(0xffefe6e0);
  static final Color standardCreamLight = Color(0xffefe6e0).withOpacity(0.5);
  static final Color standardWhite = Colors.white;
  static final Color blueColor = Color(0xff2b9ed4);
  static final Color blackColor = Color(0xff19191b);
  static final Color greyColor = Color(0xff8f8f8f);
  static final Color userCircleBackground = Color(0xff2b2b33);
  static final Color onlineDotColor = Color(0xff46dc64);
  static final Color lightBlueColor = Color(0xff0077d7);
  static final Color separatorColor = Color(0xff272c35);

  static final Color offline = Color(0xffFA1304);
  static final Color online = Color(0xff5e9e1c);
  static final Color away = Color(0xffa95f39);

  static final Color backgroundGrey = Colors.grey[200];

  static final Color gradientColorStart = Color(0xffd07155);
  static final Color gradientColorEnd = Color(0xffefe6e0);

  static final Color senderColor = Color(0xff2b343b);
  static final Color receiverColor = Color(0xff1e2225);

  static final Color white1 = Color(0xffD7E1EC);
  static final Color white2 = Color(0xffFFFFFF);

  static final Color grey1 = Color(0xff343942);
  static final Color grey2 = Color(0xff878E9A);
  static final Color grey3 = Color(0xff575C66);
  static final Color transparent = Colors.transparent;

  static final Gradient fabGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static final Gradient goldGradient = LinearGradient(
      colors: [gold1, gold2, gold3, gold4],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static final Gradient whiteGradient = LinearGradient(
      colors: [gold1, white1, gold2],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);

  static final Color gold1 = Color(0xffa48c64);
  static final Color gold2 = Color(0xffba9765);
  static final Color gold3 = Color(0xffa48c64);
  static final Color gold4 = Color(0xffc1b59c);

  static final Color moneyColor1 = Color(0xff23b35f);

  static final Color violet1 = Color(0xff230e36);
  static final Color violet2 = Color(0xff4c4a5b);
  static final Color violet3 = Color(0xff060509);
  static final Color violet4 = Color(0xff230e36);

  static final goldColors = [gold1, gold2, gold3, gold4];
}
