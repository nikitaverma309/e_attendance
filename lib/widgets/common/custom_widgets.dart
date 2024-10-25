//
// import 'package:flutter/material.dart';
// import 'package:htkc_utils/emergent_utils/theme/emergent_decoration_theme.dart';
// import 'package:htkc_utils/emergent_utils/widget/emergent_button.dart';
// import 'package:htkc_utils/emergent_utils/widget/emergent_text.dart';
//
// import '../../constants/colors_res.dart';
// import '../../utils/shap/shape_design.dart';
//
// class CustomNeuCircleICon extends StatelessWidget {
//   final Widget? icon;
//   final IconData? iconData;
//   final String? image;
//   final VoidCallback? onTap;
//   final bool isColored;
//   final double size;
//
//   const CustomNeuCircleICon({
//     super.key,
//     this.icon,
//     this.iconData,
//     this.image,
//     this.onTap,
//     this.isColored = false,
//     this.size = 21,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return EmergentButton(
//       onPressed: onTap,
//       padding: isColored ? null : const EdgeInsets.all(3),
//       style: isColored ? Shape.circleStyle : Shape.coloredCircleCard,
//       child: isColored
//           ? child
//           : Padding(
//               padding: const EdgeInsets.all(3),
//               child: child,
//             ),
//     );
//   }
//
//   Widget get child {
//     if (icon != null) {
//       return icon!;
//     } else if (iconData != null) {
//       return Icon(
//         iconData,
//         size: 15,
//         color: AppColors.white,
//       );
//     } else if (image != null) {
//       return Image.asset(
//         image!,
//         height: size,
//         // color: AppColors.whitePure,
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }
//
// class CustomNeuCircleButton extends StatelessWidget {
//   final Widget? icon;
//   final IconData? iconData;
//   final String? image;
//   final VoidCallback? onTap;
//   final bool isColored;
//   final double size;
//
//   const CustomNeuCircleButton({
//     super.key,
//     this.icon,
//     this.iconData,
//     this.image,
//     required this.onTap,
//     this.isColored = false,
//     this.size = 13,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return EmergentButton(
//       onPressed: onTap,
//       padding: isColored ? null : const EdgeInsets.all(3),
//       style: isColored ? Shape.coloredCircleStyle : Shape.circleStyle,
//       child: isColored
//           ? child
//           : Padding(
//               padding: const EdgeInsets.all(3),
//               child: child,
//             ),
//     );
//   }
//
//   Widget get child {
//     if (icon != null) {
//       return icon!;
//     } else if (iconData != null) {
//       return Icon(
//         iconData,
//         size: 12,
//       );
//     } else if (image != null) {
//       return Image.asset(
//         image!,
//         height: size,
//         color: AppColors.primaryB,
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }
//
// class RectangularEmergentButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String? text;
//   final bool isColored;
//   final double size;
//
//   const RectangularEmergentButton({
//     super.key,
//     required this.onTap,
//     this.text,
//     this.isColored = false,
//     this.size = 13.0,
//   });
//
//   Widget get child {
//     if (text != null) {
//       return EmergentText(
//         text!,
//         style: const EmergentStyle(
//           depth: 2, //customize depth here
//           color: Colors.white, //customize color here
//         ),
//         textStyle: EmergentTextStyle(
//           fontSize: size, //customize size here
//         ),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return EmergentButton(
//       onPressed: onTap,
//       padding: isColored ? null : const EdgeInsets.all(3),
//       style: Shape.coloredRectStyle,
//       child: isColored
//           ? child
//           : Padding(
//               padding: const EdgeInsets.all(3),
//               child: child,
//             ),
//     );
//   }
// }
//
// Widget buildButton(
//     BuildContext context, String label, Color bgColor, Color textColor, IconData icon, VoidCallback onTap) {
//   return InkWell(
//     onTap: onTap, // Use the passed onTap function
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: bgColor,
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: Colors.blue.withOpacity(0.1),
//             blurRadius: 1,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             label,
//             style: TextStyle(color: textColor),
//           ),
//           const SizedBox(width: 10),
//           Icon(icon, color: textColor),
//         ],
//       ),
//     ),
//   );
// }
