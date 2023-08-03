//  import 'dart:io';

import 'package:flutter/material.dart';

class DestinationFB {
  String placeName;
  String location;
  String district;
  String category;
  String description;
  String? id;
  String reachthere;
  List<String> image;
  String? latitude;
  String? longitude;

  DestinationFB({
    required this.placeName,
    required this.location,
    required this.district,
    required this.category,
    required this.description,
    required this.reachthere,
    this.id,
    required this.image,
    required this.latitude,
    required this.longitude
  });
}

