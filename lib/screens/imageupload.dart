import 'dart:io';

import 'package:flutter/material.dart';

class ImageUpload extends StatefulWidget {
  final String? userId;
  const ImageUpload({super.key, required this.userId});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;
  
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
                                  const ElevatedButton(
                                      onPressed: null,
                                      child: Text('Select Image')),
                                  const ElevatedButton(
                                      onPressed: null,
                                      child: Text('Upload Image')),
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
