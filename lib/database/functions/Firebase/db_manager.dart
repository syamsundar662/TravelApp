import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'package:trivo/screens/admin/screens/admin_repo.dart';

ValueNotifier<List<DestinationFB>> dataListFromFirebase = ValueNotifier([]);

class DataManager with ChangeNotifier {
  // Private constructor
  DataManager._() {
    getData();
  }
  // Singleton instance variable
  static final DataManager _instance = DataManager._();

  // Factory constructor to return the singleton instance
  factory DataManager() => _instance;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Repository repo = Repository();
  List<DestinationFB> documentsFromFirebase = [];

  Future getData() async {
    List<Map<String, dynamic>> list = await getAllCollectionDocs();
    if (documentsFromFirebase.isNotEmpty ||
        dataListFromFirebase.value.isNotEmpty) {
      documentsFromFirebase.clear();
    }
    for (var element in list) {
      final docs = modelMaker(element);
      documentsFromFirebase.add(docs);
      dataListFromFirebase.value.add(docs);
    }
  }

  Future<List<Map<String, dynamic>>> getAllCollectionDocs() async {
    List<Map<String, dynamic>> list = [];
    try {
      await fireStore.collection('Destinations').get().then((value) {
        list = value.docs.map((e) => e.data()).toList();
      });
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print('--$e--');
    }
    return list;
  }

  DestinationFB modelMaker(Map<String, dynamic> document) {
    return DestinationFB(
      category: document['catogory'],
      placeName: document['name'],
      description: document['description'],
      location: document['link'],
      district: document['district'],
      image: List<String>.from(document['image']),
      reachthere: document['moreInFo'],
      id: document['id'],
    );
  }

  Future<List<DestinationFB>> fetchalldatas() async {
    final collection = FirebaseFirestore.instance.collection('Destinations');
    final querysnapshot = await collection.get();
    return querysnapshot.docs.map((doc) {
      final data = doc.data();
      return DestinationFB(
          id: doc.id,
          placeName: data['name'],
          location: data['location'],
          district: data['district'],
          category: data['catogory'],
          description: data['description'],
          reachthere: data['moreInFo'],
          image: List<String>.from(data['image']));
    }).toList();
  }

  void getalldatas() async {
    final destinations = await fetchalldatas();
    dataListFromFirebase.value = destinations;
  }
}
