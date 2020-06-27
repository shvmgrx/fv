import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/contact.dart';
import 'package:fv/models/user.dart';
import 'package:fv/provider/user_provider.dart';
import 'package:fv/resources/chat_methods.dart';
import 'package:fv/resources/firebase_repository.dart';
import 'package:fv/resources/order_methods.dart';
import 'package:fv/screens/callscreens/pickup/pickup_layout.dart';
import 'package:fv/screens/pageviews/widgets/contact_view.dart';
// import 'package:fv/screens/pageviews/widgets/new_chat_button.dart';
import 'package:fv/screens/pageviews/widgets/quiet_box.dart';
import 'package:fv/screens/pageviews/widgets/user_circle.dart';
import 'package:fv/utils/universal_variables.dart';
import 'package:fv/widgets/cust_app_bar.dart';
import 'package:provider/provider.dart';

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

                  return ContactView(contact);
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

List<User> buyerList;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((FirebaseUser user) {
        _orderMethods.fetchForSellers(user).then((List<User> list) {
        setState(() {
          buyerList = list;
        });
      });
     });
  }
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () => {
          print(buyerList.length)
          },
          child: Text("videocalls"),
        ),
      ),

      // child: StreamBuilder<QuerySnapshot>(

      //     stream: _orderMethods.fetchSellerOrders(
      //       userId: userProvider.getUser.uid,
      //     ),
      //     builder: (context, snapshot) {

      //       print(_orderMethods.fetchSellerOrders(
      //       userId: userProvider.getUser.uid,
      //     ));

      //       if (snapshot.hasData) {
      //         var docList = snapshot.data.documents;
      //         print(docList);
      //         if (docList.isEmpty) {
      //           return QuietBox();
      //         }

      //         // return ListView.builder(
      //         //   padding: EdgeInsets.all(10),
      //         //   itemCount: docList.length,
      //         //   itemBuilder: (context, index) {
      //         //     Contact contact = Contact.fromMap(docList[index].data);

      //         //     return ContactView(contact);
      //         //   },
      //         // );
      //       }

      //     }),
    );
  }
}
