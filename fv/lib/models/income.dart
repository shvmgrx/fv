// import 'package:cloud_firestore/cloud_firestore.dart';

class Income {
  String uid;
  int currency;
  Map income;

  Income({this.uid, this.currency, this.income});

  Map toMap() {
    var data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['currency'] = this.currency;
    data['income'] = this.income;
    return data;
  }

  Income.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.currency = mapData["currency"];
    this.income = mapData["income"];
  }
}
