import 'package:intl/intl.dart';

class Discount {
  int id;
  String discountName;
  String discountType;
  int discountValue;
  DateTime startDate;
  DateTime endDate;
  bool isActive;

  Discount({
    required this.id,
    required this.discountName,
    required this.discountType,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory Discount.fromMap(Map<String, dynamic> json) {
    return Discount(
      id: json['id'],
      discountName: json['discountName'],
      discountType: json['discountType'],
      discountValue: json['discountValue'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'discountName': discountName,
      'discountType': discountType,
      'discountValue': discountValue,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate),
      'endDate': DateFormat('yyyy-MM-dd').format(endDate),
      'isActive': isActive,
    };
  }
}