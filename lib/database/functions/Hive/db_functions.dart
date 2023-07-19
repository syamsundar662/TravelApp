// // ignore_for_file: invalid_use_of_visible_for_testing_member

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:trivo/database/models/data_model.dart';
// // import 'package:trivo/lists/explore1.dart';


// ValueNotifier<List<Destination>>destListNotifier=ValueNotifier([]);

// Future<void>addDestination(Destination value)async{
//   final destinationDB = await Hive.openBox<Destination>('destination_db');
//   final id = await destinationDB.add(value);
//   value.id = id;
//   getAllDestination();
// }
// void getAllDestination()async{
//   final destinationDB=await Hive.openBox<Destination>('destination_db');
//   destListNotifier.value.clear();
//   destListNotifier.value.addAll(destinationDB.values);
//   // ignore: invalid_use_of_protected_member
//   destListNotifier.notifyListeners();
// }

// void deleteplace(Destination destinationmodel)async{
//   destinationmodel.delete();
//   getAllDestination();
// }

//   //  datawanttadd() async{
//   //    final destinationDB = await Hive.openBox<Destination>('destination_db');
//   // if(destinationDB.isEmpty){
//   // for(int i=0;i<6;i++){
//   //   final destination1= Destination(placeName: explore1[i][1], location:  explore1[i][4], district:  explore1[i][2], category:  explore1[i][5], description: explore1[i][3], reachthere: explore1[i][3], image: explore1[i][0]);
//   //   addDestination(destination1);
//   //   print('added');
//   // }}

//   // }