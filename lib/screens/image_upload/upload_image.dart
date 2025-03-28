import 'dart:developer';
import 'dart:io' show File;

import 'package:dummy_project/screens/image_upload/image_picker_service.dart';
import 'package:flutter/material.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upload Image'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ImagePickerService().pickImage().then((value) {
              setState(() {
                image = File(value!.path);
                log(image!.path);
              });
            }).onError(((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error.toString(),
                  ),
                ),
              );
            }));
          });
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: Center(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: image == null ? Icon(Icons.image) : Image.file(image!),
            ),
            ElevatedButton(
              onPressed: () {
                // Pick image from gallery
                // Use image picker package
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
