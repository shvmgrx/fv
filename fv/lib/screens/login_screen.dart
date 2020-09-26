import 'package:apple_sign_in/apple_sign_in.dart' as ap;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/conStrings.dart';
import 'package:fv/resources/auth_methods.dart';
import 'package:fv/screens/registerChoice.dart';
import 'package:fv/utils/appleSignInAvailable.dart';
// import 'package:gradient_text/gradient_text.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/ui_elements/loader.dart';
import 'package:fv/ui_elements/delayed_animation.dart';
import 'package:fv/widgets/nmBox.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

// import 'package:avatar_glow/avatar_glow.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  AnimationController controller;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool agreementAccepted = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  FirebaseRepository _repository = FirebaseRepository();

  bool isGoogleLoginPressed = false;
  bool isAppleLoginPressed = false;

  void showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      child: AlertDialog(
        elevation: 2,
        //backgroundColor: UniversalVariables.transparent,
        title: Center(
          child: Column(
            children: <Widget>[
              Text("Terms and Conditions", style: TextStyles.paymentModalStyle),
              Divider()
            ],
          ),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          //  height: 400,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Text(
                    pdfText,
                    style: TextStyle(fontSize: 9),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: OutlineButton(
                    splashColor: UniversalVariables.white2,
                    onPressed: () => {
                      {
                        setState(() {
                          agreementAccepted = false;
                        }),
                        Navigator.pop(context)
                      },
                    },
                    child: Text(
                      "DENY",
                      style: TextStyles.deny,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: OutlineButton(
                    splashColor: UniversalVariables.white2,
                    onPressed: () => {
                      {
                        setState(() {
                          agreementAccepted = true;
                        }),
                        Navigator.pop(context)
                      },
                    },
                    child: Text(
                      "ACCEPT",
                      style: TextStyles.accept,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithApple(BuildContext context) async {
    setState(() {
      isAppleLoginPressed = true;
    });
    try {
      final authService = Provider.of<AuthMethods>(context, listen: false);
      final user = await authService
          .signInWithApple(scopes: [ap.Scope.email, ap.Scope.fullName]);
      if (user != null) {
        authenticateAppleUser(user);
      } else {
        print("There was an error");
      }
      print('uid: ${user.uid}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // final color = Colors.white;

    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);

    // Future<void> _signInWithApple(BuildContext context) async {

    //   try {
    //     final authService = Provider.of<AuthMethods>(context, listen: false);
    //     final user = await authService.signInWithApple(scopes: [Scope.email, Scope.fullName]);

    // if (user != null) {
    //   authenticateAppleUser(user);
    // } else {
    //   print("There was an error");
    // }
    // print('uid: ${user.uid}');
    //   } catch (e) {
    //     print(e);
    //   }
    // }
    // final snackBar = SnackBar(
    //     content: Text(
    //   ConStrings.ACEEPT_TERMS,
    //   style: TextStyles.fvSnackbar,
    // ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: UniversalVariables.backgroundGrey,
        body: Stack(
          children: <Widget>[
            // Image.asset(
            //   "assets/loginImage.png",
            //   height: height,
            //   fit: BoxFit.fitHeight,
            // ),
            Center(
              child: Column(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 30),
                  //   child: AvatarGlow(
                  //     endRadius: 85,
                  //     duration: Duration(seconds: 2),
                  //     glowColor: Color(0xffd07155),
                  //     repeat: true,
                  //     repeatPauseDuration: Duration(seconds: 2),
                  //     startDelay: Duration(seconds: 1),
                  //     child: Material(
                  //         elevation: 8.0,
                  //         shape: CircleBorder(),
                  //         child: CircleAvatar(
                  //           child: Container(
                  //               width: 190.0,
                  //               height: 190.0,
                  //               decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   image: DecorationImage(
                  //                       fit: BoxFit.fill,
                  //                       image: AssetImage(
                  //                           "assets/izlits.jpeg")))),
                  //           // child: Image.asset(
                  //           //   "assets/logoBorder.png",
                  //           // ),
                  //           radius: 50.0,
                  //         )),
                  //   ),
                  // ),
                  SizedBox(
                    height: 160.0,
                  ),
                  DelayedAnimation(
                    child:

                        // GradientText("FAVEEZ",
                        // gradient: LinearGradient(colors: [
                        //   UniversalVariables.gold1,
                        //   UniversalVariables.gold2,
                        //   UniversalVariables.gold3,
                        //   UniversalVariables.gold4
                        // ],
                        // ),
                        // style: TextStyles.appNameLogoStyle,
                        // textAlign: TextAlign.center),

                        Text("FAVEEZ",
                            style: TextStyles.appNameLogoStyle,
                            textAlign: TextAlign.center),
                    delay: delayedAmount + 1000,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Personalized interactions with your",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          //fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: UniversalVariables.grey2),
                    ),
                    delay: delayedAmount + 2000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "favorite people",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          //fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: UniversalVariables.grey2),
                    ),
                    delay: delayedAmount + 2500,
                  ),
                  SizedBox(
                    height: 170.0,
                  ),
                  DelayedAnimation(
                    child: Stack(children: [
                      Center(
                        child: animatedGoogleSignIn(screenWidth),
                      ),
                      isGoogleLoginPressed
                          ? Center(
                              child: Column(
                              children: <Widget>[
                                SizedBox(height: 80),
                                ColorLoader5(),
                              ],
                            ))
                          : Container(),
                    ]),
                    delay: delayedAmount + 3000,
                  ),
                  SizedBox(height: 30),
                  appleSignInAvailable.isAvailable
                      ? DelayedAnimation(
                          child: Stack(children: [
                            Center(
                              child: animatedAppleSignIn(screenWidth),
                            ),
                            isAppleLoginPressed
                                ? Center(
                                    child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 80),
                                      ColorLoader5(),
                                    ],
                                  ))
                                : Container(),
                          ]),
                          delay: delayedAmount + 3400,
                        )
                      : Container(),
                  Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0, left: 15),
                    child: ListTile(
                        title: new Text(
                          "Terms and Conditions",
                          style: TextStyle(
                              color: agreementAccepted ? fCDD : fCLL,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        leading: agreementAccepted
                            ? Icon(
                                CupertinoIcons.check_mark_circled,
                                size: 30,
                                color: UniversalVariables.gold2,
                              )
                            : Icon(
                                CupertinoIcons.circle,
                                size: 30,
                                color: UniversalVariables.gold2,
                              ),
                        onTap: () {
                          showAlertDialog(context);
                          //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget loginButton() {
  //   return FlatButton(
  //     padding: EdgeInsets.all(35),
  //     child: Text(
  //       "LOGIN NOW",
  //       style: TextStyle(
  //           fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
  //     ),
  //     onPressed: () => performLogin(),
  //   );
  // }

  final snackBar = SnackBar(
      content: Text(
    ConStrings.ACCEPT_TERMS,
    style: TextStyles.fvSnackbar,
  ));

  Widget animatedGoogleSignIn(screenwidth) => Container(
        height: 60,
        width: screenwidth * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: UniversalVariables.gold2.withOpacity(0.7),
        ),
        child: Center(
          child: FlatButton(
            onPressed: () {
              agreementAccepted
                  ? performGoogleLogin()
                  : scaffoldKey.currentState.showSnackBar(snackBar);
            },
            child: Text(
              'Google Sign In',
              style: TextStyle(
                fontFamily: 'Kiona',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  Widget animatedAppleSignIn(screenwidth) => Container(
      height: 60,
      width: screenwidth * 0.7,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(100.0),
      //   //color: UniversalVariables.blackColor.withOpacity(0.7),
      // ),
      child: ap.AppleSignInButton(
        style: ap.ButtonStyle.black,
        type: ap.ButtonType.signIn,
        onPressed: () {
          agreementAccepted
              ? _signInWithApple(context)
              : scaffoldKey.currentState.showSnackBar(snackBar);
        },
      )

      // FlatButton(
      //   onPressed: () => _signInWithApple(context),
      //   child: Text(
      //     'Apple Sign In',
      //     style: TextStyle(
      //       fontFamily: 'Kiona',
      //       fontSize: 20.0,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      );

  void performGoogleLogin() {
    setState(() {
      isGoogleLoginPressed = true;
    });

    _repository.signIn().then((FirebaseUser user) {
      print("something");
      if (user != null) {
        authenticateGoogleUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  // void performAppleLogin() {

  //   setState(() {
  //     isAppleLoginPressed = true;
  //   });

  //   _signInWithApple(context);

  // }

  void authenticateGoogleUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isGoogleLoginPressed = false;
      });
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return RegisterChoice();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }

  void authenticateAppleUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isAppleLoginPressed = false;
      });
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return RegisterChoice();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }

  final String pdfText = """

1. Scope of Application of the Terms and Conditions

1.1 Scope of Application of the User Terms.

These Terms and Conditions for Users (“User Terms”) 
regulate the contractual relationship between Faveez UG,  
Meissner Straße 79, 01445 Radebeul, Germany (“Faveez”) 
and all Users of the ‘Faveez’ app made available by Faveez 
(“Faveez App”). Users, who use the Faveez App to request 
content, are hereinafter referred to as “Advice Seekers” 
Users, who provide content in the form of videos, photographs, 
documents, sound files or texts via the Faveez App or respond 
to requests of Users, are hereinafter referred to as “Experts.” 
Advice Seekers and Experts are hereinafter jointly referred to
as “Users.” The use of Faveez shall take place exclusively on 
the basis of these User Terms.

1.2 Separate conditions.
 
Separate conditions apply to experts before they begin their 
activities (see point 11).

1.3 Amendment of the Terms.

Faveez will notify its Users of any amendments of the User 
Terms no later than one week before they become effective. 
If the User does not object to the application of the new 
terms and conditions, the amended conditions shall be deemed 
agreed. Faveez will inform its Users of the significance of 
this deadline for objecting separately in the notification 
containing the amended terms and conditions and reserves the
right to terminate the relationship with the User in the 
case of an objection.

2. General

2.1 Object of Agreement.

The object of this agreement is the use of the Faveez App 
for communications between Advice Seekers and Experts, 
including the functions made available within the Faveez 
App, subject to technical and operational feasibility. 
Faveez thereby provides a platform that enables Advice 
Seekers and Experts to communicate from a technical point
of view only. A right to use the Faveez App does not 
exist. Faveez does not assume any responsibility for the
initiation, maintenance or technical quality of the 
communications. A right to the conveyance of communications
does not exist. The User is responsible for maintaining 
the necessary Internet access and a suitable end device 
at its own expense. Faveez grants the User a simple, 
non-transferable right to install and use the Faveez 
App on suitable end devices of the User.

2.2 Text Replies, Video Replies and Video Calls.

The response of user messages by experts is called either 
text replies or video replies. Experts further can engage 
in 1-1 video calls with the advice seeker through the 
Faveez app, called video calls.

2.3 Public and Private Communications.

Advice Seekers can decide during the request for a video 
or text response whether the Expert's reply is private or
public and therefore visible to other users. The public 
text or video reply of an expert is available in the 
expert's profile for all users. If an advice seeker 
decides to request a private text or video reply, this 
will only be displayed in the private communication between 
the advice seeker and the respective expert. The guidelines 
for public text and video replies and private text and video 
replies displayed in the Faveez App apply. The guided communication 
is shown to the User in the Inbox and can be managed there. 
Non-registered visitors of the Faveez App can follow public 
video replies anonymously. All 1-1 video calls are private.

2.4 Findability.

All Faveez App Users can find Experts and Advice Seekers using 
the search function or in previous communications logs.

2.5 Legal Relationship between Advice Seekers and Experts.

Any rights and obligations shall be created exclusively between 
Advice Seekers and Experts through the exchange of messages 
and 1-1 video call conversations.

2.6 Responsibilities of Faveez.

Faveez does not verify the identity and legal capacity of Advice 
Seekers and Users; only the functioning of the payment method 
specified by an Advice Seeker is verified. Faveez does not assume 
any responsibility for the accuracy or quality of the communications. 
Advice Seekers are responsible for the content of messages sent from 
an Advice Seeker to an Expert, and Experts are responsible for whether 
a message is answered and the content of the response. Faveez does not 
check the messages or responses. Faveez does not assess the reliability 
or the value of messages.

2.7 No Substitute for Professional Advice.
 
Messages that receive responses are not suitable or intended as a substitute 
for professional advice provided by members of the respective profession. 
Any actions taken are at the Advice Seeker's own risk.

2.8 Changes to the Faveez App.

Faveez may make additions or changes to the functions offered in order to 
improve them or adjust them to technical developments, provided that this 
is reasonable and taking into consideration the interests of the Users and 
Faveez. Ongoing maintenance and further development may temporarily restrict 
or interrupt the use of the Faveez App. No claims shall exist in this regard. 
The User acknowledges that updates to the Faveez App may be downloaded on the 
device being used by the User.

2.9 Permitted Use.

The Faveez App may only be used in accordance with the User Terms as well as 
the additional instructions for using certain functions, which are displayed 
near the function, e.g., upload sizes. It is not permitted to spread viruses, 
trojans, worms or other malicious content via the Faveez App or use the Faveez 
App if there is a risk that the use could lead to damages to technical equipment 
or software. In particular, the data volume restrictions must be observed.

3. Rules of Conduct for All Users

3.1 Age Limit of 18 Years.
 
Only persons who are at least 18 years old with full legal capacity are allowed 
to use the Faveez App. Each User may register for only one account by providing 
the personal data requested completely and truthfully. Multiple registrations 
are not permitted. The sale or transfer of an account is not permitted.

3.2 Account Protection.

Every User must securely store his/her access data for the use of the Faveez App 
in such a manner that it cannot be accessed by third parties and must immediately 
notify Faveez via email in the case of any suspicion of unauthorized access. The 
User remains logged in to the Faveez App; in the case of any use of a User’s 
smartphone by a different person, the User is liable for their activities to 
the extent that the User is responsible in this regard.

​
3.3 Rights of Third Parties.

The User must have the necessary rights to upload and use photographs, videos, 
audios or texts (collectively “User Generated Content”). A User often only has 
the necessary rights if the User has created the User Generated Content or 
acquired these rights from third parties. This includes the consent of any 
persons depicted in photographs. Rights of third parties may also exist with 
respect to objects depicted in the background. The User is responsible for 
verifying and, if appropriate, acquiring the necessary rights.

3.4 No Further Commercial Use.

Users are not allowed to use Faveez’ platform for promotional purposes or to 
conclude contracts, which go beyond sending messages, responses and video 
chat conversations. Faveez is entitled to terminate the relationship after 
issuing a warning.

4. Rules of Communication

4.1 Prohibited Conduct.

Users will not conduct any communications via the Faveez App, which violate 
the rights of third parties, contain content that is harmful to young people 
or extremist content, breach applicable laws, or are deceptive, insulting, 
pornographic, offensive or glorify violence. In particular, the following 
conduct is prohibited (“Intolerable Conduct”):

  1.Inappropriate Member Names: Faveez does not permit any linguistic obscenity,
    insults, defamations, tackiness, discrimination or abuse in member names.

  2.Harmful Content: Faveez's endeavors to protect its Users against offensive 
    content. Consequently, any content unsuitable for minors may not be requested 
    on Faveez. In particular, requests for sexual services are prohibited.
 
  3.Insults or Abuse: Faveez does not tolerate discrimination, defamation, 
    insults or abuse of individual Users on the grounds of ethnic origin, 
    religion, gender, nationality, sexual orientation or belief.
 
  4.Harassment of Other Users: Users must respect the privacy of other 
    Users. Sending unrequested messages, chain letters or invitations to 
    participate in sweepstakes is prohibited when communicating via Faveez.
 
Intolerable Conduct will result in the User being blocked or, if appropriate, the 
termination of the relationship with the User in accordance with clause 10.

4.2 Identification of Intolerable Conduct.

Users must report or block Intolerable Conduct using the functions available 
(“Identification”). Faveez will react to such Identification within 24 hours. 
Faveez filters the current content on the Faveez App in order to prevent, detect 
and stop Intolerable Conduct.

4.3 Other Illegal Activities and Improper Use.

All Users are prohibited from participating in fraudulent or illegal activities or 
supporting such activities when using the Faveez App. In the case of suspected 
misuse or potential legal infringements (e.g., copyright infringements or infringements 
of personal rights) on the part of other Users, the User is requested to provide 
Identification immediately or otherwise send notification to support@faveez.com.

4.4 Blocking.

Faveez is authorized to temporarily block the use of the Faveez App or the existing 
data on the Faveez App, or parts thereof, if there is concrete evidence that the User 
is engaging in Intolerable Conduct or is otherwise violating these User Terms or 
applicable laws, or if reasonable suspicions exist in this respect, or if any other 
justified interests in such blocking exist, e.g., in the case of any suspicion of misuse 
by unauthorized third parties. If, after assessing the circumstances and considering the 
legitimate interests of the User and third parties, unblocking is not an option, Faveez 
is authorized at its own discretion to permanently block or delete the access or existing 
data, in whole or in part.

5. Ratings

5.1 Submitted Ratings.

Faveez may provide a system, which can be used by Users to rate public replies and by Advice 
Seekers to rate Experts; Faveez reserves the right to edit and configure such ratings. Users 
can view the ratings. Ratings submitted by a User may be displayed in connection with products 
or services that can be purchased for a fee without the User receiving any consideration in 
this regard.

5.2 Misuse of the Rating System.

By rating an Expert, Advice Seekers share their experience with the Expert and the quality of 
the Expert’s messages with other Users. Users are prohibited from using a different or fake 
user name or specifying a third person or fictitious person to
 
  1. make a negative or wrong judgment about another Expert

  2. make a negative judgment about an Expert because the Expert 
   did not want to respond to a message in violation of the User Terms.

Faveez reserves the right to refrain from publishing ratings.

5.3 Ranking

Faveez reserves the right to create a ranking of Content Experts based on the ratings of Users 
and additional qualitative and quantitative criteria. This ranking influences the order in which
and how Content Experts are displayed on the platform.

6. Liability of Faveez and Indemnification

6.1 No Liability for Content.

Because Faveez is not a party to the communication contract between Experts and Advice Seekers, 
Faveez is not liable for the responses conveyed through the communications. In particular, 
Faveez is not liable for any damages, which may result from the advice or suggestions of Expert 
being followed.

6.2 Unlimited Liability.

Faveez, its legal representatives, executives or vicarious agents shall have unlimited liability 
according to the statutory provisions of the Federal Republic of Germany

  a) for damages resulting from injury to life, body or health,
  b) in the case of intent or gross negligence,
  c) according to the Product Liability Act (Produkthaftungsgesetz), and
  d) in the case of an assumption of guarantees.

6.3 Limited Liability.

​In the case of slight negligence, Faveez, its legal representatives, executives or vicarious 
agents shall only be liable in the case of a breach of “essential” duties resulting from these 
User Terms. “Essential” duties are such duties, which are necessary for the fulfillment of the 
contract to use the Faveez App and if breached, would question the attainment of the contractual 
purpose so that the User may regularly rely on the fulfillment of such duties. In these cases, 
the liability is limited to typical and foreseeable damages.

6.4 Indemnification against Claims.

To the extent that the User is at fault, the User shall indemnify Faveez against any claims asserted 
by third parties due to the conduct of the User in connection with the use of the Faveez App and 
shall bear the costs incurred for the legal defense according to the statutory fees. In the case 
of any claims asserted by third parties, the User is obligated to provide Faveez immediately, 
truthfully and completely with all information, which is required for assessing the claims and the 
defense against such claims.

7. Prices and Billing for Use

7.1 Fees.

The request of text answers, video answers as well as video calls are subject to a fee. Experts 
determine the fees for the request of text and video responses and video calls. The stated fees 
include the applicable value added tax. The User must also pay the fees arising from unauthorized 
use of his account if and insofar as he is responsible for such use.

7.2 Payment with credits.

Advice Seekers can request a Text Reply, Video Reply and Video Call by using a valid payment card 
through the appropriate third party payment provider (for iOS, our website and Android App, the 
payment provider we have selected). You must provide valid payment information to the third-party 
payment provider. You may not return or exchange a Text Reply, Video Reply or Video Call, and no 
refunds will be given.

7.3 Payment Obligation and Expiration of the Right of Withdrawal.

By requesting a Text Reply, Video Reply or Video Call, the Advice Seeker acknowledges his payment 
obligation and authorizes Faveez to deduct the amount using the selected payment method. By sending 
the message, the Expert expressly agrees that the execution of the contract will begin before the 
end of the withdrawal period and that he loses his right of withdrawal.

7.4 Claims of Payment Providers against Faveez.

The User is liable for any claims of payment providers, which are asserted against Faveez due to any 
failure on behalf of the User to render full payment, e.g., due to a lack of creditworthiness or 
improper use of the payment methods, if and to the extent that the User is responsible in this regard.

8. Content Protection and Rights of Use

8.1 Content Protection.

Photographs, audios, videos or textual content made available on the Faveez App (collectively “Faveez 
Content”) may be protected by personal rights, data protection law, copyright law or other regulations,
e.g., as business or trade secrets. Faveez Content may only be used for the purposes being pursued 
through the operation of the Faveez App under the User Terms.

8.2 Granting of Rights to Faveez to Operate the Faveez App.

By sending communications via the Faveez App, including uploading content, the User grants Faveez 
free of charge the right to use comprehensively all copyrights and related rights under the German 
Copyright Act (Urheberrechtsgesetz, “UrHG”), without restrictions in terms of time, territory or 
content, from the time of uploading for the purposes of operating the Faveez App, including advertising, 
further development, asserting legal rights and maintaining IT security, without any additional consent 
and free from the rights of third parties. The granting of rights shall include in particular the right 
to reproduce, distribute, lease and loan, including the right to use in connection with databases, 
exhibitions, presentations, performances and demonstrations, broadcasting, reproduction through image 
and sound recording mediums, reproduction through radio broadcasts and communication to the public. 
It also includes the right to edit and redesign, filming and film adaptations as well as rights to 
photographs. Faveez is granted the right to use such rights in Germany and abroad in material and 
immaterial form and to make content publically available. This shall also apply, regardless of the 
transmission, carrier and storage technology, for data carriers (e.g., magnetic, optical, magneto-optical 
and electronic storage media), telecommunication and data networks as well as databases, including online 
services. The granting of rights shall also include unknown rights of use and any exercise in electronic 
and digital form. The moral rights to content shall remain unaffected. Through this granting of rights, 
Faveez is permitted to fulfill requests for the portability of personal data under the General Data 
Protection Regulation. The User shall ensure that no rights will be exercised under Sections 12, 13 
sentence 2 and 25 UrhG, i.e., the rights of the author relating to publication, being named as the 
author and access to workpieces.

8.3 Transfer of Rights of Use.

The User grants Faveezthe right to also allow third parties to use the aforementioned rights for the 
same purpose in Germany and abroad by granting corresponding rights of use, or to transfer the rights 
to affiliated companies under Section 15 of the German Stock Corporation Act (Aktiengesetz).

8.4 Right to Share Content.

Experts grant Advice Seekers the right to share private video replies with others and thereby reproduce 
content, in whole or in part, and to disseminate content and make content publically available through 
online services, especially on the Internet or via apps, also using social networks (collectively 
“Electronic Media”), without any further consent and free from rights of third parties, or to make 
content available on demand to a large number of individuals. This may also lead to further sharing 
and therefore further dissemination by Users of this Electronic Media. This right shall be granted 
according to the scope described in clause 6.3 with respect to sharing on Electronic Media.

9. Handling of Personal Data

9.1 General.

Users are obligated to treat as confidential any personal data of other Users, which comes to their 
knowledge in connection with the use of the Faveez App, and may only process such data for the use 
of the Faveez App to the extent that this is required.

9.2 Transaction-related Data.

If a User’s account is deleted upon request, the User’s communications with other Faveez Users will 
be deleted. However, any data required to process transactions and data, which must be available for 
the purposes of traceability under tax law, shall only be deleted upon expiration of the retention 
requirement.

10. Term.
 
This agreement shall be valid for an indefinite period and can be terminated by the User at any time 
without observing a notice period. A termination can be made by deleting the account or via email 
to support@faveez.com. Faveez may terminate the agreement in observance of a notice period of four 
weeks. The right to terminate without notice in the event of any breach of applicable law, these 
User Terms shall remain unaffected.

11. Separate Conditions for Experts.

11.1 General.

  a) No Relationship under Employment or Company Law. A relationship under employment or company 
     law shall not be established between Faveez and Experts through these Terms and Conditions.

  b) Contract Conclusion. Every Expert is required to register by providing truthful and complete 
     description of all selection criteria and must promptly provide notification of any changes. 
     The contract to join Faveez as an Expert becomes effective when the Expert's account goes live. 
     Registration as an Expert only represents a contractual offer of the Expert, which Faveez can 
     accept within four weeks.

  c) Presentation of Experts. Faveez will present the Expert on the Faveez App, direct messages 
     from Advice Seeker to the Expert and conversations between Advice Seeker and Expert and enable 
     a response or dialogue from a technical perspective.

      (i) Experts will have the possibility to record an introduction video in the app, which will 
          appear for all Advice Seekers when they open their Faveez profile. It is proposed to 
          record a video of about 30 seconds in selfie mode, mentioning that the Expert is on Faveez 
          and what Advice Seekers can expect. E.g. that the expert gives advice about nutrition, 
          relationships or fitness.
 
      (ii) Experts will be depicted in groups according to categories. Experts can make suggestions 
           concerning their grouping, which are not binding for Faveez. Faveez may supplement or 
           change the selection of categories available in order to improve them or adjust them to 
           strategic developments or demand trends if this is reasonable, taking into account the 
           interests of Experts and Faveez. An Expert may be presented in a highlighted way by 
           booking corresponding packages, which are displayed on the Faveez App.

11.2 General Rules of Conduct.

  1. Obligations of Experts. Experts are obligated to write responses conscientiously, promptly and 
     carefully and address the message received within 7 days. If an Expert has any doubts about the 
     correctness of his/her response, he/she must make this clear and refuse to respond to messages 
     for which he/she lacks the necessary expertise. Experts will observe all applicable laws, 
     professional regulations, trade regulations, competition law, rules of criminal law, as well 
     as these Terms. 
 
  2. No Promotional Use. Experts are not permitted to use theFaveez App for promotional purposes or 
     to enter into contracts, which will be executed outside of the Faveez App. In particular, Experts 
     are prohibited from advertising for competing providers through the Faveez App. In the event of 
     a first-time culpable breach, Experts are obligated to pay Faveez a one-off penalty for damages 
     in the amount of 50% of the earnings over the last 30 days; in the event of a second culpable 
     breach, the amount to be paid is 100% of the earnings that have not been paid out. Faveez is 
     entitled to terminate the relationship after issuing a warning; any demand made for the payment 
     of the one-off penalty for the first time shall be considered a warning. Experts have the right 
     to prove that fewer damages have been suffered, and Faveez may prove that greater damages have 
     been suffered. Faveez shall have a right to offset in this regard.
 
  3. No Irrelevant or Unspecific Offers. Faveez endeavors to keep the quality of the services offered 
     by Experts high. Therefore, it is prohibited to provide irrelevant responses of any kind, which 
     do not contain any relevant content in terms of the message received or reflect the category in 
     which they are offered.
 
  4. False or Incorrect Descriptions. Experts must present their characteristics, interests, skills, 
     qualifications and other information in the descriptions truthfully, correctly and completely. 
     The guidelines for creating a profile within the Faveez App must be observed.
 
  5. Exerting Pressure on Advice Seekers. Experts should not obligate or urge Advice Seekers in any 
     form to send messages subject to a fee again or to do other things, which solely serve the economic 
     interests of the Expert.
 
  6. No Side Agreements. Experts are prohibited from making agreements with Advice Seekers during the term 
     of the contract, which will be executed outside of the Faveez App.
 
  7. Handling Emergency Situations. If an Expert becomes aware in the course of communications that an 
     acute danger to the life or limb of an Advice Seeker exists, the Expert must provide assistance 
     immediately and inform the corresponding public authorities. Furthermore, every Expert is advised 
     to give the Advice Seeker a crisis hotline number, if appropriate. National emergency and crisis 
     hotline numbers are available at https://www.deutsche-depressionshilfe.de/depression-infos-und-
     hilfe/wo-finde-ich-hilfe/krisendienste-und-beratungsstellen for Germany and at 
     
     https://www.psychguides.com/hotlines/depression/ for the USA.

11.3 Remuneration.
 
  1. Tax Liabilities. It is the Experts own responsibility to pay taxes and duties. The income of Experts 
     is subject to tax in general. Experts, who are obliged to pay VAT, must pay VAT to their tax office. 
     In cases of doubts, Experts should discuss their tax liability with their tax advisor. At the request 
     of the tax authorities, Faveez must make the invoices of the Expert available to the corresponding 
     tax offices and provide other information.
 
  2. Minimum Turnover. A minimum amount of turnover is not guaranteed.
 
  3. Remuneration.  The gross amount of the fee to be paid for a text reply, video reply and video call is 
     determined by the expert. The expert can determine his or her own desired revenue. The currency displayed 
     the Faveez app depends on the country in which the expert has registered. The actual payout amount 
     after settlement (see 11.3 (e)) may differ from the payout amount displayed on the dashboard due to 
     currency conversion fees and exchange rate fluctuations.
 
  4. Forwarding of Fees. Faveez forwards the fees for responses to Experts after deducting a fee for the 
     use of the Faveez App (“Faveez Fee”). The Faveez fee is determined by Faveez includes 19% German sales tax.
 
  5. Statement of Account. Unless otherwise agreed and subject to tax requirements, the Expert shall issue 
     an online invoice to Faveez at the end of the month and then provide it to Faveez within the Faveez 
     App. The calculated claim amount will be settled within forty (40) business days from the date of 
     invoicing. The payment shall be made via PayPal or bank transfer. Payments will only be made starting 
     from a minimum disbursement amount of EUR 1USD. Otherwise, the credit will be retained without 
     interest until the minimum disbursement amount has been reached at the end of the month. Any credit 
     that cannot be paid out shall expire at the end of the third year in which the credit is earned, 
     unless the contract is terminated sooner.
 

  6. Offsetting. Faveez shall be entitled to offset against any claims of an Expert that are uncontested 
  or have been recognized by a court of law.

11.4 Miscellaneous.
 
  1. Protection of Business and Trade Secrets. Business and trade secrets as well as confidential 
     information may only be disclosed to employees, engaged third parties, cooperation partners, etc. 
     to the extent necessary for fulfilling this agreement. Moreover, Experts are obligated to keep 
     confidential any business and trade secrets as well as confidential information of Faveez even after 
     the termination of this contract and to take security measures to protect this information against 
     theft, loss or unauthorized access of third parties, and to refrain from exploiting, reproducing, 
     altering or disclosing to third parties business and trade secrets as well as confidential information 
     of Faveez.

  2. Data Protection. Experts are obligated to protect personal data of Users, which Faveez makes available 
     to them in connection with the use of the Faveez App, in accordance with the General Data Protection 
     Regulation.

12 Final Provisions
 
12.1 Online Dispute Resolution.
 
The European Commission provides a platform for extra-judicial online dispute resolution (OS Platform), 
which is available at www.ec.europa.eu/consumers/odr. Our email address is support@faveez.com. We are 
neither obligated nor willing to participate in a dispute resolution procedure.
 
12.2 Transfer of Rights.
 
Faveez is entitled to transfer its rights and obligations resulting from this contractual relationship, 
in whole or in part, to a third party in observance of a notice period of four weeks.
 
12.3 Miscellaneous.
 
This agreement shall be governed exclusively by the law of the Federal Republic of Germany, excluding 
the UN Convention on Contracts for the International Sale of Goods (CISG). The place of performance 
for this agreement shall be the location of the registered office of Faveez. If the User is an 
entrepreneur, the agreed legal venue shall be the location of the registered office of Faveez. 
Entrepreneur means any natural or legal person or a partnership with legal capacity that concludes 
a legal transaction in the course of carrying out its commercial or independent professional activities. 
The invalidity of any individual provisions shall not affect the validity of the remaining provisions.
​
Annex 1

RIGHT OF WITHDRAWAL OF CONSUMERS FOR PAID SERVICES
 
For all Users, whose habitual residence is within the European Union, the following shall apply: You have 
a right of withdrawal if text replies, video replies and video calls are purchased.
 
INSTRUCTIONS ON WITHDRAWAL
 
Right of Withdrawal
 
You have a right to withdraw from this contract within fourteen days without giving any reason.
 
The withdrawal period will expire fourteen days from the date of entering into the contract. 
 
To exercise your right of withdrawal, you must inform us (Faveez UG, Meissner Straße 79, 01445 
Radebeul, Germany, telephone: +491726305061, email: support@faveez.com) of your decision to withdraw 
from this contract by an unequivocal statement (e.g., a letter sent by post, fax or email).
You may use the provided model withdrawal form, but it is not obligatory.
 
To meet the withdrawal deadline, it is sufficient for you to send your communication concerning 
your exercise of the right of withdrawal before the withdrawal period has expired.
 
Effects of Withdrawal

If you withdraw from this contract, we will reimburse to you all payments received from you, 
including delivery charges (except for the additional costs arising from your choosing a different 
delivery method than the most favorable standard delivery we offer) without undue delay and in any 
event no later than 14 days from the day on which we are informed about your decision to withdraw 
from this contract. We will carry out such reimbursement using the same means of payment as you used 
for the initial transaction, unless you have expressly agreed otherwise; in any event, you will not 
incur any fees as a result of such reimbursement. 
 
If you requested to begin the performance of services during the withdrawal period, you shall pay 
us an amount, which is in proportion to what has been provided until you have communicated to us your 
withdrawal from this contract, in comparison with the full coverage of the contract.

END OF THE INSTRUCTIONS ON WITHDRAWAL

Model Withdrawal Form
(If you want to withdraw from the contract, please complete this form and return it to us.)
To: Faveez UG, Meissner Straße 79, 01445 Radebeul, Germany, email: support@faveez.com

I/We (*) hereby give notice that I/We (*) withdraw from my/our (*) contract of sale of the following 
goods (*)/for the provision of the following service (*)
Ordered on (*)/received on (*)
Name of consumer(s)
Address of consumer(s)
Signature of consumer(s) (only if this form is notified on paper)
Date
(*) Delete as appropriate

Annex 2

(hereinafter, the »Agreement«)
concluded by and between the Expert
-hereinafter, the »Company«-
and Faveez UG
-hereinafter, the »Supplier«-

– both Company and Supplier hereinafter individually referred to as a »Party«, and jointly referred 
to as the »Parties« on contract data processing on behalf as referred to by section 11 paragraph 2 
of the German federal data protection act (»Bundesdatenschutzgesetz«, hereinafter »BDSG«)

Preamble

This annex details the obligations of the Parties related to the protection of data resulting from 
the scope of the processing of personal data on behalf as defined in detail in the additional terms 
and conditions for Experts. It shall apply to all activity within the scope of and related to the 
Agreement, and in whose context the Supplier’s employees or subcontractors may come into contact 
with Company’s personal data.

§ 1 Scope, Duration and Specification as to Contract Data Processing on Behalf

The scope and duration as well as the extent and nature of the collection, processing and use of 
personal data shall be as defined in the Agreement. Processing on behalf shall include in particular, 
but not be limited to, the categories of personal data listed in the table below: See privacy policy

Except where this annex expressly stipulates any surviving obligation, the term of this annex shall 
follow the term of the Agreement.

§ 2 Scope of Application and Distribution of Responsibilities

(1) Supplier shall process personal data on behalf of Company. The foregoing shall include the activities 
enumerated and detailed in the Agreement and its scope of work. Within the scope of the Agreement, Company 
shall be solely responsible for complying with the statutory data privacy and protection regulations, 
including, but not limited to, the lawfulness of the transmission to the Supplier and the lawfulness of 
processing; Company shall be the responsible body (»verantwortliche Stelle«) as defined in section 3 
paragraph 7 BDSG.

(2) Any instruction by Company to Supplier related to processing (hereinafter, a »Processing Instruction«) 
shall, initially, be defined in the Agreement, and Company shall be entitled to issuing changes and 
amendments to Processing Instructions and to issue new Processing Instructions. Parties shall treat any 
Processing Instruction exceeding the scope of work defined in the Agreement as a change request.

§ 3 Supplier’s Obligations and Responsibilities

(1) Supplier shall collect, process, and use data related to data subjects only within the scope of work 
and the Processing Instructions issued by Company.

(2) Supplier shall, within Supplier’s scope of responsibility, structure Supplier’s internal organisation 
so it complies with the specific requirements of the protection of personal data. Supplier shall implement 
and maintain technical and organisational measures to adequately protect Company’s data in accordance 
with and satisfying the requirements of the BDSG (annex to section 9 BDSG). These measures shall be 
implemented as defined in the following list:
 
  a) physical access control
  
  b) logical access control
  
  c) data access control
  
  d) data transfer control
  
  e) data entry control
  
  f) control of Processing Instructions
  
  g) availability control
  
  h) separation control
  

Supplier shall be entitled to modifying the security measures agreed upon, provided, however, that no 
modification shall be permissible if it derogates from the level of protection contractually agreed upon.

(3) Upon Company’s request, and except where Company is able to obtain such information directly, Supplier 
shall provide all information necessary for compiling the overview defined by § 4g paragraph 2 sentence 1 
BDSG.

(4) Supplier shall ensure that any personnel entrusted with processing Company’s data have undertaken to 
comply with the principle of data secrecy in accordance with § 5 BDSG and have been duly instructed on 
the protective regulations of the BDSG. The undertaking to secrecy shall continue after the termination 
of the above-entitled activities.

(5) Supplier shall, without undue delay, inform Company of any material breach of the regulations for 
the protection of Company’s personal data, committed by Supplier or Supplier’s personnel. Supplier shall 
implement the measures necessary to secure the data and to mitigate potential adverse effects on the data 
subjects and shall agree upon the same with Company without undue delay. Supplier shall support Company 
in fulfilling Company’s disclosure obligations under section 42a BDSG.

(6) Supplier shall notify to Company the point of contact for all issues related to data privacy and 
protection within the scope of the Agreement.

(7) Supplier represents and warrants that Supplier complies with Supplier’s obligations under sections 
4f and 4g BDSG (section 11 paragraph 2 no. 5 in connection with section 11 paragraph 4 BDSG). The 
foregoing shall include in particular, but not be limited to, Supplier’s obligations to appoint a 
data protection official where required by law.

(8) Supplier shall not use data transmitted to Supplier for any purpose other than to fulfil Supplier’s 
obligations under the Agreement.

(9) Where Company so instructs Supplier, Supplier shall correct, delete or block data in the scope of 
this Agreement. Unless stipulated differently in the Agreement, Supplier shall, at Company’s individual 
request, destroy data carrier media and other related material securely and beyond recovery of the data 
it contains. Where Company so instructs Supplier, Supplier shall archive and/or provide to Company, 
such carrier media and other related material.

(10) Supplier shall, upon Company’s order, provide to Company or delete any data, data carrier media and 
other related materials after the termination or expiration of the Agreement.

§ 4 Company’s Obligations
 
(1) Company shall, without undue delay and in a comprehensive fashion, inform Supplier of any defect 
Company may detect in Supplier’s work results and of any irregularity in the implementation of statutory 
regulations on data privacy.
 
(2) Company shall be obliged to maintain the public register of processing in accordance with section 
4g paragraph 2 sentence 2 BDSG.

§ 5 Enquiries by Data Subjects

(1) Where, in accordance with applicable data privacy laws, Company is obliged to answer a data subject’s 
enquiry related to the collection, processing or use of such data subject’s data, Supplier shall support 
Company in providing the required information. The foregoing shall be apply only where Company has so 
instructed Supplier in writing or in text form, and where Company reimburses Supplier for the cost and 
expenses incurred in providing such support. Supplier shall not directly respond to any enquiries of 
data subjects and shall refer such data subjects to Company.

(2) Where a data subject requests Supplier correct, delete or block data, Supplier shall refer such data 
subject to Company.

§ 6 Audit Obligations

(1) Company shall, prior to the commencement of the processing of data and at regular intervals thereafter 
[alternatively, an interval may be expressly stipulated], audit the technical and organisational measures 
implemented by Supplier and shall document the result of such audit.
 
In the course of such audit, Company may, in particular, conduct the following measures, but shall not 
be limited to the same:
 
  1. Company may obtain information from Supplier.

  2. Company may request Supplier to submit to Company an existing attestation or certificate by an 
  independent professional expert.

  3. Company may, upon reasonable and timely advance agreement, during regular business hours and without 
  interrupting Supplier’s business operations, conduct an on-site inspection of Supplier’s business 
  operations or have the same conducted by a qualified third party which shall not be a competitor of 
  Supplier
 
(2) Supplier shall, at Company’s written request and within a reasonable period of time, submit to Company 
any and all information, documentation and other means of factual proof necessary for the conduction of 
an audit.

§ 7 Subcontractors
 
(1) Supplier shall not subcontract any part of the scope of work defined in the Agreement to a subcontractor 
except with Company’s prior written approval* for each individual act of subcontracting. Supplier shall diligently select any subcontractor, duly taking into account their qualification.
 
(2) Company consents to Supplier’s subcontracting, to the subcontractors enumerated in the following table, 
the scope of work defined in the Agreement, and/or the individual deliverables enumerated below, as the 
case may be:

Subcontractor name and address
Mixpanel Inc., 405 Howard Street, Floor 2, San Francisco, CA 94105

Description of the individual deliverables
Logging of page views and page activities

(3) Where Supplier subcontracts deliverables to subcontractors, Supplier shall be obliged to extend any 
and all of Supplier’s obligations under the Agreement to all subcontractors. Sentence 1 shall apply in 
particular, but not be limited to, the requirements on the confidentiality and protection of data as 
well as data security, each as agreed upon between the Parties. Company shall be entitled to auditing 
Supplier’s subcontractors only upon prior agreement with Supplier to that effect.
 
At Company’s written request, Supplier shall be required to provide to Company comprehensive information 
on the obligations of all subcontractors as they relate to data privacy and protection; this information 
shall, where necessary, include Company’s right to inspect the relevant contract documents.
 
(4) The approval requirements for subcontracting shall not apply in cases where Company subcontracts 
ancillary deliverables to third parties; such ancillary deliverables shall include, but not be limited 
to, the provision of external contractors, mail, shipping and receiving services, and maintenance 
services. Supplier shall conclude, with such third parties, any agreement necessary to ensure the 
adequate protection of data.

§ 8 Duties to Notify, Mandatory Written Form, Choice of Law
 
(1) Where Company’s data becomes subject to search and seizure, an attachment order, confiscation during 
bankruptcy or insolvency proceedings, or similar events or measures by third parties while in Supplier’s 
control, Supplier shall notify Company of such action without undue delay. Supplier shall, without undue 
delay, notify to all pertinent parties in such action, that any data affected thereby is in Company’s 
sole property and area of responsibility, that data is at Company’s sole disposition, and that Company 
is the responsible body in the sense of the BDSG.
 
(2) No modification of this annex and/or any of its components – including, but not limited to, Supplier’s 
representations and warranties, if any – shall be valid and binding unless made in writing and then only 
if such modification expressly states that such modification applies to the regulations of this annex. 
The foregoing shall also apply to any waiver or modification of this mandatory written form.
 
(3) In case of any conflict, the regulations of this annex shall take precedence over the regulations of 
the Agreement. Where individual regulations of this annex are invalid or unenforceable, the validity and 
enforceability of the other regulations of this annex shall not be affected.
 
(4) This annex is subject to the laws of the Federal Republic of Germany.

""";
}
