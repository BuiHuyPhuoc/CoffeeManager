import 'package:coffee_house/models/image_class.dart';

class Image {
  int? id;
  String imageName;
  String imageType;
  int imageClassId;
  String firebaseImage;
  ImageClass? imageClass;

  Image({
    this.id,
    required this.imageName,
    required this.imageType,
    required this.imageClassId,
    required this.firebaseImage,
    this.imageClass,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: (json['id'] != null) ? json['id'] as int : null,
      imageName: json['imageName'],
      imageType: json['imageType'],
      imageClassId: json['imageClassId'],
      firebaseImage: json['firebaseImage'],
      imageClass: (json['imageClass'] != null) ? ImageClass.fromJson(json['imageClass']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageName': imageName,
      'imageType': imageType,
      'imageClassId': imageClassId,
      'firebaseImage': firebaseImage,
      'imageClass': imageClass?.toJson(),
    };
  }
}
