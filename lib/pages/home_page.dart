import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/visual_fatigue_homePage.dart';

class HomePage extends StatelessWidget {
  final CameraDescription frontCamera;

  HomePage({Key? key, required this.frontCamera}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  //sign out user
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisualFatigueTestPage(
                        frontCamera: frontCamera), // Pass the front camera
                  ),
                );
              },
              child: const Text('Start Visual Fatigue Test'),
            ),
          ],
        ),
      ),
    );
  }
}
