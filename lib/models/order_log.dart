// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee_house/models/order_status.dart';
import 'package:intl/date_time_patterns.dart';

class OrderLog {
  String statusCode;
  int orderId;
  DateTime timeLog;
  OrderStatus statusCodeNavigation;

  OrderLog({
    required this.statusCode,
    required this.orderId,
    required this.timeLog,
    required this.statusCodeNavigation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'orderId': orderId,
      'timeLog': timeLog,
      'statusCodeNavigation': statusCodeNavigation,
    };
  }

  factory OrderLog.fromMap(Map<String, dynamic> map) {
    return OrderLog(
      statusCode: map['statusCode'] as String,
      orderId: map['orderId'] as int,
      timeLog: DateTime.parse(map['timeLog'] as String),
      statusCodeNavigation: OrderStatus.fromMap(map['statusCodeNavigation'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderLog.fromJson(String source) => OrderLog.fromMap(json.decode(source) as Map<String, dynamic>);
}
