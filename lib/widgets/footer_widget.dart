
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/string_res.dart';
import '../res/Mycolor.dart';
import '../res/assetimagespath.dart';

Widget Footerwidget() {
  return Container(
    decoration: BoxDecoration(
        color: MyColor.niccolor,
        border: Border.all(width: 0, color: MyColor.white_pure),
        borderRadius: BorderRadius.circular(0)),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
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