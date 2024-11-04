import 'dart:io';

class RegisterUserModel {
  int? empCode;
  File? image; // Change the type to File

  // Constructor
  RegisterUserModel({this.empCode, this.image});

  // Method to convert JSON to RegisterUserModel
  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    empCode = json['empCode'];
    if (json['image'] != null) {
      image = File(json['image']); // Create a File object from the path
    }
  }

  // Method to convert RegisterUserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'empCode': empCode,
      'image': image?.path, // Store the path as a string
    };
  }
}
