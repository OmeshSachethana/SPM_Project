import 'package:camera/camera.dart';
import 'package:spm/pages/Admin/Edit_Blindness_Test/edit_blindness.dart';
import 'package:spm/pages/Admin/Update_vision_test/update_blind.dart';

import '../Delete_blind_test/delete_blind_test.dart';
import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final CameraDescription frontCamera;
  final List<String> imageUrls;

  const ImageGrid( this.imageUrls, {Key? key,required this.frontCamera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blindness Images'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  EditBlindness(frontCamera: frontCamera,),
              ),
            );
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Image Operation?'),
                    content: const Text('Are you sure you want to Edit this image?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(

                              builder: (context) => UpdateBlind(selected_url:imageUrls[index],frontCamera: frontCamera,),
                            ),
                          );
                        },
                        child: const Text('Update'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(

                              builder: (context) => DeleteBlindImagePage(imageUrl: imageUrls[index],frontCamera: frontCamera,),
                            ),
                          );
                          // Handle delete logic
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable scrolling of ListView
              children: [
                Image.network(imageUrls[index]), // Display the image
                Text('Image ${index + 1}'), // Optional: Display image index or name
              ],
            ),
          );
        },
      ),
    );
  }
}
