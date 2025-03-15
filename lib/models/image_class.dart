import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImageClass {
  int Id;
  String ImageClassCode;
  String ImageClassName;
  ImageClass({
    required this.Id,
    required this.ImageClassCode,
    required this.ImageClassName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'ImageClassCode': ImageClassCode,
      'ImageClassName': ImageClassName,
    };
  }

  factory ImageClass.fromMap(Map<String, dynamic> map) {
    return ImageClass(
      Id: map['Id'] as int,
      ImageClassCode: map['ImageClassCode'] as String,
      ImageClassName: map['ImageClassName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageClass.fromJson(String source) =>
      ImageClass.fromMap(json.decode(source) as Map<String, dynamic>);
}
