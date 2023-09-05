import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/visual_fatigue_homePage.dart';

class HomePage extends StatelessWidget {
  final CameraDescription frontCamera;

  HomePage({Key? key, required this.frontCamera}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  // Sign out user
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
        title: Text('Your App Title'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Add your logic for when Item 1 is tapped
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add your logic for when Item 2 is tapped
              },
            ),
            // Add more ListTile items as needed
          ],
        ),
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
                      frontCamera: frontCamera,
                    ),
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
