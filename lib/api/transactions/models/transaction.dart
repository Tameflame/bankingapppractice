import 'package:flutter/material.dart';
import '../../iconHandler.dart';

class BankTransaction {
  DateTime date;
  IconData icon;
  String price;
  String name;

  BankTransaction.fromMap(Map<String, dynamic> data) {
    date = DateTime.parse(data["date"]);
    icon = getIcon(data["icon"]);
    price = data["price"];
    name = data["name"];
  }
}
