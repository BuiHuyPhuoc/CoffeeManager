import 'dart:convert';
import 'package:intl/intl.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserAccount {
  int id;
  String fullName;
  DateTime dateOfBirth;
  String phone;
  String email;
  bool idRole;

  UserAccount({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.phone,
    required this.email,
    required this.idRole,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'dateOfBirth': DateFormat('yyyy-MM-dd').format(dateOfBirth),
      'phone': phone,
      'email': email,
      'idRole': idRole,
    };
  }

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      dateOfBirth: DateTime.parse(map['dateOfBirth'] as String),
      phone: map['phone'] as String,
      email: map['email'] as String,
      idRole: map['idRole'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccount.fromJson(String source) => UserAccount.fromMap(json.decode(source) as Map<String, dynamic>);
}
