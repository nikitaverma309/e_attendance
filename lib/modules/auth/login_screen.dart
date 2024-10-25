import 'dart:io';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      backgroundColor: const Color(0xff176daa),
      appBar: AppBar(
        backgroundColor:
            const Color(0xff176daa), // Set the AppBar background color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Set the back icon color to white
          onPressed: () {
            Navigator.pop(context); // Navigate back when the icon is pressed
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the title
          children: [
            Expanded(
              child: Text(
                "Signing",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white, // Set the title color to white
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const Image(
                  color: Colors.white,
                  image: AssetImage('assets/wFace.png'),
                  height: 88,
                  width: 88,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _empCodeController,
              decoration: InputDecoration(
                labelText: "Employee Code",
                labelStyle: const TextStyle(
                    color: Colors.black), // Optional: Customize label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: Colors.grey), // Optional: Border color
                ),
                prefixIcon: const Icon(Icons.badge,
                    color: Colors.black), // Optional: Change icon color
                filled: true, // Enable filling the background
                fillColor: Colors.white, // Set the background color to white
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.black, // Text color in the TextField
              ),
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

