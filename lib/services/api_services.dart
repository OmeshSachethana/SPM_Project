import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApiService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<List<dynamic>> getBlindCorrectValuesFromFirestore() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Blindness_values');
      DocumentReference documentReference = collection.doc("values");

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> values = snapshot.get('values') as List<dynamic>;
        print('Values retrieved from Firestore: $values');
        return values;
      } else {
        print('Document does not exist.');
        return [];
      }
    } catch (e) {
      print('Error getting values from Firestore: $e');
      return [];
    }
  }

  Future<void> addBlindValueToFirestore(String newValue) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Blindness_values');
      DocumentReference documentReference = collection.doc("values");

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> existingValues = snapshot.get('values') as List<dynamic>;
        existingValues.add(newValue);

        await documentReference.update({'values': existingValues});
      } else {
        await documentReference.set({
          'values': [newValue]
        });
      }

      print('Value "$newValue" added to Firestore.');
    } catch (e) {
      print('Error adding value to Firestore: $e');
    }
  }

  Future<void> deleteBlindValueFromFirestore(String valueToDelete) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Blindness_values');
      DocumentReference documentReference = collection.doc("values");

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> existingValues = snapshot.get('values') as List<dynamic>;

        existingValues.remove(valueToDelete);

        await documentReference.update({'values': existingValues});

        print('Value "$valueToDelete" deleted from Firestore.');
      } else {
        print('Document "values" not found in Firestore.');
      }
    } catch (e) {
      print('Error deleting value from Firestore: $e');
    }
  }

  Future<void> deleteBlindImageDataFromFirestore(String imageName) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference imageRef = storage.refFromURL(imageName);
      await imageRef.delete();

      print('Image deleted from Firebase Storage: $imageName');
    } catch (e) {
      print("image name::$imageName");
      print('Error deleting image from Storage: $e');
    }
  }

  Future<bool> uploadBlindnessImageToFirebase(
      File imageFile, String name, Function(double) onProgress) async {
    try {
      var storage = FirebaseStorage.instance;

      String fileName =
          'blindness/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final ref = storage.ref(fileName);
      final task = ref.putFile(imageFile);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      });

      await task.whenComplete(() {
        print('Image uploaded to Firebase Storage: $fileName');
      });

      String downloadUrl = await ref.getDownloadURL();
      print('Download URL: $downloadUrl');

      return true;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return false;
    }
  }

  Future<bool> uploadVisionImageToFirebase(
      File imageFile, String name, Function(double) onProgress) async {
    try {
      var storage = FirebaseStorage.instance;

      String fileName = 'vision/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final ref = storage.ref(fileName);
      final task = ref.putFile(imageFile);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      });

      await task.whenComplete(() {
        print('Image uploaded to Firebase Storage: $fileName');
      });

      String downloadUrl = await ref.getDownloadURL();
      print('Download URL: $downloadUrl');

      return true;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return false;
    }
  }

  Future<List<dynamic>> getVisionCorrectValuesFromFirestore() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Vision_values');
      DocumentReference documentReference = collection.doc("values");

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> values = snapshot.get('values') as List<dynamic>;
        print('Values retrieved from Firestore: $values');
        return values;
      } else {
        print('Document does not exist.');
        return [];
      }
    } catch (e) {
      print('Error getting values from Firestore: $e');
      return [];
    }
  }

  Future<void> addVisionValueToFirestore(String newValue) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Vision_values');
      DocumentReference documentReference = collection.doc("values");

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> existingValues = snapshot.get('values') as List<dynamic>;
        existingValues.add(newValue);

        await documentReference.update({'values': existingValues});
      } else {
        await documentReference.set({
          'values': [newValue]
        });
      }

      print('Value "$newValue" added to Firestore.');
    } catch (e) {
      print('Error adding value to Firestore: $e');
    }
  }

  Future<void> deleteVisionValueFromFirestore(String valueToDelete) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Vision_values');
      DocumentReference documentReference = collection.doc("values");

      // Fetch the current document data
      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> existingValues = snapshot.get('values') as List<dynamic>;

        existingValues.remove(valueToDelete);

        await documentReference.update({'values': existingValues});

        print('Value "$valueToDelete" deleted from Firestore.');
      } else {
        print('Document "values" not found in Firestore.');
      }
    } catch (e) {
      print('Error deleting value from Firestore: $e');
    }
  }

  Future<void> UpdateVisionValueInFirestore(
      String oldValue, String newValue) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Vision_values');
      DocumentReference documentReference = collection.doc("values");

      // Fetch the current document data
      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> existingValues = snapshot.get('values') as List<dynamic>;

        existingValues.remove(oldValue);

        existingValues.add(newValue);

        await documentReference.update({'values': existingValues});
        print(
            'Vision value updated in Firestore: Old: $oldValue, New: $newValue');
      } else {
        print('Document "values" does not exist in Firestore.');
      }
    } catch (e) {
      print('Error updating vision value in Firestore: $e');
    }
  }

  Future<void> deleteVisionImageDataFromFirestore(String imageName) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference imageRef = storage.refFromURL(imageName);
      await imageRef.delete();

      print('Image deleted from Firebase Storage: $imageName');
    } catch (e) {
      print("image name::$imageName");
      print('Error deleting image from Storage: $e');
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> saveBlindResultToFirebase(double percentage) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final now = DateTime.now();
        final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

        final resultData = {
          'percentage': percentage,
          'date': formattedDate,
        };

        final userUid = user.uid;

        await FirebaseFirestore.instance
            .collection('Blind')
            .doc(userUid)
            .collection('user_results')
            .add(resultData);

        print('Result saved to Firebase successfully');
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Error saving result: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUserBlindResultsFromFirebase(
      String userId) async {
    try {
      QuerySnapshot resultSnapshot = await FirebaseFirestore.instance
          .collection('Blind')
          .doc(userId)
          .collection('user_results')
          .get();

      List<Map<String, dynamic>> results = [];

      resultSnapshot.docs.forEach((doc) {
        Map<String, dynamic> resultData = {
          'percentage': doc['percentage'],
          'date': doc['date'],
        };
        results.add(resultData);
      });

      return results;
    } catch (e) {
      print('Error getting user results: $e');
      return [];
    }
  }

  Future<void> saveVisionResultToFirebase(double percentage) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final now = DateTime.now();
        final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

        final resultData = {
          'percentage': percentage,
          'date': formattedDate,
        };

        final userUid = user.uid;

        await FirebaseFirestore.instance
            .collection('Vision')
            .doc(userUid)
            .collection('user_results')
            .add(resultData);

        print('Result saved to Firebase successfully');
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Error saving result: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUserVisionResultsFromFirebase(
      String userId) async {
    try {
      QuerySnapshot resultSnapshot = await FirebaseFirestore.instance
          .collection('Vision')
          .doc(userId)
          .collection('user_results')
          .get();

      List<Map<String, dynamic>> results = [];

      resultSnapshot.docs.forEach((doc) {
        Map<String, dynamic> resultData = {
          'percentage': doc['percentage'],
          'date': doc['date'],
        };
        results.add(resultData);
      });

      return results;
    } catch (e) {
      print('Error getting user results: $e');
      return [];
    }
  }

  Future<void> updateBlindImageValueInFirebase(
      List<String> imageUrls, String targetUrl, String newValue) async {
    try {
      int index = imageUrls.indexOf(targetUrl);

      CollectionReference collection =
          FirebaseFirestore.instance.collection('Blindness_values');
      DocumentReference documentReference = collection.doc("values");

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> existingValues = snapshot.get('values') as List<dynamic>;

        if (index >= 0 && index < existingValues.length) {
          existingValues[index] = newValue;

          await documentReference.update({'values': existingValues});

          print('Value at index $index updated to "$newValue" in Firestore.');
        } else {
          print('Invalid index provided.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error updating value in Firestore: $e');
    }
  }

  Future<void> updateVisionImageValueInFirebase(
      List<String> imageUrls, String targetUrl, String newValue) async {
    try {
      int index = imageUrls.indexOf(targetUrl);
      //     print('index $index');
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Vision_values');
      DocumentReference documentReference = collection.doc("values");

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        List<dynamic> existingValues = snapshot.get('values') as List<dynamic>;

        if (index >= 0 && index < existingValues.length) {
          existingValues[index] = newValue;

          await documentReference.update({'values': existingValues});

          print('Value at index $index updated to "$newValue" in Firestore.');
        } else {
          print('Invalid index provided.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error updating value in Firestore: $e');
    }
  }
}
