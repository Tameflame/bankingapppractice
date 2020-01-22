import 'package:flutter/material.dart';

IconData getIcon(String iconString) {
  switch (iconString){
    case "Icons.local_dining":
      return Icons.local_dining;
      break;
    case "Icons.local_cafe":
      return Icons.local_cafe;
      break;
    case "Icons.local_mall":
      return Icons.local_mall;
      break;
    case "Icons.local_airport":
      return Icons.local_airport;
      break;
    case "Icons.computer":
      return Icons.computer;
    case "Icons.movie":
      return Icons.movie;
    case "Icons.card_giftcard":
      return Icons.card_giftcard;
    default:
      return Icons.error;
  }
}
