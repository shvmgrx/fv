import 'package:cloud_firestore/cloud_firestore.dart';

class Order  {
  String uid;
  Timestamp addedOn;
  bool isBought;
  String buyerId;
  Timestamp boughtOn;
  DateTime ts;
  int duration;
  int price;

  Order({
    this.uid,
    this.addedOn,
    this.isBought,
    this.buyerId,
    this.boughtOn,
    this.ts,
    this.duration,
    this.price

  });

  Map toMap(Order order) {
    var data = Map<String, dynamic>();
    data['seller_id'] = order.uid;
    data['added_on'] = order.addedOn;
    data['is_bought'] = order.isBought;
    data['buyer_id'] = order.buyerId;
    data['bought_on'] = order.boughtOn;
    data['ts'] = order.ts;
    data['duration'] = order.duration;
    data['price'] = order.price;
    return data;
  }

  Order.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['seller_id'];
    this.addedOn = mapData["added_on"];
    this.isBought = mapData["is_bought"];
    this.buyerId = mapData['buyer_id'];
    this.boughtOn = mapData["bought_on"];
    this.ts = mapData["ts"];
    this.duration = mapData["duration"];
    this.price = mapData["price"];

  }
}