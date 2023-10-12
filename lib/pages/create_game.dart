import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:spm/pages/game_list.dart';


class CreateGame extends StatefulWidget {

  final String name;
  final String description;
  final String imageURL;
  final String gameURL;
  final String id;
  

  const CreateGame(
    {this.name = '', this.description = '', this.imageURL = '', this.gameURL = '', this.id = '' }
  );

  @override
  State<CreateGame> createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageurlController = TextEditingController();
  TextEditingController gameurlController = TextEditingController();
  bool showProgressIndicator = false;


  String imageUrl = '';

  @override
  void initState() {
    nameController.text = widget.name;
    descriptionController.text = widget.description;
    imageurlController.text = widget.imageURL;
    gameurlController.text = widget.gameURL;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    imageurlController.dispose();
    gameurlController.dispose();
    super.dispose();
  }
  
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 28, 122, 47),
      centerTitle: true,
      title: Text(
        'Add a new game',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
    ),
    body: Container(
      color: Colors.green[100],
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20, bottom: 200),
    
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Card(
                    child: Container(
                      width: 350,
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(13),
                          child: Container(
                            height: 220,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.imageURL),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: IconButton(onPressed: () async{
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                    print('${file?.path}');
    
                    if(file == null) return;
    
                    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    
                    Reference referenceRoot=FirebaseStorage.instance.ref();
                    Reference referenceDirImages=referenceRoot.child('game_images');
                    Reference referanceImageToUpload = referenceDirImages.child(uniqueFileName);
    
                    try{
                      await referanceImageToUpload.putFile(File(file!.path));
    
                      imageUrl = await referanceImageToUpload.getDownloadURL();
                    }catch(error){
    
                    } 
                  }, icon: Icon(Icons.camera_alt)),
                bottom: 100,
                left: 160
                ),
              ],
            ),
    
                
                
            
            Text(
              'Name *',
              style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 16),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description & Instruction *',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Game Link *',
              style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 16),
            ),
            TextField(
              controller: gameurlController,
              decoration: InputDecoration(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                      height: 60,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {});
                          if(nameController.text.isEmpty ||
                            descriptionController.text.isEmpty||
                            gameurlController.text.isEmpty ||
                            imageUrl.isEmpty) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'All the fields are Required !!!',
                                );
                            }else {
    
                              final dUser = FirebaseFirestore.instance
                                .collection('games')
                                .doc(widget.id.isNotEmpty ? widget.id : null);
    
                              String docId = '';
                              if(widget.id.isNotEmpty) {
                                docId = widget.id;
                              }else { 
                                docId = dUser.id;
                              }
                              final jsonData = {
                                'name': nameController.text,
                                'description': descriptionController.text,
                                'gameURL': gameurlController.text,
                                'imageURL': imageUrl,
                                'id': docId,
                                'clicks':0
                              };
                              showProgressIndicator = true;
                              if(widget.id.isEmpty) {
    
                                await dUser.set(jsonData).then((value) {
                                  nameController.text = '';
                                  descriptionController.text = '';
                                  gameurlController.text = '';
                                  imageUrl = '';
                                  showProgressIndicator = false;
                                  setState(() {});
                                });
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Game Added Successfully!',
                                );
    
                              } else {
    
                                await dUser.update(jsonData).then((value) {
                                  nameController.text = '';
                                  descriptionController.text = '';
                                  gameurlController.text = '';
                                  imageUrl = '';
                                  showProgressIndicator = false;
                                  setState(() {});
                              });
    
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Game Details Updated Successfully!',
                              );
                            }
                          }
                        },         
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        color: Color.fromARGB(255, 28, 122, 47),
                        child: showProgressIndicator
                              ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                                ),
                      ),
                    )
            
          ],
    
        ),
      ),
    ),
  );
  }
}

