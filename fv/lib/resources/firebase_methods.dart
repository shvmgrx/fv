import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/txtOrder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/message.dart';
import 'package:fv/models/user.dart';
import 'package:fv/provider/image_upload_provider.dart';
import 'package:fv/utils/utilities.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;
  static final Firestore _firestore = Firestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  // static final CollectionReference _buyerCollection =
  //     _firestore.collection(BUYER_ORDER_COLLECTION);

  // static final CollectionReference _sellerCollection =
  //     _firestore.collection(SELLER_ORDER_COLLECTION);

  final CollectionReference _messageCollection =
      _firestore.collection(MESSAGES_COLLECTION);

  StorageReference _storageReference;

  //user class
  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<User> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.document(currentUser.uid).get();

    return User.fromMap(documentSnapshot.data);
  }

  Future<User> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _userCollection.document(id).get();
      return User.fromMap(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: _signInAuthentication.accessToken,
        idToken: _signInAuthentication.idToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser user = result.user;

    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<DocumentSnapshot> fetchLoggedUser(FirebaseUser currentUser) async {
    user = User(
      uid: currentUser.uid,
    );
    DocumentSnapshot documentSnapshot = await firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .get();

    return documentSnapshot;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.displayName);

    user = User(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoUrl,
        username: username);

    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> updateProfiletoDb(
      FirebaseUser currentUser,
      String name,
      String email,
      String username,
      String status,
      int state,
      String profilePhoto,
      int answerPrice1,
      int answerPrice2,
      int answerPrice3,
      int answerDuration,
      String bio,
      bool isInfCert,
      int maxQuestionCharcount,
      int rating,
      String category,
      int reviews,
      int infWorth,
      int infSent,
      int infReceived,
      bool isInfluencer,
      String hashtags,
      Map timeSlots) async {
    user = User(
        uid: currentUser.uid,
        name: name,
        email: email,
        username: username,
        status: status,
        state: state,
        profilePhoto: profilePhoto,
        answerPrice1: answerPrice1,
        answerPrice2: answerPrice2,
        answerPrice3: answerPrice3,
        answerDuration: answerDuration,
        bio: bio,
        isInfCert: isInfCert,
        maxQuestionCharcount: maxQuestionCharcount,
        rating: rating,
        category: category,
        reviews: reviews,
        infWorth: infWorth,
        infSent: infSent,
        infReceived: infReceived,
        isInfluencer: isInfluencer,
        hashtags: hashtags,
        timeSlots: timeSlots);

    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .updateData(user.toMap(user));
  }

  //void setImageMsg(String url, String receiverId, String senderId) async {
  void setProfilePhoto(String url, FirebaseUser currentUser) async {
    print("Url received for setting:");

    user = User(uid: currentUser.uid, profilePhoto: url);
    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .updateData(user.toMap(user));
  }

  Future<void> signOut() async {
    print("signed out start");
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<User>> fetchAllUsers(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

  Future<List<String>> fetchFvCodes() async {
    List<String> fzCodes = List<String>();

    QuerySnapshot querySnapshot =
        await firestore.collection(FZCODES_COLLECTION).getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      fzCodes.add(querySnapshot.documents[i].documentID);
    }

    return fzCodes;
  }

  Future<List<User>> fetchAllInfluencers(FirebaseUser currentUser) async {
    List<User> allList = List<User>();

    QuerySnapshot querySnapshot = await firestore
        .collection(USERS_COLLECTION)
        .where("isInfCert", isEqualTo: true)
        .getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        allList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return allList;
  }

  Future<List<Order>> fetchBuyerOrders(String loggedUserId) async {
    List<Order> orderList = List<Order>();

    var querySnapshot = await firestore
        .collection(ORDER_COLLECTION)
        .orderBy("slot_time")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].data["buyer_id"] == loggedUserId) {
        orderList.add(Order.fromMap(querySnapshot.documents[i].data));
      }
    }
    return orderList;
  }

  Future<List<TxtOrder>> fetchBuyerTxtOrders(String loggedUserId) async {
    List<TxtOrder> txtOrderList = List<TxtOrder>();

    var querySnapshot = await firestore
        .collection(TXT_ORDER_COLLECTION)
        .orderBy("bought_on")
        .getDocuments();

    print("fghjytfgvbh: $querySnapshot");

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].data["buyer_id"] == loggedUserId) {
        txtOrderList.add(TxtOrder.fromMap(querySnapshot.documents[i].data));
      }
    }
    return txtOrderList;
  }

  Future<List<Order>> fetchSellerOrders(String loggedUserId) async {
    List<Order> iOrderList = List<Order>();

    var querySnapshot = await firestore
        .collection(ORDER_COLLECTION)
        .orderBy("slot_time")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].data["seller_id"] == loggedUserId) {
        iOrderList.add(Order.fromMap(querySnapshot.documents[i].data));
      }
    }
    return iOrderList;
  }

  Future<List<User>> fetchFeaturedInfluencers(FirebaseUser currentUser) async {
    List<User> featuredList = List<User>();

    QuerySnapshot querySnapshot = await firestore
        .collection(USERS_COLLECTION)
        // .where("category", isEqualTo: "1")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        featuredList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return featuredList;
  }

  Future<List<User>> fetchTrendingInfluencers(FirebaseUser currentUser) async {
    List<User> trendingList = List<User>();

    QuerySnapshot querySnapshot = await firestore
        .collection(USERS_COLLECTION)
        .where("category", isEqualTo: "2")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        trendingList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return trendingList;
  }

  Future<List<User>> fetchNewInfluencers(FirebaseUser currentUser) async {
    List<User> newList = List<User>();

    QuerySnapshot querySnapshot = await firestore
        .collection(USERS_COLLECTION)
        .where("category", isEqualTo: "3")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        newList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return newList;
  }

  Future<List<User>> fetchMostActiveInfluencers(
      FirebaseUser currentUser) async {
    List<User> mostActiveList = List<User>();

    QuerySnapshot querySnapshot = await firestore
        .collection(USERS_COLLECTION)
        .where("category", isEqualTo: "4")
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        mostActiveList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return mostActiveList;
  }

  Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await firestore
        .collection("messages")
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await firestore
        .collection("messages")
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    // mention try catch later on
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');

      StorageUploadTask storageUploadTask =
          _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

      return url;
    } catch (e) {
      return null;
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

//setProfilePlaceholder

  void uploadImage(File image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdle();

    setImageMsg(url, receiverId, senderId);
  }

  void changeProfilePhoto(File image, ImageUploadProvider imageUploadProvider,
      FirebaseUser currentUser) async {
    // Set some loading value to db and show it to user
    //imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    // imageUploadProvider.setToIdle();
    print("Url sending for setting:");

    setProfilePhoto(url, currentUser);
  }

  Stream<QuerySnapshot> fetchContacts({String userId}) => _userCollection
      .document(userId)
      .collection(CONTACTS_COLLECTION)
      .snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      _messageCollection
          .document(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();
}
