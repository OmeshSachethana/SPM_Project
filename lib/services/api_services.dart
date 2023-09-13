import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyApiService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // get image

  Future<List<String>> getImageUrlsBlindness() async {
    List<String> imageUrls = [];
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      // Replace 'images' with the path to your folder in Firebase Storage
      ListResult result = await storage.ref('blindness').list();

      for (Reference ref in result.items) {
        String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }

      return imageUrls;
    } catch (e) {
      print('Error retrieving image URLs: $e');
      return [];
    }
  }

  Future<List<String>> getImageUrlsVision() async {
    List<String> imageUrls = [];
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      // Replace 'images' with the path to your folder in Firebase Storage
      ListResult result = await storage.ref('vision').list();

      for (Reference ref in result.items) {
        String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }

      return imageUrls;
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error retrieving image URLs: $e');
      return [];
    }
  }
}
