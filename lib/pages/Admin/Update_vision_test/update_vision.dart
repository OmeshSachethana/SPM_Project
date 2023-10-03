import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spm/pages/Admin/Add_Vision_test/Vision_imageGrid.dart';

import '../../../services/api_services.dart';

class UpdateVision extends StatefulWidget {
  final CameraDescription frontCamera;
  String selected_url;
  UpdateVision({super.key,required this.selected_url,required this.frontCamera}) ;

  @override
  State<UpdateVision> createState() => _UpdateVisionState();
}

class _UpdateVisionState extends State<UpdateVision> {
  TextEditingController textAnswerController = TextEditingController();
  final MyApiService apiService = MyApiService();
  late Future<List<String>>imgUrls ;


  Future<void> _showUpdateConfirmationDialog(context) async {
    List<String> imageUrl =  await apiService.getImageUrlsVision();
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

                    builder: (context) => VImageGrid(imageUrl,frontCamera:widget.frontCamera,),
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
                  List<String> imageUrl =  await apiService.getImageUrlsVision();
                 // print("image::= $imageUrl");
                  apiService.updateVisionImageValueInFirebase(imageUrl,widget.selected_url,textAnswerController.text) ;
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
