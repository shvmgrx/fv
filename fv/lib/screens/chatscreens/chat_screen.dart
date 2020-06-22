// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fv/widgets/nmButton.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:fv/constants/strings.dart';
// import 'package:fv/enum/view_state.dart';
// import 'package:fv/models/message.dart';
// import 'package:fv/models/user.dart';
// import 'package:fv/onboarding/text_styles.dart';
// import 'package:fv/provider/user_provider.dart';
// import 'package:fv/resources/chat_methods.dart';
// import 'package:fv/resources/firebase_repository.dart';
// import 'package:fv/screens/callscreens/pickup/pickup_layout.dart';
// import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
// import 'package:fv/ui_elements/loader.dart';
// import 'package:fv/utils/call_utilities.dart';
// import 'package:fv/utils/permissions.dart';
// import 'package:fv/utils/universal_variables.dart';
// import 'package:fv/utils/utilities.dart';
// import 'package:fv/widgets/appbar.dart';
// import 'package:fv/widgets/custom_tile.dart';
// import 'package:fv/provider/image_upload_provider.dart';
// import 'package:fv/widgets/nmBox.dart';
// import 'package:provider/provider.dart';
// import 'package:date_time_format/date_time_format.dart';
// // import 'package:flutter/services.dart';
// // import 'package:media_picker/media_picker.dart';

// class ChatScreen extends StatefulWidget {
//   final User receiver;

//   ChatScreen({this.receiver});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController textFieldController = TextEditingController();
//   FirebaseRepository _repository = FirebaseRepository();
//   ScrollController _listScrollController = ScrollController();

//   final ChatMethods _chatMethods = ChatMethods();

//   User sender;

//   String _currentUserId;

//   bool isWriting = false;

//   ImageUploadProvider _imageUploadProvider;

//   bool textReplyChosen = false;
//   bool videoReplyChosen = false;

//   //For video
//   // String _platformVersion = 'Unknown';
//   // List<dynamic> _mediaPaths;

//   @override
//   void initState() {
//     super.initState();

//     _repository.getCurrentUser().then((user) {
//       _currentUserId = user.uid;

//       setState(() {
//         sender = User(
//           uid: user.uid,
//           name: user.displayName,
//           profilePhoto: user.photoUrl,
//         );
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _imageUploadProvider = Provider.of<ImageUploadProvider>(context);

//     return PickupLayout(
//       scaffold: Scaffold(
//         backgroundColor: UniversalVariables.backgroundGrey,
//         appBar: customAppBar(context),
//         body: Column(
//           children: <Widget>[
//             Flexible(
//               child: messageList(),
//             ),
//             _imageUploadProvider.getViewState == ViewState.LOADING
//                 ? Container(
//                     alignment: Alignment.centerRight,
//                     margin: EdgeInsets.only(right: 15),
//                     child: CircularProgressIndicator(),
//                   )
//                 : Container(),
//             chatControls(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget messageList() {
//     return StreamBuilder(
//       stream: Firestore.instance
//           .collection(MESSAGES_COLLECTION)
//           .document(_currentUserId)
//           .collection(widget.receiver.uid)
//           .orderBy(TIMESTAMP_FIELD, descending: true)
//           .snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.data == null) {
//           return Center(child: CircularProgressIndicator());
//         }

//         // SchedulerBinding.instance.addPostFrameCallback((_) {
//         //   _listScrollController.animateTo(
//         //     _listScrollController.position.minScrollExtent,
//         //     duration: Duration(milliseconds: 250),
//         //     curve: Curves.easeInOut,
//         //   );
//         // });

//         return ListView.builder(
//           padding: EdgeInsets.all(10),
//           itemCount: snapshot.data.documents.length,
//           reverse: true,
//           controller: _listScrollController,
//           itemBuilder: (context, index) {
//             // mention the arrow syntax if you get the time
//             return chatMessageItem(snapshot.data.documents[index]);
//           },
//         );
//       },
//     );
//   }

//   Widget chatMessageItem(DocumentSnapshot snapshot) {
//     Message _message = Message.fromMap(snapshot.data);

//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 5),
//       child: Container(
//         alignment: _message.senderId == _currentUserId
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         child: _message.senderId == _currentUserId
//             ? senderLayout(_message)
//             : receiverLayout(_message),
//       ),
//     );
//   }

//   Widget senderLayout(Message message) {
//     Radius messageRadius = Radius.circular(10);

//     return Container(
//         margin: EdgeInsets.only(top: 0),
//         constraints:
//             BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
//         decoration: BoxDecoration(
//           color: UniversalVariables.standardWhite,
//           borderRadius: BorderRadius.only(
//             topLeft: messageRadius,
//             topRight: messageRadius,
//             bottomLeft: messageRadius,
//           ),
//         ),
//         child: message.type != MESSAGE_TYPE_IMAGE
//             ? Padding(
//                 padding: EdgeInsets.all(10),
//                 child: getMessage(message),
//               )
//             : Padding(
//                 padding: EdgeInsets.all(5),
//                 child: getMessage(message),
//               ));
//   }

//   getMessage(Message message) {
//     final dateTime = message.timestamp;
//     final messageTime = dateTime.toDate();
//     return message.type != MESSAGE_TYPE_IMAGE
//         ? InkWell(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   message.message,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     color: UniversalVariables.grey2,
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Text(
//                       DateTimeFormat.format(messageTime, format: 'H:i'),
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w300,
//                         color: UniversalVariables.grey2,
//                         fontFamily: 'Ubuntu',
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         : message.photoUrl != null
//             ? CachedImage(
//                 message.photoUrl,
//                 height: 250,
//                 width: 250,
//                 radius: 10,
//               )
//             : Text("Url was null");
//   }

//   Widget receiverLayout(Message message) {
//     Radius messageRadius = Radius.circular(10);

//     return Container(
//         margin: EdgeInsets.only(top: 0),
//         constraints:
//             BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.45),
//         decoration: BoxDecoration(
//           color: UniversalVariables.standardWhite,
//           borderRadius: BorderRadius.only(
//             bottomRight: messageRadius,
//             topRight: messageRadius,
//             bottomLeft: messageRadius,
//           ),
//         ),
//         child: message.type != MESSAGE_TYPE_IMAGE
//             ? Padding(
//                 padding: EdgeInsets.all(10),
//                 child: getMessage(message),
//               )
//             : Padding(
//                 padding: EdgeInsets.all(5),
//                 child: getMessage(message),
//               ));
//   }

//   Widget chatControls() {
//     setWritingTo(bool val) {
//       setState(() {
//         isWriting = val;
//       });
//     }

//     addMediaModal(context) {
//       showModalBottomSheet(
//           context: context,
//           elevation: 0,
//           backgroundColor: Colors.grey[200],
//           builder: (context) {
//             return Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   child: Row(
//                     children: <Widget>[
//                       FlatButton(
//                         color: UniversalVariables.backgroundGrey,
//                         child: Icon(
//                           Icons.close,
//                         ),
//                         onPressed: () => Navigator.maybePop(context),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           // child: Text(
//                           //   "Content and tools",
//                           //   style: TextStyle(
//                           //       color: UniversalVariables.grey2,
//                           //       fontSize: 20,
//                           //       fontWeight: FontWeight.bold),
//                           // ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   child: ListView(
//                     children: <Widget>[
//                       ModalTile(
//                         title: "Take photo",
//                         subtitle: "Click and send a picture",
//                         icon: CupertinoIcons.photo_camera,
//                         onTap: () => pickImage(source: ImageSource.camera),
//                       ),
//                       ModalTile(
//                         title: "Photo",
//                         subtitle: "Share Photo from gallery",
//                         icon: IconData(0xf2e4,
//                             fontFamily: CupertinoIcons.iconFont,
//                             fontPackage: CupertinoIcons.iconFontPackage),
//                         onTap: () => pickImage(source: ImageSource.gallery),
//                       ),
//                       ModalTile(
//                         title: "Video",
//                         subtitle: "Share Video (Under construction)",
//                         icon: CupertinoIcons.video_camera,
//                         // onTap: () => pickVideos(),
//                       ),
//                       // ModalTile(
//                       //     title: "Schedule Call",
//                       //     subtitle: "Videocall (Under construction)",
//                       //     icon: CupertinoIcons.video_camera.),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           });
//     }

//     sendMessage() {
//       var text = textFieldController.text;

//       Message _message = Message(
//         receiverId: widget.receiver.uid,
//         senderId: sender.uid,
//         message: text,
//         timestamp: Timestamp.now(),
//         type: 'text',
//       );

//       setState(() {
//         isWriting = false;
//       });

//       textFieldController.text = "";

//       _chatMethods.addMessageToDb(_message, sender, widget.receiver);
//     }

//     return Container(
//       padding: EdgeInsets.only(bottom:25,left:10,right:10),
//       child: Row(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(left: 5, right: 5),
//             child: GestureDetector(
//               onTap: () => addMediaModal(context),
//               child: Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: UniversalVariables.grey2,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(Icons.add, color: UniversalVariables.standardWhite),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Expanded(
//             child: TextField(
//               controller: textFieldController,
//               style: TextStyle(
//                 color: UniversalVariables.grey1,
//               ),
//               onChanged: (val) {
//                 (val.length > 0 && val.trim() != "")
//                     ? setWritingTo(true)
//                     : setWritingTo(false);
//               },
//               decoration: InputDecoration(
//                 hintText: "Type a message",
//                 hintStyle: TextStyle(
//                   color: UniversalVariables.grey2,
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(50.0),
//                     ),
//                     borderSide: BorderSide.none),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                 filled: true,
//                 fillColor: UniversalVariables.standardWhite,
//                 // suffixIcon: GestureDetector(
//                 //   onTap: () {},
//                 //   child: Icon(Icons.face),
//                 // ),
//               ),
//             ),
//           ),
//           // isWriting
//           //     ? Container()
//           //     : Padding(
//           //         padding: EdgeInsets.symmetric(horizontal: 10),
//           //         child: Icon(Icons.record_voice_over),
//           //       ),
//           // isWriting
//           //     ? Container()
//           //     : Container(
//           //         margin: EdgeInsets.only(left: 5, right: 5),
//           //         child: GestureDetector(
//           //           child: Icon(
//           //             Icons.camera_alt,
//           //             color: UniversalVariables.grey2,
//           //           ),
//           //           onTap: () => pickImage(source: ImageSource.camera),
//           //         ),
//           //       ),
//           isWriting
//               ? GestureDetector(
//                   child: Container(
//                     height: 42,
//                     margin: EdgeInsets.only(left: 3),
//                     decoration: priceSendBox,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         //SizedBox(width: 10),
//                         Container(
//                             margin: EdgeInsets.only(left: 3),
//                             child: Text(
//                               "\$ ${widget.receiver.answerPrice1}",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w300,
//                                 color: UniversalVariables.standardWhite,
//                                 fontFamily: 'Ubuntu',
//                               ),
//                             )),
//                         // IconButton(
//                         //   icon: Icon(
//                         //     Icons.send,
//                         //     size: 15,
//                         //     //color:fCDD
//                         //   ),
//                         //   onPressed: () => sendMessage(),
//                         // ),
//                         SizedBox(width: 10),
//                         Container(
//                           margin: EdgeInsets.only(right: 8),
//                           child: Icon(Icons.send,
//                               size: 15,
//                               color: UniversalVariables.standardWhite),
//                         ),
//                       ],
//                     ),
//                   ),
//                   onTap: () => showAboutDialog(context: context)
//                // sendMessage(),
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }

//   void pickImage({@required ImageSource source}) async {
//     File selectedImage = await Utils.pickImage(source: source);
//     _repository.uploadImage(
//         image: selectedImage,
//         receiverId: widget.receiver.uid,
//         senderId: _currentUserId,
//         imageUploadProvider: _imageUploadProvider);
//   }

//   // pickVideos() async {
//   //   try {
//   //     _mediaPaths = await MediaPicker.pickVideos(quantity: 1);
//   //   } on PlatformException {}

//   //   if (!mounted) return;

//   //   setState(() {
//   //     _platformVersion = _mediaPaths.toString();
//   //   });
//   // }

//   CustomAppBar customAppBar(context) {
//     final UserProvider userProvider = Provider.of<UserProvider>(context);
//     return CustomAppBar(
//       leading: IconButton(
//         color: UniversalVariables.grey2,
//         icon: Icon(
//           Icons.arrow_back,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       centerTitle: false,
//       title: Text(
//         widget.receiver.name,
//         style: TextStyles.chatProfileName,
//       ),
//       actions: <Widget>[
//         //comes here
//         (userProvider.getUser.isInfCert == true &&
//                 userProvider.getUser.answerPrice3 != null)
//             ? IconButton(
//                 color: UniversalVariables.grey2,
//                 icon: Icon(
//                   Icons.video_call,
//                 ),
//                 onPressed: () async =>
//                     await Permissions.cameraAndMicrophonePermissionsGranted()
//                         ? CallUtils.dial(
//                             from: sender,
//                             to: widget.receiver,
//                             context: context,
//                           )
//                         : {},
//               )
//             : Container(),
//         // IconButton(
//         //   color: UniversalVariables.grey2,
//         //   icon: Icon(
//         //     Icons.phone,
//         //   ),
//         //   onPressed: () {},
//         // )
//       ],
//     );
//   }
// }

// void showAlertDialog(BuildContext context) {

//   showDialog(
//     context: context,
//     child:  CupertinoAlertDialog(
//       title: Text("Log out?"),
//       content: Text( "Are you sure you want to log out?"),
//       actions: <Widget>[
//         CupertinoDialogAction(
//             isDefaultAction: true,
//             onPressed: (){
//               Navigator.pop(context);
//             },
//             child: Text("Cancel")
//         ),
//         CupertinoDialogAction(
//           textStyle: TextStyle(color: Colors.red),
//             isDefaultAction: true,
//             onPressed: () async {
//               Navigator.pop(context);

//             },
//             child: Text("Log out")
//         ),
//       ],
//     ));
// }

// class ModalTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Function onTap;

//   const ModalTile(
//       {@required this.title,
//       @required this.subtitle,
//       @required this.icon,
//       this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       child: CustomTile(
//         mini: false,
//         onTap: onTap,
//         leading: Container(
//           margin: EdgeInsets.only(right: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: UniversalVariables.transparent,
//           ),
//           padding: EdgeInsets.all(10),
//           child: Container(
//             width: 55,
//             height: 55,
//             decoration: nMbox,
//             child: Icon(
//               icon,
//               color: fCDD,
//               size: 38,
//             ),
//           ),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: TextStyle(
//             color: UniversalVariables.grey1,
//             fontSize: 14,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: UniversalVariables.grey1,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     );
//   }

// }

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/widgets/nmButton.dart';
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
import 'package:fv/ui_elements/loader.dart';
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
                          // child: Text(
                          //   "Content and tools",
                          //   style: TextStyle(
                          //       color: UniversalVariables.grey2,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold),
                          // ),
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
                      padding: const EdgeInsets.only(top:20.0),
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
                                    ),),
                               
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'TEXT REPLY',
                                    style: TextStyle(fontSize: 16.0,color:UniversalVariables.standardWhite),
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
                                    ),),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'VIDEO REPLY',
                                   style: TextStyle(fontSize: 16.0,color:UniversalVariables.standardWhite),
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
                  onTap: () => {
                   Navigator.pop(context),
                   Navigator.pop(context),
                  
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalVariables.white2),
                    child: Center(
                      child: Icon(Icons.close,
                          size: 20.0, color: UniversalVariables.offline),
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
                   Navigator.pop(context),
                  
                  },
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

                    // Padding(
                    //   padding: const EdgeInsets.all(15.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: <Widget>[
                          // OutlineButton(
                          //   onPressed: () {
                          //     Navigator.pop(context);

                          //     setState(() {
                          //       textReplyChosen = true;
                          //       videoReplyChosen = false;
                          //     });
                          //   },
                          //   focusColor: UniversalVariables.gold2,
                          //   borderSide: BorderSide.solid,
                          //   child: Text(
                          //       "\$ ${widget.receiver.answerPrice1} TEXT REPLY",
                          //       style: textReplyChosen
                          //           ? TextStyles.replyTypeStyle
                          //           : TextStyles.replyTypeSelectedStyle),
                          // ),
                    //       Spacer(),
                    //       OutlineButton(
                    //         color: videoReplyChosen
                    //             ? UniversalVariables.white1
                    //             : UniversalVariables.gold2,
                    //         onPressed: () {
                    //           //  initState();

                    //           print(videoReplyChosen);
                    //           setState(() {
                    //             textReplyChosen = false;
                    //             videoReplyChosen = true;
                    //           });
                    //         },
                    //         focusColor: UniversalVariables.gold2,
                    //         // borderSide: BorderSide.solid,
                    //         child: Text(
                    //             "\$ ${widget.receiver.answerPrice2} VIDEO REPLY",
                    //             style: videoReplyChosen
                    //                 ? TextStyles.replyTypeStyle
                    //                 : TextStyles.replyTypeSelectedStyle),
                    //       ),

                    //       // Container(
                    //       //   height: 42,
                    //       //   margin: EdgeInsets.only(left: 3),
                    //       //   decoration: replyTypeBox,
                    //       //   child: Row(
                    //       //     mainAxisAlignment: MainAxisAlignment.center,
                    //       //     children: <Widget>[
                    //       //       SizedBox(width: 10),
                    //       //       Container(
                    //       //           margin: EdgeInsets.all(5),
                    //       //           child: Text(
                    //       //             "\$ ${widget.receiver.answerPrice1}",
                    //       //             style: TextStyle(
                    //       //               fontSize: 15,
                    //       //               fontWeight: FontWeight.w300,
                    //       //               color: UniversalVariables.grey1,
                    //       //               fontFamily: 'Poppins',
                    //       //             ),
                    //       //           )),

                    //       //           Container(
                    //       //             height:42,
                    //       //           decoration: replyTypeBox2,
                    //       //           padding: EdgeInsets.only(left: 5,top:5,bottom:5,right:5),
                    //       //           child: Center(
                    //       //             child: Text(
                    //       //               "TEXT REPLY",
                    //       //               style: TextStyle(
                    //       //                 fontSize: 15,
                    //       //                 fontWeight: FontWeight.w300,
                    //       //                 color: UniversalVariables.blackColor,
                    //       //                 fontFamily: 'LeagueSpartan',
                    //       //               ),
                    //       //             ),
                    //       //           )),

                    //       //     ],
                    //       //   ),
                    //       // ),

                    //       // Container(
                    //       //   height: 42,
                    //       //   margin: EdgeInsets.only(left: 3),
                    //       //   decoration: replyTypeBox,
                    //       //   child: Row(
                    //       //     mainAxisAlignment: MainAxisAlignment.center,
                    //       //     children: <Widget>[
                    //       //       SizedBox(width: 10),
                    //       //       Container(
                    //       //           margin: EdgeInsets.all(5),
                    //       //           child: Text(
                    //       //             "\$ ${widget.receiver.answerPrice2}",
                    //       //             style: TextStyle(
                    //       //               fontSize: 15,
                    //       //               fontWeight: FontWeight.w300,
                    //       //               color: UniversalVariables.grey1,
                    //       //               fontFamily: 'Poppins',
                    //       //             ),
                    //       //           )),

                    //       //           Container(
                    //       //             height:42,
                    //       //           decoration: replyTypeBox2,
                    //       //           padding: EdgeInsets.only(left: 5,top:5,bottom:5,right:5),
                    //       //           child: Center(
                    //       //             child: Text(
                    //       //               "VIDEO REPLY",
                    //       //               style: TextStyle(
                    //       //                 fontSize: 15,
                    //       //                 fontWeight: FontWeight.w300,
                    //       //                 color: UniversalVariables.blackColor,
                    //       //                 fontFamily: 'LeagueSpartan',
                    //       //               ),
                    //       //             ),
                    //       //           )),

                    //       //     ],
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                  ],
                )),
          )

          // CupertinoPopupSurface(
          //  isSurfacePainted: true,
          //   child: SafeArea(
          //               child: Container(
          //       width:  MediaQuery.of(context).size.width,
          //       height:  50,
          //         child: Column(
          //       children: <Widget>[
          //         Text("Choose reply type", style: TextStyles.paymentTypeStyle),
          //         Padding(
          //           padding: const EdgeInsets.all(15.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             mainAxisSize: MainAxisSize.max,
          //             children: <Widget>[

          //             OutlineButton(
          //                       onPressed: (){
          //                       Navigator.pop(context);
          //                       },
          //                       focusColor: UniversalVariables.standardWhite,
          //                      // borderSide: BorderSide.solid,
          //                       child: Text("\$ ${widget.receiver.answerPrice1} TEXT REPLY", style:TextStyles.replyTypeStyle),
          //                     ),

          //             OutlineButton(
          //                       onPressed: (){

          //                       },
          //                       focusColor: UniversalVariables.standardWhite,
          //                      // borderSide: BorderSide.solid,
          //                       child: Text("\$ ${widget.receiver.answerPrice2} VIDEO REPLY", style:TextStyles.replyTypeStyle),
          //                     ),

          //             // Container(
          //             //   height: 42,
          //             //   margin: EdgeInsets.only(left: 3),
          //             //   decoration: replyTypeBox,
          //             //   child: Row(
          //             //     mainAxisAlignment: MainAxisAlignment.center,
          //             //     children: <Widget>[
          //             //       SizedBox(width: 10),
          //             //       Container(
          //             //           margin: EdgeInsets.all(5),
          //             //           child: Text(
          //             //             "\$ ${widget.receiver.answerPrice1}",
          //             //             style: TextStyle(
          //             //               fontSize: 15,
          //             //               fontWeight: FontWeight.w300,
          //             //               color: UniversalVariables.grey1,
          //             //               fontFamily: 'Poppins',
          //             //             ),
          //             //           )),

          //             //           Container(
          //             //             height:42,
          //             //           decoration: replyTypeBox2,
          //             //           padding: EdgeInsets.only(left: 5,top:5,bottom:5,right:5),
          //             //           child: Center(
          //             //             child: Text(
          //             //               "TEXT REPLY",
          //             //               style: TextStyle(
          //             //                 fontSize: 15,
          //             //                 fontWeight: FontWeight.w300,
          //             //                 color: UniversalVariables.blackColor,
          //             //                 fontFamily: 'LeagueSpartan',
          //             //               ),
          //             //             ),
          //             //           )),

          //             //     ],
          //             //   ),
          //             // ),

          //             // Container(
          //             //   height: 42,
          //             //   margin: EdgeInsets.only(left: 3),
          //             //   decoration: replyTypeBox,
          //             //   child: Row(
          //             //     mainAxisAlignment: MainAxisAlignment.center,
          //             //     children: <Widget>[
          //             //       SizedBox(width: 10),
          //             //       Container(
          //             //           margin: EdgeInsets.all(5),
          //             //           child: Text(
          //             //             "\$ ${widget.receiver.answerPrice2}",
          //             //             style: TextStyle(
          //             //               fontSize: 15,
          //             //               fontWeight: FontWeight.w300,
          //             //               color: UniversalVariables.grey1,
          //             //               fontFamily: 'Poppins',
          //             //             ),
          //             //           )),

          //             //           Container(
          //             //             height:42,
          //             //           decoration: replyTypeBox2,
          //             //           padding: EdgeInsets.only(left: 5,top:5,bottom:5,right:5),
          //             //           child: Center(
          //             //             child: Text(
          //             //               "VIDEO REPLY",
          //             //               style: TextStyle(
          //             //                 fontSize: 15,
          //             //                 fontWeight: FontWeight.w300,
          //             //                 color: UniversalVariables.blackColor,
          //             //                 fontFamily: 'LeagueSpartan',
          //             //               ),
          //             //             ),
          //             //           )),

          //             //     ],
          //             //   ),
          //             // ),

          //             ],
          //           ),
          //         ),
          //       ],
          //     )),
          //   ),
          //   // actions: <Widget>[
          //   //   CupertinoDialogAction(
          //   //       textStyle: TextStyle(color: Colors.red),
          //   //       isDefaultAction: true,
          //   //       onPressed: () {
          //   //         Navigator.pop(context);
          //   //       },
          //   //       child: Text("Cancel")),
          //   //   CupertinoDialogAction(
          //   //       textStyle: TextStyle(color: Colors.green),
          //   //       isDefaultAction: false,
          //   //       onPressed: () async {
          //   //         sendMessage();
          //   //         Navigator.pop(context);
          //   //       },
          //   //       child: Text("Send")),
          //   // ],
          // ),
          );
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
                // suffixIcon: GestureDetector(
                //   onTap: () {},
                //   child: Icon(Icons.face),
                // ),
              ),
            ),
          ),
          // isWriting
          //     ? Container()
          //     : Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 10),
          //         child: Icon(Icons.record_voice_over),
          //       ),
          // isWriting
          //     ? Container()
          //     : Container(
          //         margin: EdgeInsets.only(left: 5, right: 5),
          //         child: GestureDetector(
          //           child: Icon(
          //             Icons.camera_alt,
          //             color: UniversalVariables.grey2,
          //           ),
          //           onTap: () => pickImage(source: ImageSource.camera),
          //         ),
          //       ),
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
        //comes here
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
        // IconButton(
        //   color: UniversalVariables.grey2,
        //   icon: Icon(
        //     Icons.phone,
        //   ),
        //   onPressed: () {},
        // )
      ],
    );
  }
}

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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
