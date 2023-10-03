import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/home_page.dart';
import '../Admin/custom_button.dart';
import '../Admin/Edit_Blindness_Test/edit_blindness.dart';
import '../Admin/add_Vision_test/add_vision.dart';

class Admin extends StatelessWidget {
  final CameraDescription frontCamera;
  const Admin({Key? key, required this.frontCamera}) : super(key: key);

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
                  builder: (context) => HomePage(frontCamera: frontCamera),
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
              CustomButton(
                imageUrl: 'lib/images/eye_logoblid.png',
                buttonName: 'edit Vision',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditVision(
                                frontCamera: frontCamera,
                              )));
                },
              ),
              const SizedBox(
                height: 30,
              ),

              // CustomButton(
              //   imageUrl: 'assets/eye_logo.png',
              //   buttonName: 'Vision Problem Detection',
              //   onPressed: () {
              //
              //     Navigator.push(context, MaterialPageRoute(builder: (_) => const Vision()  ));
              //
              //   },
              // ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                imageUrl: 'lib/images/blind.jpg',
                buttonName: 'Edit Blindness ',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditBlindness(
                                frontCamera: frontCamera,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
