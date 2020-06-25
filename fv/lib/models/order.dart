import 'package:cloud_firestore/cloud_firestore.dart';

class Order  {
  String uid;

  bool isBought;
  String buyerId;
  String sellerId;
  Timestamp boughtOn;
  DateTime slotTime;
  int slotDuration;
  int price;

  Order({
    this.uid,

    this.isBought,
    this.buyerId,
    this.sellerId,
    this.boughtOn,
    this.slotTime,
    this.slotDuration,
    this.price

  });

  Map toMap() {
    
    var data = Map<String, dynamic>();
    data['seller_id'] = this.uid;

    data['is_bought'] = this.isBought;
    data['buyer_id'] = this.buyerId;
    data['seller_id'] = this.sellerId;
    data['bought_on'] = this.boughtOn;
    data['slot_time'] = this.slotTime;
    data['slot_duration'] = this.slotDuration;
    data['price'] = this.price;
    return data;
  }

  Order.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['seller_id'];

    this.isBought = mapData["is_bought"];
    this.buyerId = mapData['buyer_id'];
    this.sellerId = mapData['seller_id'];
    this.boughtOn = mapData["bought_on"];
    this.slotTime = mapData["slot_time"];
    this.slotDuration = mapData["slot_duration"];
    this.price = mapData["price"];
  }
}