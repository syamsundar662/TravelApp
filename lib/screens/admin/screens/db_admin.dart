import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivo/database/models/fb_model.dart';

//Repo
class Repository {
   Future<void> fb_addDestination(DestinationFB destination) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference destinationList = firestore.collection('Destinations');

    DocumentReference newplaces = destinationList.doc();
    List<String> url_s = await imageConverter(destination.image,destination.placeName);

    Map<String, dynamic> placeDetails = {
      'name': destination.placeName,
      'link': destination.location,
      'description': destination.description,
      'moreInFo': destination.reachthere,
      'district': destination.district,
      'catogory': destination.category,
      'id': newplaces.id,
      'image':url_s
    };
    await newplaces.set(placeDetails);
    print('submited');
  }
//add image 

  Future<List<String>> imageConverter(
      List<XFile> imagesstring, String name) async {
    List<String> convertedURL = [];

    for (var img in imagesstring) {
      String i= imgName(img.path);
      Reference toRoot = FirebaseStorage.instance.ref();
      Reference toDirectory = toRoot.child('destinationIMAGES');
      Reference toImage = toDirectory.child('$name/$i');

      try {
        await toImage.putFile(File(img.path));
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


  //delete
  Future<bool> deleteDoc(DestinationFB destination) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference destinations = fireStore.collection('Destinations');
    try {
      await destinations.doc(destination.id).delete();
    } catch (e) { 
      return false;
    }
    return true;
  }
  //edit
   Future<bool> editData(DestinationFB destination) async {
    try {
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      final dest = fireStore.collection('destinations').doc(destination.id);
      await dest.update({
        'name': destination.placeName,
        'catogory': destination.category,
        'description': destination.description,
        'location': destination.location,
        // 'image': destination.image,
        'district': destination.district,
      });
    } catch (e) {
      print('---------------------------$e-----------------------');
      return false;
    }
    return true;
  }
}
