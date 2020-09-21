import 'package:cloud_firestore/cloud_firestore.dart';

class TxtOrder {
  String uid;
  String buyerId;
  String buyerName;
  String buyerPhoto;
  String sellerId;
  String sellerName;
  String sellerPhoto;
  Timestamp boughtOn;
  int price;
  int currency;

  TxtOrder(
      {this.uid,
      this.buyerId,
      this.buyerName,
      this.buyerPhoto,
      this.sellerId,
      this.sellerName,
      this.sellerPhoto,
      this.boughtOn,
      this.price,
      this.currency});

  Map toMap() {
    var data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['buyer_id'] = this.buyerId;
    data['buyer_name'] = this.buyerName;
    data['buyer_photo'] = this.buyerPhoto;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['seller_photo'] = this.sellerPhoto;
    data['bought_on'] = this.boughtOn;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }

  TxtOrder.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.buyerId = mapData['buyer_id'];
    this.buyerName = mapData['buyer_name'];
    this.buyerPhoto = mapData['buyer_photo'];
    this.sellerId = mapData['seller_id'];
    this.sellerName = mapData['seller_name'];
    this.sellerPhoto = mapData['seller_photo'];
    this.boughtOn = mapData["bought_on"];
    this.price = mapData["price"];
    this.currency = mapData["currency"];
  }
}
