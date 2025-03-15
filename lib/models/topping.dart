// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Topping {
  int id;
  String toppingName;
  int toppingPrice;
  bool isValid;

  Topping({
    required this.id,
    required this.toppingName,
    required this.toppingPrice,
    required this.isValid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'toppingName': toppingName,
      'toppingPrice': toppingPrice,
      'isValid': isValid,
    };
  }

  factory Topping.fromMap(Map<String, dynamic> map) {
    return Topping(
      id: map['id'] as int,
      toppingName: map['toppingName'] as String,
      toppingPrice: map['toppingPrice'] as int,
      isValid: map['isValid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Topping.fromJson(String source) => Topping.fromMap(json.decode(source) as Map<String, dynamic>);
}
