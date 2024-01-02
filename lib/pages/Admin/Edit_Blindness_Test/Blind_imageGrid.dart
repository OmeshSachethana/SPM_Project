import 'package:camera/camera.dart';
import 'package:spm/pages/Admin/Edit_Blindness_Test/edit_blindness.dart';
import 'package:spm/pages/Admin/Update_vision_test/update_blind.dart';
import '../Delete_blind_test/delete_blind_test.dart';
import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imageUrls;

  const ImageGrid(this.imageUrls, {Key? key});

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
                builder: (context) => EditBlindness(),
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
                              builder: (context) => UpdateBlind(
                                selected_url: imageUrls[index],
                              ),
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
                              builder: (context) => DeleteBlindImagePage(
                                imageUrl: imageUrls[index],
                              ),
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
            child: Card(
              margin: EdgeInsets.all(15.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.network(
                    imageUrls[index],
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      'Test : ${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
