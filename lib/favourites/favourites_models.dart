import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trivo/database/models/fb_model.dart';

final currentUserId = FirebaseAuth.instance.currentUser!.uid;

class FavoriteModel extends ChangeNotifier {
  List<String> favorites = [];
  ValueNotifier<List<DestinationFB>> favoritesListenable = ValueNotifier([]);

  Future<void> initFavorites(String userId) async {
    final favoritesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    favorites =
        favoritesSnapshot.docs.map((destination) => destination.id).toList();

    final favoriteDestinations = await Future.wait(favorites.map(
      (destinationId) => FirebaseFirestore.instance
          .collection('Destinations')
          .doc(destinationId)
          .get(),
    ));

    final favoriteDestinationData = favoriteDestinations
        .where((snapshot) => snapshot.data() != null) // Filter out null snapshots
        .map((snapshot) {
          final data = snapshot.data() as Map<String, dynamic>;
          return DestinationFB(
            id: snapshot.id, 
            placeName: data['name'],
            district: data['district'],
            category: data['catogory'],
            location: data['link'],
            description: data['description'],
            reachthere: data['moreInFo'],
            image: List<String>.from(data['image']),
          );
        })
        .toList();

    favoritesListenable.value = favoriteDestinationData;
  }

  void addFavorite(String destinationId) {
    if (!favorites.contains(destinationId)) {
      favorites.add(destinationId);
      notifyListeners();
      // Add the favorite to Firebase here using the current user's ID
      if (currentUserId.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('favorites')
            .doc(destinationId)
            .set({'timestamp': FieldValue.serverTimestamp()});
      }
    }
  } 

  void removeFavorite(String destinationId) {
    if (favorites.contains(destinationId)) {
      favorites.remove(destinationId);
      notifyListeners();
      // Remove the favorite from Firebase here using the current user's ID
      if (currentUserId.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('favorites')
            .doc(destinationId)
            .delete();
      }
    }
  }
}
