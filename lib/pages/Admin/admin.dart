import 'package:flutter/material.dart';
import 'package:spm/pages/home_page.dart';
import '../Admin/custom_button.dart';
import '../Admin/Edit_Blindness_Test/edit_blindness.dart';
import '../Admin/add_Vision_test/add_vision.dart';

class Admin extends StatelessWidget {

  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          title: const Text('Home'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardButton(
                imageUrl: 'lib/images/eye_logoblid.png',
                buttonName: 'Edit Vision',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditVision(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CardButton(
                imageUrl: 'lib/images/blind.jpg',
                buttonName: 'Edit Blindness',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditBlindness(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String imageUrl;
  final String buttonName;
  final VoidCallback onPressed;

  const CardButton({
    required this.imageUrl,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 300,
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageUrl,
                width: 180,
                height: 180,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                buttonName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
