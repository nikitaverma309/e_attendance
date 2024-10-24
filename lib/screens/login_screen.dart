import 'dart:io';

import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _empCodeController = TextEditingController();
  File? _imageFile; // To store the captured image

  // Callback function to handle the captured image
  void _onImageCaptured(File image) {
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Employee Code Text Field
            TextField(
              controller: _empCodeController,
              decoration: InputDecoration(
                labelText: "Employee Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.badge),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Display Captured Image or Camera Prompt
            _imageFile != null
                ? Center(
              child: Image.file(
                _imageFile!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
                : const Center(
              child: Column(
                children: [
                  Icon(Icons.camera_alt, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Tap the button to capture or upload an image",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Camera Button
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => CameraView(
                //       onImage: _onImageCaptured, onInputImage: (InputImage inputImage) {  }, // Pass the callback function
                //     ),
                //   ),
                // );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blueGrey,
              ),
              child: const Text(
                "Camera",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
