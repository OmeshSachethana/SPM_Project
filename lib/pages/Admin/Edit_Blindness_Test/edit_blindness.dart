import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/api_services.dart';
import '../Edit_Blindness_Test/Blind_imageGrid.dart';
import '../admin.dart';

class EditBlindness extends StatefulWidget {
  final CameraDescription frontCamera;
  const EditBlindness({Key? key, required this.frontCamera}) : super(key: key);

  @override
  State<EditBlindness> createState() => _EditBlindnessState();
}

class _EditBlindnessState extends State<EditBlindness> {
  final MyApiService apiService = MyApiService();
  late Future<List<String>> imageUrlFuture;
  int currentIndex = 0;
  TextEditingController textAnswerController = TextEditingController();
  File? _selectedImage;
  bool isUploading = false;
  double uploadProgress = 0.0;

  // hard code image values

  @override
  void initState() {
    super.initState();

    imageUrlFuture = apiService.getImageUrlsBlindness();
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
          title: const Text('Create new Blindness Test'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Admin(
                    frontCamera: widget.frontCamera,
                  ),
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
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!)
                      : const Text("Select Image"),
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
                height: 40,
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
                        primary: Colors.green,
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
                height: 60,
                width: 300,
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

                      apiService.uploadBlindnessImageToFirebase(
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
                          apiService.addBlindValueToFirestore(
                              textAnswerController.text);
                          setState(() {
                            textAnswerController.clear();
                            _selectedImage = null;
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
                    //   if(mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageGrid(
                          imageUrls,
                          frontCamera: widget.frontCamera,
                        ),
                      ),
                    );
                  },
                  child: const Text("View All Blindness Test Images"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
