// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  int id;
  String fullName;
  String dateOfBirth;
  String phone;
  bool idRole;
  String email;
  bool isValid;

  Customer({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.phone,
    required this.idRole,
    required this.email,
    required this.isValid,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'phone': phone,
      'idRole': idRole,
      'email': email,
      'isValid': isValid,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      phone: map['phone'] as String,
      idRole: map['idRole'] as bool,
      email: map['email'] as String,
      isValid: map['isValid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}
