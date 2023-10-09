import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/Admin/Edit_Blindness_Test/Blind_imageGrid.dart';

import '../../../services/api_services.dart';

class UpdateBlind extends StatefulWidget {
  final CameraDescription frontCamera;
  String selected_url;
  UpdateBlind({super.key,required this.selected_url,required this.frontCamera}) ;

  @override
  State<UpdateBlind> createState() => _UpdateBlindState();
}

class _UpdateBlindState extends State<UpdateBlind> {
  TextEditingController textAnswerController = TextEditingController();
  final MyApiService apiService = MyApiService();
  late Future<List<String>>imgUrls ;

  Future<void> _showUpdateConfirmationDialog(context) async {
    List<String> imageUrl =  await apiService.getImageUrlsBlindness();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update ok!'),
          content: const Text('Successfully Updated...'),
          actions: <Widget>[

            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(

                    builder: (context) => ImageGrid(imageUrl,frontCamera: widget.frontCamera,),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    imgUrls = apiService.getImageUrlsVision() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Update Image value'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.selected_url), // Display the image
              // const Text('Are you sure you want to delete this image?'),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width:200,
                child: TextFormField(
                  controller: textAnswerController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your Answer',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  List<String> imageUrl =  await apiService.getImageUrlsBlindness();
                  print("image::= $imageUrl");
                  apiService.updateBlindImageValueInFirebase(imageUrl,widget.selected_url,textAnswerController.text) ;
                  _showUpdateConfirmationDialog(context);
                },
                child: const Text('Update value'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
