class Address {
  int id;
  int customerId;
  String addressNumber;
  bool isDefault;
  String ward;
  String district;
  String province;
  String fullName;
  String phoneNumber;
  bool isValid;

  Address({
    required this.id,
    required this.customerId,
    required this.addressNumber,
    required this.isDefault,
    required this.ward,
    required this.district,
    required this.province,
    required this.fullName,
    required this.phoneNumber,
    required this.isValid,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      customerId: json['customerId'] as int,
      addressNumber: json['addressNumber'] as String,
      isDefault: json['isDefault'] as bool,
      ward: json['ward'] as String,
      district: json['district'] as String,
      province: json['province'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isValid: json['isValid'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'addressNumber': addressNumber,
      'isDefault': isDefault,
      'ward': ward,
      'district': district,
      'province': province,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'isValid': isValid,
    };
  }
}