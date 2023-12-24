import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_app/Dashboard/dashboard.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? imageFile; //contains image that user selects, currently empty

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    // create mget from camera
                    _getFromCamera();
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.purple),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // get from gallery
                    _getFromGallery();
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.purple),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  } //end of shawImageDialog

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('Null Image from gallery');
    }

    _cropImage(pickedFile!.path);

    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path); //set path of chosen image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MentorX',
            style: TextStyle(fontSize: 20, color: Colors.blueAccent),
          ),
          flexibleSpace: Container(), //Container
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black45,
            ),
          ), //IconButton
        ),
        body: Center(
          child: Container(
            color: Colors.white, //black color *
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: GestureDetector(
                onTap: () {
                  //Create ShowImageDialog
                  _showImageDialog();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    //To show camera icon
                    //width: size.width * 0.04,
                    //height: size.width * 0.04,
                    width: size.width * 0.24,
                    height: size.width * 0.24,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: imageFile != null
                          ? Image.file(
                              //else display image selected by user
                              imageFile!,
                              fit: BoxFit.fill,
                            )
                          : const Icon(
                              Icons
                                  .camera_enhance, //if imageFile is null show camera
                              color: Colors.cyan,
                              size: 30,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
