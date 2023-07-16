import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId:1)
class Destination extends HiveObject {
  @HiveField(0)
  String placeName;

  @HiveField(1)
  String location;

  @HiveField(2)
  String district;

  @HiveField(3)
  String category;

  @HiveField(4)
  String description;

  @HiveField(5)
  int? id;

  @HiveField(6)
  String reachthere;

  @HiveField(7)
  List<String> image;

  Destination(
    {
    required this.placeName,
    required this.location,
    required this.district,
    required this.category,
    required this.description,
    required this.reachthere,
    this.id,
    required this.image
  });

}

// import 'dart:io';

// class Destination {
//   String placeName;

//   String location;

//   String district;

//   String category;

//   String description;

//   int? id;

//   String reachthere;

//   List<File> image;

//   Destination(
//       {required this.placeName,
//       required this.location,
//       required this.district,
//       required this.category,
//       required this.description,
//       required this.reachthere,
//       this.id,
//       required this.image});
// }
