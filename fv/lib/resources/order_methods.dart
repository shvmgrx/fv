import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/contact.dart';
import 'package:fv/models/message.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/user.dart';

    //sender = buyer
    //receiver = seller

class OrderMethods {
  static final Firestore _firestore = Firestore.instance;
   static final Firestore firestore = Firestore.instance;

  final CollectionReference _orderCollection = _firestore.collection(ORDER_COLLECTION);
  final CollectionReference _sellerOrderCollection = _firestore.collection(SELLER_ORDER_COLLECTION);
  final CollectionReference _buyerOrderCollection = _firestore.collection(BUYER_ORDER_COLLECTION);

//for faveez use
  Future<void> addOrderToDb(Order order) async {
    var map = order.toMap();
    _firestore.collection(ORDER_COLLECTION).document(order.uid).setData(map);
  }

  Future<void> addOrderToSellerDb(Order order) async {
    var map = order.toMap();
    _firestore.collection(SELLER_ORDER_COLLECTION).document(order.uid).setData(map);
  }

  Future<void> addOrderToBuyerDb(Order order) async {
    var map = order.toMap();
    _firestore.collection(BUYER_ORDER_COLLECTION).document(order.uid).setData(map);
  }

  Stream<QuerySnapshot> fetchSellerOrders({String userId}) => _sellerOrderCollection
      .document(userId)
      .collection(SELLER_ORDER_COLLECTION)
      .snapshots();


 Future<QuerySnapshot> fetchSell() async {
        QuerySnapshot result = await firestore
        .collection(SELLER_ORDER_COLLECTION)
        //.where(EMAIL_FIELD, isEqualTo: user.email)
        .getDocuments();
}

  Future<List<User>> fetchForSellers(user) async {
    List<User> buyerList = List<User>();

    QuerySnapshot querySnapshot = await firestore
        .collection(ORDER_COLLECTION)
        .where("seller_id", isEqualTo: user.uid)
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
   
        buyerList.add(User.fromMap(querySnapshot.documents[i].data));
  
    }
    return buyerList;
  }

}
