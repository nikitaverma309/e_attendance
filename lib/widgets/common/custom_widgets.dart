import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/card_button.dart';

Widget customButton(BuildContext context, String label, Color bgColor,
    Color textColor, IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap, // Use the passed onTap function
    child: Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontFamily: 'Roboto-Thin',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: textColor),
          ],
        ),
      ),
    ),
  );
}

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String hint;
  final ValueChanged<T?> onChanged;
  final String displayKey;
  final String idKey;
  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hint,
    required this.onChanged,
    required this.idKey,
    required this.displayKey,
    this.enabled = true, // Default to enabled
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              (item as dynamic).toJson()[displayKey],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ), // Adjust according to model fields
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        hint: Text(
          hint,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
        ),
        iconEnabledColor: Colors.green,
        dropdownColor: Colors.white,
        isExpanded: true,
      ),
    );
  }
}

class DropDownSelectionMessage extends StatelessWidget {
  final String message;

  const DropDownSelectionMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Shape.submitContainerRed(context),
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(message),
      ),
    );
  }
}

class CustomSnackbarError {
  static void showSnackbar({
    String? title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    double borderRadius = 10.0,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) {
    Get.snackbar(
      title!,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: borderRadius,
      margin: margin,
    );
  }
}

class CustomSnackbarSuccessfully {
  static void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
    double borderRadius = 10.0,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: borderRadius,
      margin: margin,
    );
  }
}

void showSuccessDialog({
  required BuildContext context,
  String? textHeading,
  required String subTitle,
  VoidCallback? onPressed,
  bool navigateAfterDelay = false,
}) {
  if (navigateAfterDelay) {
    Future.delayed(const Duration(seconds: 4), () {
      if (Get.isDialogOpen!) {
        Get.back();
        onPressed?.call();
      }
    });
  }

  Get.defaultDialog(
    title: textHeading ?? "",
    titleStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    middleText: subTitle,
    middleTextStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    radius: 8.0,
    barrierDismissible: false,
    actions: [
      navigateAfterDelay == true
          ? const SizedBox
              .shrink() // यदि navigateAfterDelay false है तो खाली Widget दिखाएं
          : ButtonCard(
              color: Colors.green,
              width: 60,
              height: 40,
              text: "process",
              onPressed: onPressed ?? () => Get.back(),
            ),
    ],
  );
}

void showErrorDialog({
  required BuildContext context,
  required String subTitle,
  String? textHeading,
  VoidCallback? onPressed, // Optional onPressed parameter
  bool permanentlyDisableButton = false,
}) {
  RxBool isButtonDisabled = permanentlyDisableButton.obs;

  if (permanentlyDisableButton) {
    Future.delayed(const Duration(seconds: 10), () {
      if (Get.isDialogOpen!) {
        Get.back();
        onPressed?.call();
      }
    });
  }
  Get.defaultDialog(
    title: textHeading ?? "",
    titleStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    ),
    middleText: subTitle,
    middleTextStyle: const TextStyle(
      fontSize: 12,
      color: Colors.black87,
    ),
    radius: 8.0,
    barrierDismissible: false,
    actions: [
      Obx(() {
        if (isButtonDisabled.value) {
          return const SizedBox.shrink();
        } else {
          return ButtonCard(
            color: Colors.red,
            width: 60,
            height: 40,
            text: "Ok",
            onPressed: onPressed ?? () => Get.back(),
          );
        }
      }),
    ],
  );
}
