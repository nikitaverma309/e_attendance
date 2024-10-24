import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  final Function onPressed; // Callback function when the button is pressed
  final bool isLogin; // Determines if the button is for login or sign up
  final Function reload; // Callback function to reload the UI after capturing

  AuthActionButton({
    Key? key,
    required this.onPressed,
    required this.isLogin,
    required this.reload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Call the onPressed function when the button is tapped
        await onPressed();
        // Reload the UI after capturing
        reload();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[200], // Button background color
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'LOGIN' : 'SIGN UP', // Change text based on isLogin
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 10),
            Icon(Icons.camera_alt, color: Colors.white), // Camera icon
          ],
        ),
      ),
    );
  }
}
