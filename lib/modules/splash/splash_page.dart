import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/feature_showcase_page.dart'; // Import your destination page

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({super.key});

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _controller.forward(); // Start the animation

    // Delay for 2 seconds, then navigate to FeatureShowCasePage
    Future.delayed(const Duration(seconds: 2), navigateToNextPage);
  }

  void navigateToNextPage() {
    if (mounted) {
      Get.offAll(() => const FeatureShowCasePage()); // Navigate to the next page
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation resources
    super.dispose();
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
            ],
          ),
        ),
      ),
    );
  }
}
