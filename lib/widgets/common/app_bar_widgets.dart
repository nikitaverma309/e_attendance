import 'package:flutter/material.dart';
import 'package:online/constants/text_size_const.dart';

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
    return AppBar(
      backgroundColor: const Color(0xff176daa),
      automaticallyImplyLeading: false, // Set to false to control leading manually
      elevation: 7,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: title != null
                ? Center(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: kWhite.copyWith(color: Colors.white),
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
      leading: showBackButton
          ? IconButton(
        icon: const Icon(
          Icons.arrow_back, // Default back icon
          color: Colors.white, // Set the color to white
        ),
        onPressed: onBackTap ??
                () {
              Navigator.of(context).pop();
            },
      )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
