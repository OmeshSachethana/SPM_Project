import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/Admin/Add_Vision_test/add_vision.dart';
import 'package:spm/pages/Admin/Update_vision_test/update_vision.dart';
import '../Delete_vision_test/delete_vision_test.dart';

class VImageGrid extends StatelessWidget {
  final List<String> imageUrls;

  const VImageGrid(this.imageUrls, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Test Images'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditVision(),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              // Show a confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Image Operation?'),
                    content:
                        const Text('Are you sure you want to Edit this image?'),
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
                              builder: (context) => UpdateVision(
                                selected_url: imageUrls[index],),
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
                              builder: (context) => DeleteImagePage(
                                imageUrl: imageUrls[index],),
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
            child: Card(
              margin: const EdgeInsets.all(20.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.network(
                    imageUrls[index],
                    height: 200, // Customize the image height
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Test :  ${index + 1}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
