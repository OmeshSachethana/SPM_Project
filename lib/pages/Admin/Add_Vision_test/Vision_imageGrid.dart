import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/Admin/Add_Vision_test/add_vision.dart';
import 'package:spm/pages/Admin/Update_vision_test/update_vision.dart';
import '../Delete_vision_test/delete_vision_test.dart';

class VImageGrid extends StatelessWidget {
  final CameraDescription frontCamera;
  final List<String> imageUrls;


  const VImageGrid(this.imageUrls, {super.key,required this.frontCamera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vision Images'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  EditVision(frontCamera: frontCamera,),
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
              // Show a confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Image Operaion?'),
                    content: const Text('Are you sure you want to Edit this image?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(

                              builder: (context) => UpdateVision(selected_url:imageUrls[index],frontCamera: frontCamera,),
                            ),
                          );

                        },
                        child: const Text('Update'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                          // Call the onDelete function with the index to delete the image
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(

                              builder: (context) => DeleteImagePage(imageUrl:imageUrls[index],frontCamera: frontCamera,),
                            ),
                          );

                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Column(
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
