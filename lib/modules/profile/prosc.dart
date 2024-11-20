import 'dart:convert'; // For base64Decode
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:flutter/services.dart'; // For Image.memory

import '../../controllers/profile_ctr/profile_controller.dart';

class Asddwed extends StatelessWidget {
  final ProfileModel? data;

  Asddwed({required this.data});

  @override
  Widget build(BuildContext context) {
    // Decode base64 image here, so it happens after initialization
    Uint8List? bytes;
    if (data?.image != null && data!.image!.isNotEmpty) {
      bytes = base64Decode(data!.image!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Displaying the image if it's available
              if (bytes != null && bytes.isNotEmpty)
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(bytes), // Using MemoryImage to display the image
                    onBackgroundImageError: (_, __) => Icon(Icons.person, size: 50), // Default icon in case of error
                  ),
                ),
              SizedBox(height: 20),
              Text("Name: ${data?.name ?? ''}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Emp Code: ${data?.empCode ?? ''}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Email: ${data?.email ?? ''}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Contact: ${data?.contact ?? ''}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("District: ${data?.districtName ?? ''}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Work Type: ${data?.workType ?? ''}", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
