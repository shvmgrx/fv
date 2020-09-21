// import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeTest {
  List tranz;

  IncomeTest({this.tranz});

  Map toMap() {
    var data = Map<String, dynamic>();
    data['tranz'] = this.tranz;
    return data;
  }

  IncomeTest.fromMap(Map<String, dynamic> mapData) {
    this.tranz = mapData["tranz"];
  }
}
