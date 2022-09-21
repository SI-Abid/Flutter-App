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
  final ImagePicker _picker = ImagePicker();

  Future selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No image selected'),
          duration: Duration(seconds: 1),
        ));
      }
    });
  }

  Future uploadImage() async {
    final ref = FirebaseStorage.instance.ref().child('userImages/${widget.userId}');
    await ref.putFile(image!);
    final url = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .update({'photoUrl': url})
        .whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Image uploaded'),
        duration: Duration(seconds: 1),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Upload'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 500,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Upload Image',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Center(
                                child: Column(children: [
                                  Expanded(
                                      child: image == null
                                          ? const Text('No Image Selected')
                                          : Image.file(image!)),
                                  ElevatedButton(
                                      onPressed: selectImage,
                                      child: const Text('Select Image')),
                                  ElevatedButton(
                                      onPressed: uploadImage,
                                      child: const Text('Upload Image')),
                                ]),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
