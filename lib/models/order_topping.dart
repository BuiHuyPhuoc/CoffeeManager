// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee_house/models/topping.dart';

class OrderTopping {
  int toppingId;
  int quantity;
  int orderDetailId;
  Topping topping;

  OrderTopping({
    required this.toppingId,
    required this.quantity,
    required this.orderDetailId,
    required this.topping,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toppingId': toppingId,
      'quantity': quantity,
      'orderDetailId': orderDetailId,
      'topping': topping.toMap(),
    };
  }

  factory OrderTopping.fromMap(Map<String, dynamic> map) {
    return OrderTopping(
      toppingId: map['toppingId'] as int,
      quantity: map['quantity'] as int,
      orderDetailId: map['orderDetailId'] as int,
      topping: Topping.fromMap(map['topping'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderTopping.fromJson(String source) => OrderTopping.fromMap(json.decode(source) as Map<String, dynamic>);
}
