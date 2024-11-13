//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:online/constants/colors_res.dart';
// import 'package:online/generated/assets.dart';
//
// class BottomSheetExample extends StatelessWidget {
//   const BottomSheetExample({super.key});
//   Future<void> clearLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           height: 280,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.15,
//                     width: MediaQuery.of(context).size.width * 0.30,
//                     child: Image.asset(
//                       Assets.iconSaidImg,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const Text(
//                   'Login Out?',
//
//                 ),
//                 const Text(
//                   'Are you sure about it?',
//                   style: TextStyle(color: AppColors.black),
//                 ),
//                 20.height,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () => Navigator.pop(context, false),
//                       child: Card(
//                         color: const Color(0xFFC0DBEE),
//                         elevation: 16.0,
//                         shadowColor: const Color(0xFFEDEBF5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(26.0),
//                           side: const BorderSide(
//                             color: Colors.white,
//                             width: 1.0,
//                           ),
//                         ),
//                         child: const SizedBox(
//                           height: 35,
//                           width: 99,
//                           child: Center(
//                             child: Text("cancel",
//                                 style: TextStyle(
//                                   color: Colors
//                                       .black, // Set the desired text color here
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         await clearLoginStatus();
//                        // Get.offAll(() => const UlbLoginPage());
//                       },
//                       child: Card(
//                         color: const Color(0xFFEF5144),
//                         elevation: 16.0,
//                         shadowColor: const Color(0xFFEDEBF5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(26.0),
//                           side: const BorderSide(
//                             color: Colors.white,
//                             width: 1.0,
//                           ),
//                         ),
//                         child: const SizedBox(
//                           height: 35,
//                           width: 99,
//                           child: Center(
//                             child: Text("Yes, Logout",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0,
//           right: 10,
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.red,
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
