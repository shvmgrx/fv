import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/screens/chatscreens/widgets/modalTile.dart';
// import 'package:fv/widgets/nmButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/enum/view_state.dart';
import 'package:fv/models/message.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/resources/chat_methods.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/screens/callscreens/pickup/pickup_layout.dart';
import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
// import 'package:fv/ui_elements/loader.dart';
import 'package:fv/utils/call_utilities.dart';
import 'package:fv/utils/permissions.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/utils/utilities.dart';
import 'package:fv/widgets/appbar.dart';
import 'package:fv/widgets/custom_tile.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:fv/widgets/nmBox.dart';
import 'package:provider/provider.dart';
import 'package:date_time_format/date_time_format.dart';
// import 'package:flutter/services.dart';
// import 'package:media_picker/media_picker.dart';

import 'package:stripe_payment/stripe_payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;

  ChatScreen({this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textFieldController = TextEditingController();
  FirebaseRepository _repository = FirebaseRepository();
  ScrollController _listScrollController = ScrollController();

  final ChatMethods _chatMethods = ChatMethods();

  User sender;

  String _currentUserId;

  bool isWriting = false;

  ImageUploadProvider _imageUploadProvider;

  bool textReplyChosen = false;
  bool videoReplyChosen = false;

  int valueSelected = 0;

  //For video
  // String _platformVersion = 'Unknown';
  // List<dynamic> _mediaPaths;

  @override
  void initState() {
    super.initState();

    _repository.getCurrentUser().then((user) {
      _currentUserId = user.uid;

      setState(() {
        sender = User(
          uid: user.uid,
          name: user.displayName,
          profilePhoto: user.photoUrl,
        );
      });
    });
  }

  void onRadioChanged(int value) {
    setState(() {
      valueSelected = value;
    });

    print('Value = $value');
  }

  void stripePayment(int billAmount) {
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_live_FheU3MdCQh1zmfTBPEXZQNRP004f2b4pbj"));

    final HttpsCallable INTENT = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createPaymentIntent');

    StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
        .then((paymentMethod) {
    double amount = billAmount * 100.0; // multipliying with 100 to change $ to cents
  //  double amount = 1 * 100.0; 
      INTENT.call(<String, dynamic>{'amount': amount, 'currency': 'usd'}).then(
          (response) {
        confirmDialog(response.data["client_secret"], paymentMethod,
            billAmount); //function for confirmation for payment
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);

    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.backgroundGrey,
        appBar: customAppBar(context),
        body: Column(
          children: <Widget>[
            Flexible(
              child: messageList(),
            ),
            _imageUploadProvider.getViewState == ViewState.LOADING
                ? Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 15),
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            chatControls(),
          ],
        ),
      ),
    );
  }

  Widget messageList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(MESSAGES_COLLECTION)
          .document(_currentUserId)
          .collection(widget.receiver.uid)
          .orderBy(TIMESTAMP_FIELD, descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        // SchedulerBinding.instance.addPostFrameCallback((_) {
        //   _listScrollController.animateTo(
        //     _listScrollController.position.minScrollExtent,
        //     duration: Duration(milliseconds: 250),
        //     curve: Curves.easeInOut,
        //   );
        // });

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.documents.length,
          reverse: true,
          controller: _listScrollController,
          itemBuilder: (context, index) {
            // mention the arrow syntax if you get the time
            return chatMessageItem(snapshot.data.documents[index]);
          },
        );
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    Message _message = Message.fromMap(snapshot.data);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        alignment: _message.senderId == _currentUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderId == _currentUserId
            ? senderLayout(_message)
            : receiverLayout(_message),
      ),
    );
  }

  Widget senderLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
        margin: EdgeInsets.only(top: 0),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
        decoration: BoxDecoration(
          color: UniversalVariables.standardWhite,
          borderRadius: BorderRadius.only(
            topLeft: messageRadius,
            topRight: messageRadius,
            bottomLeft: messageRadius,
          ),
        ),
        child: message.type != MESSAGE_TYPE_IMAGE
            ? Padding(
                padding: EdgeInsets.all(10),
                child: getMessage(message),
              )
            : Padding(
                padding: EdgeInsets.all(5),
                child: getMessage(message),
              ));
  }

  getMessage(Message message) {
    final dateTime = message.timestamp;
    final messageTime = dateTime.toDate();
    return message.type != MESSAGE_TYPE_IMAGE
        ? InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.message,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: UniversalVariables.grey2,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      DateTimeFormat.format(messageTime, format: 'H:i'),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: UniversalVariables.grey2,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : message.photoUrl != null
            ? CachedImage(
                message.photoUrl,
                height: 250,
                width: 250,
                radius: 10,
              )
            : Text("Url was null");
  }

  Widget receiverLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
        margin: EdgeInsets.only(top: 0),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.45),
        decoration: BoxDecoration(
          color: UniversalVariables.standardWhite,
          borderRadius: BorderRadius.only(
            bottomRight: messageRadius,
            topRight: messageRadius,
            bottomLeft: messageRadius,
          ),
        ),
        child: message.type != MESSAGE_TYPE_IMAGE
            ? Padding(
                padding: EdgeInsets.all(10),
                child: getMessage(message),
              )
            : Padding(
                padding: EdgeInsets.all(5),
                child: getMessage(message),
              ));
  }

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    addMediaModal(context) {
      showModalBottomSheet(
          context: context,
          elevation: 0,
          backgroundColor: Colors.grey[200],
          builder: (context) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        color: UniversalVariables.backgroundGrey,
                        child: Icon(
                          Icons.close,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,

                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      ModalTile(
                        title: "Take photo",
                        subtitle: "Click and send a picture",
                        icon: CupertinoIcons.photo_camera,
                        onTap: () => pickImage(source: ImageSource.camera),
                      ),
                      ModalTile(
                        title: "Photo",
                        subtitle: "Share Photo from gallery",
                        icon: IconData(0xf2e4,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                        onTap: () => pickImage(source: ImageSource.gallery),
                      ),
                      ModalTile(
                        title: "Video",
                        subtitle: "Share Video (Under construction)",
                        icon: CupertinoIcons.video_camera,
                        // onTap: () => pickVideos(),
                      ),
                      // ModalTile(
                      //     title: "Schedule Call",
                      //     subtitle: "Videocall (Under construction)",
                      //     icon: CupertinoIcons.video_camera.),
                    ],
                  ),
                ),
              ],
            );
          });
    }

    sendMessage() {
      var text = textFieldController.text;

      Message _message = Message(
        receiverId: widget.receiver.uid,
        senderId: sender.uid,
        message: text,
        timestamp: Timestamp.now(),
        type: 'text',
      );

      setState(() {
        isWriting = false;
      });

      textFieldController.text = "";

      _chatMethods.addMessageToDb(_message, sender, widget.receiver);
    }

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
                  Text("Confirmation", style: TextStyles.paymentModalStyle),
                  Divider()
                ],
              ),
            ),
            content: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text("Choose reply type",
                              style: TextStyles.paymentTypeStyle),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      //gradient: UniversalVariables.fabGradient,
                                      color: UniversalVariables.gold2,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'TEXT REPLY',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: UniversalVariables
                                                .standardWhite),
                                      ),
                                    ),
                                  ),
                                  Radio(
                                      activeColor: UniversalVariables.gold2,
                                      value: 1,
                                      groupValue: valueSelected,
                                      onChanged: (int value) {
                                        onRadioChanged(value);
                                        showAlertDialog(context);
                                      })
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      //gradient: UniversalVariables.fabGradient,
                                      color: UniversalVariables.gold2,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'VIDEO REPLY',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: UniversalVariables
                                                .standardWhite),
                                      ),
                                    ),
                                  ),
                                  Radio(
                                      activeColor: UniversalVariables.gold2,
                                      value: 2,
                                      groupValue: valueSelected,
                                      onChanged: (int value) {
                                        onRadioChanged(value);
                                        showAlertDialog(context);
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          //    Navigator.pop(context),

                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: UniversalVariables.white2),
                            child: Center(
                              child: Icon(Icons.close,
                                  size: 20.0,
                                  color: UniversalVariables.offline),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.pop(context),
                            if (valueSelected == 1)
                              {
                                stripePayment(widget.receiver.answerPrice1),
                              }
                            else if (valueSelected == 2)
                              {
                                stripePayment(widget.receiver.answerPrice2),
                              }
                          },
                          //Navigator.pop(context),

                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: UniversalVariables.white2),
                            child: Center(
                              child: Icon(Icons.done,
                                  size: 20.0, color: UniversalVariables.online),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ));
    }

    return Container(
      padding: EdgeInsets.only(bottom: 25, left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: GestureDetector(
              onTap: () => addMediaModal(context),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: UniversalVariables.grey2,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: UniversalVariables.standardWhite),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              controller: textFieldController,
              style: TextStyle(
                color: UniversalVariables.grey1,
              ),
              onChanged: (val) {
                (val.length > 0 && val.trim() != "")
                    ? setWritingTo(true)
                    : setWritingTo(false);
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                  color: UniversalVariables.grey2,
                ),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                    borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: UniversalVariables.standardWhite,

              ),
            ),
          ),

          isWriting
              ? GestureDetector(
                  child: Container(
                    height: 42,
                    width: 42,
                    margin: EdgeInsets.only(left: 5),
                    decoration: priceSendBox,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(width: 10),
                        // Container(
                        //     margin: EdgeInsets.only(left: 3),
                        //     child: Text(
                        //       "\$ ${widget.receiver.answerPrice1}",
                        //       style: TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w300,
                        //         color: UniversalVariables.standardWhite,
                        //         fontFamily: 'Ubuntu',
                        //       ),
                        //     )),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.send,
                        //     size: 15,
                        //     //color:fCDD
                        //   ),
                        //   onPressed: () => sendMessage(),
                        // ),
                        SizedBox(width: 10),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Icon(Icons.send,
                              size: 20,
                              color: UniversalVariables.standardWhite),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => showAlertDialog(context),
                  // sendMessage(),
                )
              : Container()
        ],
      ),
    );
  }

  confirmDialog(String clientSecret, PaymentMethod paymentMethod, int amount) {
    var confirm = AlertDialog(
      title: Text("Confirm Payement"),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Make Payment",
              // style: TextStyle(fontSize: 25),
            ),
            Text("Charge amount:\$ ${amount}")
          ],
        ),
      ),
      actions: <Widget>[
        new RaisedButton(
          child: new Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
            final snackBar = SnackBar(
              content: Text('Payment Cancelled'),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
        new RaisedButton(
          child: new Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop();
            confirmPayment(
                clientSecret, paymentMethod); // function to confirm Payment
          },
        ),
      ],
    );


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return confirm;
        });
  }

  confirmPayment(String sec, PaymentMethod paymentMethod) {
    StripePayment.confirmPaymentIntent(
      PaymentIntent(clientSecret: sec, paymentMethodId: paymentMethod.id),
    ).then((val) {
      // addPaymentDetailsToFirestore(); //Function to add Payment details to firestore
      final snackBar = SnackBar(
        content: Text('Payment Successfull'),
      );
      Scaffold.of(context).showSnackBar(snackBar);

      
    });
  }

    //   sendMessage() {
    //   var text = textFieldController.text;

    //   Message _message = Message(
    //     receiverId: widget.receiver.uid,
    //     senderId: sender.uid,
    //     message: text,
    //     timestamp: Timestamp.now(),
    //     type: 'text',
    //   );

    //   setState(() {
    //     isWriting = false;
    //   });

    //   textFieldController.text = "";

    //   _chatMethods.addMessageToDb(_message, sender, widget.receiver);
    // }

  void pickImage({@required ImageSource source}) async {
    File selectedImage = await Utils.pickImage(source: source);
    _repository.uploadImage(
        image: selectedImage,
        receiverId: widget.receiver.uid,
        senderId: _currentUserId,
        imageUploadProvider: _imageUploadProvider);
  }

  // pickVideos() async {
  //   try {
  //     _mediaPaths = await MediaPicker.pickVideos(quantity: 1);
  //   } on PlatformException {}

  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = _mediaPaths.toString();
  //   });
  // }

  CustomAppBar customAppBar(context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return CustomAppBar(
      leading: IconButton(
        color: UniversalVariables.grey2,
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        widget.receiver.name,
        style: TextStyles.chatProfileName,
      ),
      actions: <Widget>[
        
        (userProvider.getUser.isInfCert == true &&
                userProvider.getUser.answerPrice3 != null)
            ? IconButton(
                color: UniversalVariables.grey2,
                icon: Icon(
                  Icons.video_call,
                ),
                onPressed: () async =>
                    await Permissions.cameraAndMicrophonePermissionsGranted()
                        ? CallUtils.dial(
                            from: sender,
                            to: widget.receiver,
                            context: context,
                          )
                        : {},
              )
            : Container(),
      ],
    );
  }
}
