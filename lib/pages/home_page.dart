import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/visual_fatigue_homePage.dart';

import 'profile_page.dart';
import 'questionnaire_screen.dart';

class HomePage extends StatelessWidget {
  final CameraDescription frontCamera;

  HomePage({Key? key, required this.frontCamera}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  // Sign out user
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToProfilePage(BuildContext context) {
    // Pop the menu drawer
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToQuizPage(BuildContext context) {
    // Pop the menu drawer
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionnaireScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: signUserOut,
        //     icon: const Icon(Icons.logout),
        //   )
        // ],
        backgroundColor: const Color.fromARGB(255, 28, 122, 47),
        title: const Text(
          'H O M E  P A G E',
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 149, 156, 162),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 120, // Adjust the height as needed
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 28, 122, 47),
              ),
              child: const Center(
                child: Text(
                  'M E N U',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: const Text('P R O F I L E',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your logic for when Item 1 is tapped
                goToProfilePage(context);
              },
            ),
            ListTile(
              title: const Text('V I S U A L   F A T I G U E   T E S T',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisualFatigueTestPage(
                      frontCamera: frontCamera,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('E Y E  G A M E S',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your logic for when Item 1 is tapped
              },
            ),
            ListTile(
              title:
                  const Text('Q U I Z', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your logic for when Item 1 is tapped
                goToQuizPage(context);
              },
            ),
            ListTile(
              title: const Text('C O L O U R   B L I N D N E S S   T E S T',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your logic for when Item 2 is tapped
              },
            ),
            ListTile(
              title: const Text(
                  'C O N T R A S T  S E N S I T I V I T Y   T E S T',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your logic for when Item 1 is tapped
              },
            ),
            const SizedBox(height: 180),
            ListTile(
              title: const Text('L O G O U T',
                  style: TextStyle(color: Colors.white)),
              onTap: signUserOut,
            ),
            // Add more ListTile items as needed
          ],
        ),
      ),
      body: Center(child: Text('Welcome ${user.email}')),
    );
  }
}
