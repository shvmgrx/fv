import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/contact.dart';
import 'package:fv/models/message.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/user.dart';

class OrderMethods {
  static final Firestore _firestore = Firestore.instance;

  final CollectionReference _messageCollection =_firestore.collection(MESSAGES_COLLECTION);

  final CollectionReference _userCollection = _firestore.collection(USERS_COLLECTION);

  final CollectionReference _timeSlotCollection =_firestore.collection(TIMESLOT_COLLECTION);

    Future<void> addOrderToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToOrders(senderId: message.senderId, receiverId: message.receiverId);

    return await _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }


    addToOrders({String buyerId, String sellerId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToBuyerContacts(buyerId, sellerId, currentTime);
    await addToSellerContacts(buyerId, sellerId, currentTime);
  }


}
