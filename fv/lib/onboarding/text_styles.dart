import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:fv/utils/universal_variables.dart';

class TextStyles {
  TextStyles._();

  static final TextStyle appNameTextStyle = TextStyle(
    fontSize: 26,
    color: Color(0xff280072),
    fontFamily: 'CL',
  );
  static final TextStyle appNameLogoStyle = TextStyle(
    letterSpacing: 3.5,
    fontWeight: FontWeight.w800,
    fontSize: 30,
    color: UniversalVariables.gold2,
    fontFamily: 'poppinsSB',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );
  static final TextStyle tagLineTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle bigHeadingTextStyle = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w900,
    color: UniversalVariables.gold2,
    fontFamily: 'kiona',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle startFaving = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w900,
    color: UniversalVariables.gold2,
    fontFamily: 'kiona',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle profileName = TextStyle(
    fontSize: 25,
    // fontWeight: FontWeight.w900,
    //color: Color(0xffd07155),
//fontFamily: 'kiona',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );
  static final TextStyle ordersStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: UniversalVariables.grey2,
  );

  static final TextStyle nextUpdate = TextStyle(
    fontSize: 20,
    fontFamily: 'Raleway',
    letterSpacing: 1.5,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.gold2,
  );

  static final TextStyle feedbackHead = TextStyle(
    fontSize: 15,
    fontFamily: 'Raleway',
    letterSpacing: 1.1,
    fontWeight: FontWeight.w700,
    color: UniversalVariables.gold2,
  );

  static final TextStyle feedback = TextStyle(
    fontSize: 15,
    fontFamily: 'Raleway',
    letterSpacing: 1.1,
    fontWeight: FontWeight.w700,
    color: UniversalVariables.blackColor,
  );

  static final TextStyle selectedOrdersStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: UniversalVariables.blackColor,
  );

  static final TextStyle editHeadingName = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.grey1,
    fontFamily: 'Poppins',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle deny = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: UniversalVariables.offline,
    fontFamily: 'Poppins',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle accept = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: UniversalVariables.online,
    fontFamily: 'Poppins',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle fvCodeHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.grey1,
    fontFamily: 'Poppins',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle fvSnackbar = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.white2,
    fontFamily: 'Poppins',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle nextButton = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.white2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle registerChoice = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.gold2,
    fontFamily: 'Poppins',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle registerChoiceDisable = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.white2,
    fontFamily: 'Poppins',
  );

  static final TextStyle getPremiumTimeslots = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: UniversalVariables.gold2,
    fontFamily: 'Poppins',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle postCommissionsPrice = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w600,
    color: UniversalVariables.grey2,
    //fontFamily: 'kiona',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle whileEditing = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: UniversalVariables.gold2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle hintTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: UniversalVariables.grey2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle orderIDStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: UniversalVariables.grey2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle orderDetailsStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: UniversalVariables.gold2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle hintMoneyTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: UniversalVariables.gold2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle paymentTypeStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: UniversalVariables.blackColor,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle paymentModalStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.blackColor,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle moneyStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: UniversalVariables.moneyColor1,

    // fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.standardWhite,
    //   ),
    // ],
  );

  static final TextStyle moneyStyleMain = TextStyle(
    fontSize: 85,
    fontWeight: FontWeight.w600,
    color: UniversalVariables.moneyColor1,

    // fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.standardWhite,
    //   ),
    // ],
  );

  static final TextStyle timeTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: UniversalVariables.grey2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle timeTextDetailStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: UniversalVariables.blackColor,
    // fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle timeDurationDetailStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.blackColor,
    // fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );

  static final TextStyle chatProfileName = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w900,
    color: UniversalVariables.grey2,
    fontFamily: 'Ubuntu',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: Colors.white30,
      ),
    ],
  );

  static final TextStyle chatListProfileName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: UniversalVariables.blackColor,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: Colors.white30,
    //   ),
    // ],
  );
  static final TextStyle mainScreenProfileName = TextStyle(
    fontSize: 16,
    // letterSpacing: 1.5,
    fontWeight: FontWeight.w600,
    color: UniversalVariables.grey1,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );
  static final TextStyle priceCurrency = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.blackColor,
    fontFamily: 'CL',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );
  static final TextStyle priceNumber = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w800,
    color: UniversalVariables.grey2,
    fontFamily: 'Adam',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );
  static final TextStyle notSetPriceNumber = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: UniversalVariables.grey2,
    fontFamily: 'Adam',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle theNameStyle = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w200,
    color: UniversalVariables.grey2,
    fontFamily: 'CL',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle verifiedStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: UniversalVariables.gold2,
    fontFamily: 'Poppins',

    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle replyTypeStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w900,
    color: UniversalVariables.blackColor,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle replyTypeSelectedStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: UniversalVariables.white1,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle bioStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w200,
    color: UniversalVariables.grey2,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle errorStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.offline,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle timeSlotDetails = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.standardWhite,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle doneStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.online,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle cancelStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.offline,
    fontFamily: 'Poppins',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle usernameStyleEnd = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.gold2,
    // fontFamily: 'Ubuntu',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle usernameStyleBegin = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.blackColor,
    //fontFamily: 'Ubuntu',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  static final TextStyle timeStampStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: UniversalVariables.grey2,
    fontFamily: 'Ubuntu',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: UniversalVariables.receiverColor,
      ),
    ],
  );
  static final TextStyle priceType = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,

    color: UniversalVariables.grey1,
    //fontFamily: 'Raleway',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );
  static final TextStyle bodyTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: Colors.white60,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 3.0,
        color: Colors.black45,
      ),
    ],
    fontFamily: 'adam,adamBold',
  );
  static final TextStyle buttonTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle headingTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle subscriptionTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle subscriptionAmountTextStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle body2TextStyle = TextStyle(
    fontSize: 16,
    letterSpacing: 1.4,
    fontWeight: FontWeight.w700,
    color: Colors.white.withOpacity(0.5),
    fontFamily: 'Ubuntu',
  );
  static final TextStyle body3TextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Colors.white.withOpacity(0.8),
    height: 1.2,
    fontFamily: 'Ubuntu',
  );
}
