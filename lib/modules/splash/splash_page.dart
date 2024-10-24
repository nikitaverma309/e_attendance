import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/feature_showcase_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for scaling
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Create a bounce animation for the logo scale
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    // Start the animation
    _controller.forward();
    init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const FeatureShowCasePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2193b0), // Light blue
              Color(0xff6dd5ed), // Sky blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ScaleTransition for jumping effect

              ScaleTransition(
                scale: _animation,
                child: ClipOval(
                  child: Image.asset(
                    "assets/icon/higher.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to Atithi Vyakhayata",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
