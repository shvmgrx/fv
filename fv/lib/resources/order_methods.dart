import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fv/constants/strings.dart';
import 'package:fv/models/contact.dart';
import 'package:fv/models/message.dart';
import 'package:fv/models/order.dart';
import 'package:fv/models/user.dart';

class OrderMethods {
  static final Firestore _firestore = Firestore.instance;

    Future<void> addOrderToDb(Order order) async {
    var map = order.toMap();

    //sender = buyer
    //receiver = seller

    _firestore
        .collection(ORDER_COLLECTION)
        .document(order.uid)
        .setData(map);
  }


}
