// import 'package:flutter/material.dart';
// import 'package:htkc_utils/emergent_utils/emergent_box_shape.dart';
// import 'package:htkc_utils/emergent_utils/emergent_light_source.dart';
// import 'package:htkc_utils/emergent_utils/emergent_shape.dart';
// import 'package:htkc_utils/emergent_utils/theme/emergent_decoration_theme.dart';
//
// import '../../constants/colors_res.dart';
//
//
// class Shape {
//   static BoxDecoration choosePdfWhite(BuildContext context) {
//     return BoxDecoration(
//       borderRadius: BorderRadius.circular(10.0),
//       border: Border.all(
//         color: Colors.white,
//         width: 1.0,
//       ),
//       color: Colors.white,
//     );
//   }
//   static BoxDecoration listDecoration(BuildContext context) {
//     return BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: AppColors.athensGray.withOpacity(0.3),
//           offset: const Offset(-2.0, -2.0),
//           blurRadius: 2.0,
//         ),
//         BoxShadow(
//           color: AppColors.athensGray.withOpacity(0.2),
//           offset: const Offset(2.0, 2.0),
//           blurRadius: 2.0,
//         ),
//       ],
//       color: const Color(0xFFD4EAEA),
//       border: Border.all(
//         color: Colors.white,
//         width: 1.0, // Set the border width here
//       ),
//       borderRadius: BorderRadius.circular(5.0),
//     );
//   }
//   static BoxDecoration purpleContainerDecoration(BuildContext context) {
//     return BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.3),
//           offset: const Offset(-3.0, -3.0),
//           blurRadius: 2.0,
//         ),
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.2),
//           offset: const Offset(3.0, 3.0),
//           blurRadius: 2.0,
//         ),
//       ],
//       color: const Color(0xFDE9E9F5),
//       borderRadius: BorderRadius.circular(10.0),
//     );
//   }
//   static Card getStyledCard(BuildContext context, List<Widget> children) {
//     return Card(
//       elevation: 0.0,
//       shadowColor: Colors.grey,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         side: const BorderSide(
//           color: Colors.white,
//           width: 1.0,
//         ),
//       ),
//       color: Colors.white,
//       clipBehavior: Clip.hardEdge,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: purpleContainerDecoration(context),
//         child: Column(
//           children: children,
//         ),
//       ),
//     );
//   }
//   static BoxDecoration singleDataDecoration(BuildContext context) {
//     return BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: AppColors.athensGray.withOpacity(0.3),
//           offset: const Offset(-2.0, -2.0),
//           blurRadius: 2.0,
//         ),
//         BoxShadow(
//           color: AppColors.athensGray.withOpacity(0.2),
//           offset: const Offset(2.0, 2.0),
//           blurRadius: 2.0,
//         ),
//       ],
//       color: const Color(0xFD365E6C),
//       border: Border.all(
//         color: Colors.white,
//         width: 1.0, // Set the border width here
//       ),
//       borderRadius: BorderRadius.circular(5.0),
//     );
//   }
//
//   static final EmergentStyle coloredRectStyle = EmergentStyle(
//     shape: EmergentShape.concave,
//     boxShape: EmergentBoxShape.roundRect(BorderRadius.circular(8)),
//     depth: 12,
//     lightSource: LightSource.topLeft,
//     shadowLightColor: Colors.white.withOpacity(0.12),
//     color: AppColors.primary,
//   );
//   static final EmergentStyle coloredCircleStyle = EmergentStyle(
//     shape: EmergentShape.concave,
//     boxShape: const EmergentBoxShape.circle(),
//     depth: 4,
//     lightSource: LightSource.topLeft,
//     shadowLightColor: Colors.white.withOpacity(0.65),
//     color: AppColors.primaryB,
//   );
//   static final EmergentStyle coloredCircleCard = EmergentStyle(
//     shape: EmergentShape.convex,
//     boxShape: const EmergentBoxShape.circle(),
//     depth: 2,
//     lightSource: LightSource.topLeft,
//     shadowLightColor: Colors.grey.withOpacity(0.65),
//     color: AppColors.primary,
//   );
//   static final EmergentStyle circleStyle = EmergentStyle(
//     color: const Color(0xff1b1d28),
//     depth: 3,
//     intensity: .7,
//     surfaceIntensity: .03,
//     shadowLightColor: Colors.white.withOpacity(0.8),
//     shape: EmergentShape.concave,
//     lightSource: LightSource.topLeft,
//     boxShape: const EmergentBoxShape.circle(),
//   );
//   //error Container Red
//   static BoxDecoration submitContainerRed(BuildContext context) {
//     return BoxDecoration(
//       color: AppColors.green,
//       border: Border.all(
//         color: Colors.white,
//         width: 1.0,
//       ),
//       borderRadius: BorderRadius.circular(10.0),
//     );
//   }
//
//   //error Container Red
//   static BoxDecoration errorContainerRed(BuildContext context) {
//     return BoxDecoration(
//       color: AppColors.redShade4,
//       border: Border.all(
//         color: Colors.white,
//         width: 1.0,
//       ),
//       borderRadius: BorderRadius.circular(10.0),
//     );
//   }
// }