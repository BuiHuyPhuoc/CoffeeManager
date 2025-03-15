// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee_house/models/product.dart';

class ProductSize {
  int id;
  int productId;
  String size;
  int price;
  bool isValid;
  Product product;

  ProductSize({
    required this.id,
    required this.productId,
    required this.size,
    required this.price,
    required this.isValid,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'size': size,
      'price': price,
      'isValid': isValid,
      'product': product.toMap(),
    };
  }

  factory ProductSize.fromMap(Map<String, dynamic> map) {
    return ProductSize(
      id: map['id'] as int,
      productId: map['productId'] as int,
      size: map['size'] as String,
      price: map['price'] as int,
      isValid: map['isValid'] as bool,
      product: Product.fromMap(map['product'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSize.fromJson(String source) => ProductSize.fromMap(json.decode(source) as Map<String, dynamic>);
}
