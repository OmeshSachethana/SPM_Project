import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> editField(String field) async {
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // Cancel button
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          // Save button
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          )
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  Future<void> deleteProfile() async {
    // final bool confirmDelete = await showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     backgroundColor: Colors.grey[900],
    //     title: const Text(
    //       "Delete Profile",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     content: const Text(
    //       "Are you sure you want to delete your profile?",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     actions: [
    //       // Cancel button
    //       TextButton(
    //         child: const Text(
    //           'Cancel',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         onPressed: () => Navigator.pop(context, false),
    //       ),
    //       // Delete button
    //       TextButton(
    //         child: const Text(
    //           'Delete',
    //           style: TextStyle(color: Colors.red),
    //         ),
    //         onPressed: () => Navigator.pop(context, true),
    //       )
    //     ],
    //   ),
    // );

    // if (confirmDelete == true) {
    //   // Delete the user's profile and sign out
    //   await usersCollection.doc(currentUser.email).delete();
    //   await currentUser.delete();
    //   await FirebaseAuth.instance.signOut();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
        actions: [
          // Add a "Delete Profile" button to the app bar
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteProfile,
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email!)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Details',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                // Username
                MyTextBox(
                  text: userData['username'],
                  sectionName: 'username',
                  onPressed: () => editField('username'),
                ),
                // Age
                MyTextBox(
                  text: userData['age'],
                  sectionName: 'age',
                  onPressed: () => editField('age'),
                ),
                // Phone number
                MyTextBox(
                  text: userData['contactNumber'],
                  sectionName: 'contactNumber',
                  onPressed: () => editField('contactNumber'),
                ),
                // Address
                MyTextBox(
                  text: userData['address'],
                  sectionName: 'address',
                  onPressed: () => editField('address'),
                ),
                // City
                MyTextBox(
                  text: userData['city'],
                  sectionName: 'city',
                  onPressed: () => editField('city'),
                ),
                const SizedBox(height: 50),
                // //user posts
                // Padding(
                //   padding: const EdgeInsets.only(left: 25.0),
                //   child: Text(
                //     'My Posts',
                //     style: TextStyle(color: Colors.grey[600]),
                //   ),
                // ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
