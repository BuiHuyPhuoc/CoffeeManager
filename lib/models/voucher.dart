// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Voucher {
  int id;
  String code;
  String description;
  String discountType;
  int discountValue;
  String startDate;
  String? endDate;
  int usageLimit;
  int? limitPerUser;
  bool isActive;
  int minOrderValue;

  Voucher({
    required this.id,
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.startDate,
    this.endDate,
    required this.usageLimit,
    required this.limitPerUser,
    required this.isActive,
    required this.minOrderValue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'description': description,
      'discountType': discountType,
      'discountValue': discountValue,
      'startDate': startDate,
      'endDate': endDate,
      'usageLimit': usageLimit,
      'limitPerUser': limitPerUser,
      'isActive': isActive,
      'minOrderValue': minOrderValue,
    };
  }

  factory Voucher.fromMap(Map<String, dynamic> map) {
    return Voucher(
      id: map['id'] as int,
      code: map['code'] as String,
      description: map['description'] as String,
      discountType: map['discountType'] as String,
      discountValue: map['discountValue'] as int,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] != null ? map['endDate'] as String : null,
      usageLimit: map['usageLimit'] as int,
      limitPerUser: map['limitPerUser'] != null ? map['limitPerUser'] as int : null,
      isActive: map['isActive'] as bool,
      minOrderValue: map['minOrderValue'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Voucher.fromJson(String source) => Voucher.fromMap(json.decode(source) as Map<String, dynamic>);
}
