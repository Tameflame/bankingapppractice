import 'package:flutter/material.dart';
import '../../iconHandler.dart';

class BankTransaction {
  // String transactionId;
  int transactionId;
  DateTime date;
  // String icon;
  IconData icon;
  String price;
  String name;

  BankTransaction.fromMap(Map<String, dynamic> data) {
    transactionId = int.parse(data["id"]);
    date = DateTime.parse(data["date"]);
    icon = getIcon(data["icon"]);
    price = data["price"];
    name = data["name"];
  }
}
