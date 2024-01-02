import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/api_services.dart';
import '../Add_Vision_test/Vision_imageGrid.dart';
import '../admin.dart';

class EditVision extends StatefulWidget {
  EditVision({Key? key}) : super(key: key);

  @override
  State<EditVision> createState() => _EditVisionState();
}

class _EditVisionState extends State<EditVision> {
  final MyApiService apiService = MyApiService();
  late Future<List<String>> imageUrlFuture;
  int currentIndex = 0;
  TextEditingController textAnswerController = TextEditingController();
  File? _selectedImage;
  bool isUploading = false;
  double uploadProgress = 0.0;

  @override
  void initState() {
    super.initState();

    imageUrlFuture = apiService.getImageUrlsVision();
  }

  Future<void> _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null && returnImage.path != null) {
      setState(() {
        _selectedImage = File(returnImage.path);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create new Vision Test'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Admin(), // Navigate to the edit page after deleting
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 200, // Specify the width of the container
                height: 200, // Specify the height of the container
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Specify the border color
                    width: 2.0, // Specify the border width
                  ),
                ),
                child: Center(
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!) // Display the image if it's selected
                      : const Text(
                          "Test Image"), // Display the text if no image is selected
                ),
              ),
              Center(
                child: Visibility(
                  visible: isUploading,
                  child: LinearProgressIndicator(
                    value: uploadProgress,
                    minHeight: 20,
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: textAnswerController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your Answer',
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(width: 20),

                  SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Background color
                        // Text color
                      ),
                      onPressed: _pickImageFromGallery,
                      child: const Text('Select Image'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                    // Text color
                  ),
                  onPressed: () async {
                    if (textAnswerController.text.isNotEmpty ||
                        _selectedImage != null) {
                      setState(() {
                        isUploading = true;
                        uploadProgress = 0.0;
                      });

                      apiService.uploadVisionImageToFirebase(
                          _selectedImage!, textAnswerController.text,
                          (double progress) {
                        setState(() {
                          uploadProgress = progress;
                        });
                      }).then((bool success) {
                        setState(() {
                          isUploading = false;
                        });
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Create successful!"),
                            ),
                          );

                          apiService.addVisionValueToFirestore(
                              textAnswerController.text);
                          setState(() {
                            _selectedImage = null;
                            textAnswerController.clear();
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Adding failed. Please try again."),
                            ),
                          );
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Please select an image and enter text!"),
                        ),
                      );
                    }
                  },
                  child: const Text("Create New Test"),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                    // Text color
                  ),
                  onPressed: () async {
                    final imageUrls = await imageUrlFuture;
                    //if(mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VImageGrid(
                          imageUrls,
                        ),
                      ),
                    );
                  },
                  child: const Text("View All Vision Test Images"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
