// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee_house/models/address.dart';
import 'package:coffee_house/models/customer.dart';
import 'package:coffee_house/models/order_detail.dart';
import 'package:coffee_house/models/order_log.dart';
import 'package:coffee_house/models/voucher.dart';

class Order {
  int id;
  int customerId;
  DateTime orderDate;
  int? voucherId;
  int addressId;
  Address address;
  Customer customer;
  List<OrderDetail> orderDetails;
  List<OrderLog> orderLogs;
  Voucher? voucher;

  Order({
    required this.id,
    required this.customerId,
    required this.orderDate,
    required this.voucherId,
    required this.addressId,
    required this.address,
    required this.customer,
    required this.orderDetails,
    required this.orderLogs,
    required this.voucher,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerId': customerId,
      'orderDate': orderDate,
      'voucherId': voucherId,
      'addressId': addressId,
      'address': address.toJson(),
      'customer': customer.toMap(),
      'orderDetails': orderDetails.map((x) => x.toMap()).toList(),
      'orderLogs': orderLogs.map((x) => x.toMap()).toList(),
      'voucher': voucher?.toMap() ?? null,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      customerId: map['customerId'] as int,
      orderDate: DateTime.parse(map['orderDate'] as String),
      voucherId: map['voucherId'] != null ? map['voucherId'] as int : null,
      addressId: map['addressId'] as int,
      address: Address.fromJson(map['address'] as Map<String,dynamic>),
      customer: Customer.fromMap(map['customer'] as Map<String,dynamic>),
      orderDetails: List<OrderDetail>.from((map['orderDetails'] as List<dynamic>).map<OrderDetail>((x) => OrderDetail.fromMap(x as Map<String,dynamic>),),),
      orderLogs: List<OrderLog>.from((map['orderLogs'] as List<dynamic>).map<OrderLog>((x) => OrderLog.fromMap(x as Map<String,dynamic>),),),
      voucher: map['voucher'] != null ? Voucher.fromMap(map['voucher'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
