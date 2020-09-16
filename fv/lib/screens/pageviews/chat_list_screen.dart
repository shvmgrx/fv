import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/contact.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/user.dart';
import 'package:fv/onboarding/text_styles.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/resources/auth_methods.dart';
import 'package:fv/resources/chat_methods.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/resources/order_methods.dart';
import 'package:fv/screens/callscreens/pickup/pickup_layout.dart';
import 'package:fv/screens/chatscreens/widgets/cached_image.dart';
import 'package:fv/screens/pageviews/widgets/contact_view.dart';
import 'package:fv/screens/pageviews/widgets/online_dot_indicator.dart';
// import 'package:fv/screens/pageviews/widgets/new_chat_button.dart';
import 'package:fv/screens/pageviews/widgets/quiet_box.dart';
import 'package:fv/screens/pageviews/widgets/user_circle.dart';
import 'package:fv/utils/call_utilities.dart';
import 'package:fv/utils/permissions.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/cust_app_bar.dart';
import 'package:fv/widgets/custom_tile.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool chatPressed = true;
  bool videoChatPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorContactKey =
  //  new GlobalKey<RefreshIndicatorState>();

  static final Firestore _firestore = Firestore.instance;
  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  //  Future<Null> refreshContacts() {

  //    Stream<QuerySnapshot> fetchContacts({String userId}) => _userCollection
  // .document(userId)
  // .collection(CONTACTS_COLLECTION)
  // .snapshots();
  // return null;
  // }

  CustAppBar customAppBar(BuildContext context) {
    return CustAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: UniversalVariables.blackColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: UserCircle(),
      centerTitle: true,
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.search,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, "/search_screen");
        //   },
        // ),
        // IconButton(
        //   icon: Icon(
        //     Icons.more_vert,
        //     color: UniversalVariables.grey2,
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.backgroundGrey,
        appBar: customAppBar(context),
        // floatingActionButton: NewChatButton(),
        body: chatPressed ? ChatListContainer() : VideoChatListContainer(),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: UniversalVariables.standardWhite,
          elevation: 9.0,
          clipBehavior: Clip.antiAlias,
          notchMargin: 6.0,
          child: Container(
            height: 60,
            child: Ink(
              decoration: BoxDecoration(),
              child: CupertinoTabBar(
                backgroundColor: Colors.transparent,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, "/home_screen");
                            setState(() {
                              chatPressed = true;
                              videoChatPressed = false;
                            });
                          },
                          child: Icon(Icons.textsms,
                              color: chatPressed
                                  ? UniversalVariables.grey1
                                  : UniversalVariables.grey2))),
                  BottomNavigationBarItem(
                      icon: GestureDetector(
                          onTap: () {
                            //  Navigator.pushNamed(context, "/profile_screen");
                            setState(() {
                              chatPressed = false;
                              videoChatPressed = true;
                            });
                          },
                          child: Icon(Icons.videocam,
                              color: videoChatPressed
                                  ? UniversalVariables.grey1
                                  : UniversalVariables.grey2))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;
              if (docList.isEmpty) {
                return QuietBox();
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);

                  return Dismissible(
                    key: ValueKey(docList[index].data),
                    direction: DismissDirection.endToStart,
                    child: ContactView(contact),
                    onDismissed: (direction) {
                      _chatMethods.deleteContacts(
                          userId: userProvider.getUser.uid,
                          contactId: contact.uid);
                    },
                    background: Container(
                        color: UniversalVariables.redBack,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(CupertinoIcons.clear,
                                  size: 40, color: UniversalVariables.white2),
                            ),
                          ],
                        )),
                  );
                },
              );
            }
          }),
    );
  }
}

class VideoChatListContainer extends StatefulWidget {
  @override
  _VideoChatListContainerState createState() => _VideoChatListContainerState();
}

class _VideoChatListContainerState extends State<VideoChatListContainer> {
  final OrderMethods _orderMethods = OrderMethods();
  FirebaseRepository _repository = FirebaseRepository();
  static final Firestore _firestore = Firestore.instance;

  User currentBuyer;
  User callGetter;

  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  List<Order> ordersList;

  Future<QuerySnapshot> Qs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    String dateMaker(Timestamp theSetDate) {
      if (theSetDate != null) {
        var temp = theSetDate.toDate();
        var formatter = new DateFormat('MMMM d, HH:mm');
        String convertedDate = formatter.format(temp);
        return convertedDate;
      } else {
        var nullDate = "nullDate";
        return nullDate;
      }
    }

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _orderMethods.fetchOrders(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //make a for loop and only add the snapshot to List<doc snapshot> when suitable and todays date
              for (int i = 0; i < snapshot.data.documents.length; i++) {
                print("edfgr: ${snapshot.data.documents[i]['seller_name']}");
              }
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox();
              }

              // Future<void> getUserDetails(String buyerId) async {
              //   DocumentSnapshot documentSnapshot =
              //       await _userCollection.document(buyerId).get();

              //   setState(() {
              //     currentBuyer = User.fromMap(documentSnapshot.data);
              //   });
              // }

              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  bool loggedUserIsInfluencer =
                      userProvider.getUser.isInfluencer;

                  Order buyerOrder = Order.fromMap(docList[index].data);

                  return buyerOrder != null
                      ? CustomTile(
                          mini: false,
                          onTap: () => {},
                          title: loggedUserIsInfluencer
                              ? Text(
                                  buyerOrder.buyerName,
                                  style: TextStyles.chatListProfileName,
                                )
                              : Text(
                                  buyerOrder.sellerName,
                                  style: TextStyles.chatListProfileName,
                                ),
                          subtitle: Text(
                            "${dateMaker(buyerOrder.slotTime)}",
                            //style: TextStyles.chatListProfileName,
                          ),
                          leading: Container(
                            constraints:
                                BoxConstraints(maxHeight: 60, maxWidth: 60),
                            child: Stack(
                              children: <Widget>[
                                loggedUserIsInfluencer
                                    ? CachedImage(
                                        buyerOrder.buyerPhoto,
                                        radius: 80,
                                        isRound: true,
                                      )
                                    : CachedImage(
                                        buyerOrder.sellerPhoto,
                                        radius: 80,
                                        isRound: true,
                                      ),
                                OnlineDotIndicator(
                                  uid: loggedUserIsInfluencer
                                      ? buyerOrder.buyerId
                                      : buyerOrder.sellerId,
                                ),
                              ],
                            ),
                          ),
                          trailing: Visibility(
                              visible: loggedUserIsInfluencer,
                              child: VideoCallUser(currentBuyer)),
                        )
                      : Container();
                },
              );
            }
          }),
    );
  }
}

class VideoCallUser extends StatefulWidget {
  final User callReceiver;

  VideoCallUser(this.callReceiver);

  @override
  _VideoCallUserState createState() => _VideoCallUserState();
}

class _VideoCallUserState extends State<VideoCallUser> {
  FirebaseRepository _repository = FirebaseRepository();
  User sender;
  String _currentUserId;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        color: UniversalVariables.grey2,
        icon: Icon(
          Icons.video_call,
        ),
        onPressed: () async =>
            await Permissions.cameraAndMicrophonePermissionsGranted()
                ? CallUtils.dial(
                    from: sender,
                    to: widget.callReceiver,
                    context: context,
                  )
                : {},
      ),
    );
  }
}
