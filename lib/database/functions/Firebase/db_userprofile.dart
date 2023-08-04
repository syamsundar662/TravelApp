import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileFirebase {
  ProfileFirebase._();
  // Singleton instance variable
  static final ProfileFirebase _instance = ProfileFirebase._();

  // Factory constructor to return the singleton instance
  factory ProfileFirebase() => _instance;

  String? imageURLdb;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? image;
  Map<String, dynamic>? querySnapshotData;

  Future<String?> uploadImageAndGetUrl(File imageFile) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_profile_images')
          .child(fileName);
      await ref.putFile(imageFile);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // print('Error uploading profile image: $e');
      return null;
    }
  }

  saveProfile(image) async {
    if (image == null) {
      return;
    }

    String? imageUrl = await uploadImageAndGetUrl(image!);
    if (imageUrl != null) {
      String userId = _auth.currentUser?.uid ?? ''; // Get the user's ID
      await FirebaseFirestore.instance
          .collection('userprofile')
          .doc(userId)
          .set({
        'username':
            userId, // You can set the username to the user's ID or fetch it from the user profile
        'imageUrl': imageUrl,
      });
      // profileImageProvider.setImageUrl(imageUrl);
      print('Profile image uploaded and URL stored in Firebase!');
      print(imageUrl);
    } else if (imageUrl == null) {
    } else {
      print('Error uploading profile image.');
    }
  }

  Future<void> getuserimage() async {
    String userId = _auth.currentUser?.uid ?? '';
    final userDatas = FirebaseFirestore.instance.collection('userprofile');
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await userDatas.doc(userId).get();
    if (docSnapshot.exists) {
      // Check if the document exists before accessing its data
      querySnapshotData = docSnapshot.data();
      imageURLdb = querySnapshotData!['imageUrl'] as String;
    } else {
      print('User document does not exist.');
    }
  }
}
