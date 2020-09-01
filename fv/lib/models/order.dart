import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String uid;
  bool isBought;
  String buyerId;
  String buyerName;
  String buyerPhoto;
  String sellerId;
  Timestamp boughtOn;
  Timestamp slotTime;
  int slotDuration;
  int price;
  int currency;

  Order(
      {this.uid,
      this.isBought,
      this.buyerId,
      this.buyerName,
      this.buyerPhoto,
      this.sellerId,
      this.boughtOn,
      this.slotTime,
      this.slotDuration,
      this.price,
      this.currency});

  Map toMap() {
    var data = Map<String, dynamic>();
    data['uid'] = this.uid;

    data['is_bought'] = this.isBought;
    data['buyer_id'] = this.buyerId;
    data['buyer_name'] = this.buyerName;
    data['buyer_photo'] = this.buyerPhoto;
    data['seller_id'] = this.sellerId;
    data['bought_on'] = this.boughtOn;
    data['slot_time'] = this.slotTime;
    data['slot_duration'] = this.slotDuration;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }

  Order.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];

    this.isBought = mapData["is_bought"];
    this.buyerId = mapData['buyer_id'];
    this.buyerName = mapData['buyer_name'];
    this.buyerPhoto = mapData['buyer_photo'];
    this.sellerId = mapData['seller_id'];
    this.boughtOn = mapData["bought_on"];
    this.slotTime = mapData["slot_time"];
    this.slotDuration = mapData["slot_duration"];
    this.price = mapData["price"];
    this.currency = mapData["currency"];
  }
}
