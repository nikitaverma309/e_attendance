
import 'package:flutter/material.dart';
import 'package:online/constants/colors_res.dart';

import '../../constants/string_res.dart';

import '../res/assetimagespath.dart';

Widget FooterWidget() {
  return Container(
    decoration: BoxDecoration(
        color: const Color(0xff176daa),
        border: Border.all(width: 0, color: AppColors.white),
        borderRadius: BorderRadius.circular(0)),
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Strings.copyright_content,
          style: TextStyle(color: Colors.white),
          maxLines: 2,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.asset(
            AssetImagePath.niclogopath,
            width: 25.0,
            height: 25.0,
          ),
        ),
      ],
    ),
  );
}