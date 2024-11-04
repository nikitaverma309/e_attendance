import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:online/controllers/login_controller.dart';
import 'package:online/modules/home/home.dart';
import '../../utils/utils.dart';

class ImagePreviewPage extends StatelessWidget {
  final File imageFile;

  const ImagePreviewPage({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LoginController ko yahan instantiate kar rahe hain
    final LoginController _loginController = Get.put(LoginController());

    TextEditingController empCode = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.file(imageFile),
            ),
          ),
          TextField(
            controller: empCode,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              print('Current input: $value');
            },
            decoration: const InputDecoration(
              label: Text(
                'User Employee code',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff747474)),
              ),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffD1D1D4), width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffD1D1D4), width: 2),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                // Image upload karne ka function call
                int? employeeCode = int.tryParse(empCode.text.trim());
                await _loginController.uploadFileSignUp(
                    employeeCode!, imageFile);
                Utils.showSuccessToast(message: 'Image uploaded successfully!');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image uploaded successfully!')),
                );

                Get.offAll(() => MyHomePage());
              } catch (e) {
                Get.offAll(() => MyHomePage());
                Utils.showSuccessToast(message: 'Failed to upload image');
                print('Error uploading image: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to upload image')),
                );
              }
            },
            child: const Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
