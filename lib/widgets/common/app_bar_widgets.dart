
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'custom_widgets.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLogo, showDrawer, showBackButton;
  final String? title;
  final IconData actionIcon;
  final Widget? leadingWidget, actionWidget;
  final VoidCallback? onActionButtonTap, onBackTap;

  const CustomAppBar({
    super.key,
    this.title,
    this.actionWidget,
    this.showLogo = false,
    this.showDrawer = false,
    this.showBackButton = true,
    this.leadingWidget,
    this.onActionButtonTap,
    this.onBackTap,
    this.actionIcon = Icons.more_vert_outlined,
  });

  @override
  Widget build(BuildContext context) {
    bool _isDarkTheme = true;
    return AppBar(
      backgroundColor: _isDarkTheme ? AppColors.primaryB : Colors.white,
      automaticallyImplyLeading: false,
      elevation: 7,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showBackButton)
            leadingWidget ??
                CustomNeuCircleButton(
                  isColored: true,
                  icon: Icon(
                    showDrawer ? Icons.menu : Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (showDrawer) {
                      Scaffold.of(context).openDrawer();
                    } else {
                      if (onBackTap != null) {
                        onBackTap!.call();
                      } else {
                        Get.back();
                      }
                    }
                  },
                ),
          Expanded(
            child: title != null
                ? Center(
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,style: kText10BlueBlackColorStyle.copyWith(color: Colors.white),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          if (actionWidget != null)
            actionWidget!
          else if (onActionButtonTap != null)
            IconButton(
              icon: Icon(
                actionIcon,
                color: Colors.white,
              ),
              onPressed: () => onActionButtonTap!.call(),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
