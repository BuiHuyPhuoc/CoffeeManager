// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee_house/models/order_topping.dart';
import 'package:coffee_house/models/product_size.dart';

class OrderDetail {
  int id;
  int productSizeId;
  int orderId;
  String? note;
  int quantity;
  ProductSize productSize;
  List<OrderTopping> orderToppings;

  OrderDetail({
    required this.id,
    required this.productSizeId,
    required this.orderId,
    this.note,
    required this.quantity,
    required this.productSize,
    required this.orderToppings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productSizeId': productSizeId,
      'orderId': orderId,
      'note': note,
      'quantity': quantity,
      'productSize': productSize.toMap(),
      'orderToppings': orderToppings.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'] as int,
      productSizeId: map['productSizeId'] as int,
      orderId: map['orderId'] as int,
      note: map['note'] != null ? map['note'] as String : null,
      quantity: map['quantity'] as int,
      productSize: ProductSize.fromMap(map['productSize'] as Map<String,dynamic>),
      orderToppings: List<OrderTopping>.from((map['orderToppings'] as List<dynamic>).map<OrderTopping>((x) => OrderTopping.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) => OrderDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}