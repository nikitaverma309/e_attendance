import 'package:flutter/material.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/modules/profile/profile%20page.dart';

class CmoDrawerScreen extends StatelessWidget {
  const CmoDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryB,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/cglogo.png',
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nikita Verma ",
                      style: kText14whiteColorStyle,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nv123@gmail.com",
                      style: kText10WhiteColorStyle,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Go to Another Page',
                  style: TextStyle(color: Colors.black)),
              leading: const Icon(Icons.arrow_forward, color: Colors.black),
              onTap: () {
                // Navigate to AnotherScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
