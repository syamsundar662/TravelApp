//  import 'dart:io';

class DestinationFB {
  String placeName;
  String location;
  String district;
  String category;
  String description;
  String? id;
  String reachthere;
  List<String> image;

  DestinationFB({
    required this.placeName,
    required this.location,
    required this.district,
    required this.category,
    required this.description,
    required this.reachthere,
    this.id,
    required this.image,
  });
}

