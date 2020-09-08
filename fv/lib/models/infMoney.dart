import 'package:cloud_firestore/cloud_firestore.dart';

class InfMoney {
  String uid;
  String buyerId;
  String buyerName;
  String sellerId;
  Timestamp boughtOn;
  int price;
  int currency;

  InfMoney(
      {this.uid,
      this.buyerId,
      this.buyerName,
      this.sellerId,
      this.boughtOn,
      this.price,
      this.currency});

  Map toMap() {
    var data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['buyer_id'] = this.buyerId;
    data['buyer_name'] = this.buyerName;
    data['seller_id'] = this.sellerId;
    data['bought_on'] = this.boughtOn;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }

  InfMoney.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.buyerId = mapData['buyer_id'];
    this.buyerName = mapData['buyer_name'];
    this.sellerId = mapData['seller_id'];
    this.boughtOn = mapData["bought_on"];
    this.price = mapData["price"];
    this.currency = mapData["currency"];
  }
}
