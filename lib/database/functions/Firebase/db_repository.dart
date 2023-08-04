// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/functions/Firebase/db_manager.dart';
import 'package:trivo/database/models/fb_model.dart';
import 'dart:async';

//Repository class
class Repository {
  //for fetch all data
  Future<List<DestinationFB>> fetchalldatas() async {
    final collection = FirebaseFirestore.instance.collection('Destinations');
    final querysnapshot = await collection.get();
    return querysnapshot.docs.map((doc) {
      final data = doc.data();
      return DestinationFB(
          id: doc.id,
          placeName: data['name'],
          location: data['link'],
          district: data['district'],
          category: data['catogory'],
          description: data['description'],
          reachthere: data['moreInFo'],
          longitude: data['lon'],
          latitude: data['lat'],
          image: List<String>.from(data['image']));
    }).toList();
  }

  void getalldatas() async {
    final destinations = await fetchalldatas();
    dataListFromFirebase.value = destinations;
  }

//for all destination datas to firebase
  Future<void> fbaddDestination(DestinationFB destination) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference destinationList = firestore.collection('Destinations');

    DocumentReference newplaces = destinationList.doc();
    List<String> urlS =
        await imageConverter(destination.image, destination.placeName);

    Map<String, dynamic> placeDetails = {
      'name': destination.placeName,
      'link': destination.location,
      'description': destination.description,
      'moreInFo': destination.reachthere,
      'district': destination.district,
      'catogory': destination.category,
      'id': newplaces.id,
      'image': urlS,
      'lat':destination.latitude,
      'lon':destination.longitude
    };
    await newplaces.set(placeDetails);
    print('submited');
  }

//add image
  Future<List<String>> imageConverter(
      List<String> imagesstring, String name) async {
    List<String> convertedURL = [];

    for (var img in imagesstring) {
      String i = imgName(img);
      Reference toRoot = FirebaseStorage.instance.ref();
      Reference toDirectory = toRoot.child('destinationIMAGES');
      Reference toImage = toDirectory.child('$name/$i');

      try {
        await toImage.putFile(File(img));
        final url = await toImage.getDownloadURL();
        convertedURL.add(url);
      } catch (e) {
        print(e);
      }
    }
    return convertedURL;
  }

  String imgName(String img) {
    int j = 0;
    for (int i = img.length - 1; i >= 0; i--) {
      if (img[i] == '/') {
        j = i;
        break;
      }
    }
    return img.substring(j);
  }

  //delete destinations from firebase_database
  Future deleteDoc(String id) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference destinations = fireStore.collection('Destinations');
    try {
      await destinations.doc(id).delete();
    } catch (e) {
      return false;
    }
    return true;
  }

  //edit destnations from firebase_database
  Future editData(DestinationFB destination) async {
    try {
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      final dest = fireStore.collection('Destinations').doc(destination.id);
      await dest.update({
        'name': destination.placeName,
        'catogory': destination.category,
        'description': destination.description,
        'link': destination.location,
        'district': destination.district,
        'moreInFo': destination.reachthere,
        'lat':destination.latitude,
      'lon':destination.longitude

      });
    } catch (e) {
      print('$e');
      return false;
    }
    return true;
  }

//filter places by districts or categories and both district and categories
  Future<List<DestinationFB>> filteredDestinations(
      {List<String>? selectedDistricts,
      List<String>? selectedCategories}) async {
    selectedDistricts ??= [];
    selectedCategories ??= [];
    final collections = FirebaseFirestore.instance.collection('Destinations');
    Query query = collections;

//for showing all datas default
    if (selectedDistricts.isEmpty && selectedCategories.isEmpty) {
      final querysnapshot = await query.get();
      return querysnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return DestinationFB(
          id: data['id'],
            placeName: data['name'],
            location: data['link'],
            district: data['district'],
            category: data['catogory'],
            description: data['description'],
            reachthere: data['moreInFo'],
              longitude: data['lon'],
          latitude: data['lat'],
            image: List<String>.from(data['image']));
      }).toList();
    }

//filter by only categories
    else if (selectedCategories.isNotEmpty && selectedDistricts.isEmpty) {
      final querysnapshot =
          await query.where('catogory', whereIn: selectedCategories).get();
      return querysnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return DestinationFB(
          id: data['id'],
            placeName: data['name'],
            location: data['link'],
            district: data['district'],
            category: data['catogory'],
            description: data['description'],
            reachthere: data['moreInFo'],
              longitude: data['lon'],
          latitude: data['lat'],
            image: List<String>.from(data['image']));
      }).toList();
    }
//filter by only districts
    else if (selectedCategories.isEmpty && selectedDistricts.isNotEmpty) {
      final querysnapshot =
          await query.where('district', whereIn: selectedDistricts).get();
      return querysnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return DestinationFB(
          id: data['id'],
            placeName: data['name'],
            location: data['link'],
            district: data['district'],
            category: data['catogory'],
            description: data['description'],
            reachthere: data['moreInFo'],
              longitude: data['lon'],
          latitude: data['lat'],
            image: List<String>.from(data['image']));
      }).toList();
    }
//filter by both districts and categoties
    else {
      final querysnapshot =
          await query.where('district', whereIn: selectedDistricts).get();

      final filteredDatas = querysnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final allcategory = data['catogory'] as String;
        return selectedCategories!.contains(allcategory);
      }).toList();
      return filteredDatas.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return DestinationFB(
          id: data['id'],
            placeName: data['name'],
            location: data['link'],
            district: data['district'],
            category: data['catogory'], 
            description: data['description'],
            reachthere: data['moreInFo'],
              longitude: data['lon'],
          latitude: data['lat'],
            image: List<String>.from(data['image']));
      }).toList();
    }
  }

// random
  Future<List<DestinationFB>> fetchRandomDestinations() async {
    Query query = collectionReference;

    // Get the total number of documents in the collection
    final QuerySnapshot snapshot = await query.get();
    final totalDocuments = snapshot.size;

    if (totalDocuments == 0) {
      // Handle the case when the collection is empty
      return [];
    }

    // Generate random indices to get six random documents
    final random = Random();
    final randomIndices = <int>{};
    while (randomIndices.length < 4) {
      randomIndices.add(random.nextInt(totalDocuments));
    }

    // Fetch exactly 4 random destinations
    final randomDocs = 
        randomIndices.map((index) => snapshot.docs[index]).toList();

    return randomDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return DestinationFB(
          placeName: data['name'],
          location: data['link'],
          district: data['district'],
          category: data['catogory'],
          description: data['description'],
          reachthere: data['moreInFo'],
            longitude: data['lon'],
          latitude: data['lat'],
          image: List<String>.from(data['image']));
    }).toList();
  }

  //random list 
  Future<void> getRandomDestinations() async {
    final List<DestinationFB> randomDestinations =
        await fetchRandomDestinations();
    random.value = randomDestinations;
  }
}

List<String>? selectedDistricts = [];
List<String>? selectedCategories = [];
getFiltered() async {
  List<DestinationFB> filteredDestinations = await Repository()
      .filteredDestinations(
          selectedCategories: selectedCategories,
          selectedDistricts: selectedDistricts);
  filtered.value = [...filteredDestinations];

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  filtered.notifyListeners();
}

//for notify filtered
final ValueNotifier<List<DestinationFB>> filtered =
    ValueNotifier<List<DestinationFB>>([]);
final ValueNotifier<List<DestinationFB>> random =
    ValueNotifier<List<DestinationFB>>([]);

final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Destinations');
