// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderStatus {
  String statusCode;
  String statusName;
  int index;

  OrderStatus({
    required this.statusCode,
    required this.statusName,
    required this.index,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'statusName': statusName,
      'index': index,
    };
  }

  factory OrderStatus.fromMap(Map<String, dynamic> map) {
    return OrderStatus(
      statusCode: map['statusCode'] as String,
      statusName: map['statusName'] as String,
      index: map['index'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatus.fromJson(String source) => OrderStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}
