import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:online/modules/auth/views/home/home.dart';
import 'package:online/screens/comman_screen/faq_screen.dart';

class MainPage extends StatefulWidget {
  final int? initialPage;

  const MainPage({super.key, this.initialPage});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<TabItem<dynamic>> items = [
    const TabItem<IconData>(icon: Icons.home, title: 'Home'),
    const TabItem<IconData>(icon: Icons.notification_add, title: 'Faq'),
  ];

  @override
  void initState() {
    currentIndex = widget.initialPage ?? 0;
    super.initState();
  }

  onBack() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomBarFloating(
                enableShadow: false,
                items: items,
                backgroundColor: const Color(0xff1a6396),
                color: Colors.white,
                colorSelected: Colors.yellow,
                indexSelected: currentIndex,
                onTap: (int index) => setState(() {
                  currentIndex = index;
                }),
                //  backgroundSelected: Colors.black,
              ),
            ],
          ),
          body: getIndex()),
    );
  }

  getIndex() {
    if (currentIndex == 0) {
      return const MyHomePage();
    } else {
      return FaqScreen();
    }
  }
}
