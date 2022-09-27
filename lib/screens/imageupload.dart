import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final String? userId;
  const ImageUpload({super.key, required this.userId});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;
  final imagePicker = ImagePicker();
  String? downloadUrl;

  Future getImage() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        image = File(pick.path);
      } else {
        showSnackbar("No image selected", const Duration(milliseconds: 400));
      }
    });
  }

  uploadImage() async {
    final ref = FirebaseStorage.instance.ref().child("user_image").child("${widget.userId!}.jpg");
    await ref.putFile(image!);
    downloadUrl = await ref.getDownloadURL();
    // print(downloadUrl);
    showSnackbar("Image uploaded", const Duration(milliseconds: 600));
    Navigator.of(context).pop();
    // set image url to user collection
    await FirebaseFirestore.instance.collection("users").doc(widget.userId).update({
      "imageUrl": downloadUrl,
    });
  }

  showSnackbar(String text, Duration d) {
    final snakText = SnackBar(content: Text(text), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snakText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Upload'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: 550,
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      'Upload Image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: 340,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blueGrey,
                          ),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: image == null
                                    ? const Center(
                                        child: Text('No Image Selected'))
                                    : Image.file(image!)),
                            ElevatedButton(
                                onPressed: getImage,
                                child: const Text('Select Image')),
                            ElevatedButton(
                                onPressed: uploadImage,
                                child: const Text('Upload Image'))
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
