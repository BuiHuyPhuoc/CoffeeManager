// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee_house/models/discount.dart';
import 'image.dart' as Image;

class Product {
  int id;
  String productName;
  String description;
  int categoryId;
  bool isValid;
  String description2;
  String material;
  Discount? discount;
  Image.Image imageDefaultNavigation;

  Product({
    required this.id,
    required this.productName,
    required this.description,
    required this.categoryId,
    required this.isValid,
    required this.description2,
    required this.material,
    required this.imageDefaultNavigation,
    this.discount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'description': description,
      'categoryId': categoryId,
      'isValid': isValid,
      'description2': description2,
      'material': material,
      'discount': discount,
      'image': imageDefaultNavigation,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      productName: map['productName'] as String,
      description: map['description'] as String,
      categoryId: map['categoryId'] as int,
      isValid: map['isValid'] as bool,
      description2: map['description2'] as String,
      material: map['material'] as String,
      discount:
          (map['discount'] != null) ? Discount.fromMap(map['discount']) : null,
      imageDefaultNavigation: Image.Image.fromJson(map['imageDefaultNavigation'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
