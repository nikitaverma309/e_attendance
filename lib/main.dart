import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:online/locator.dart';
import 'package:online/modules/splash/splash_page.dart';

import 'modules/restriction_dialog/dialog_manager.dart';


void main() {

  void initDialogManager() => serviceLocator<DialogManager>().init();
  HttpOverrides.global = CustomHttpOverrides();
  setupServices();
  initDialogManager();
  runApp(const MyApp());
}
class CustomHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? securityContext){
    return super
        .createHttpClient(securityContext)
      ..badCertificateCallback =
          (X509Certificate certificate, String hostName, int hostPort)=> true;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home:  const SplashScreenOne(),

    );
  }
}
