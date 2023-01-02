import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gas/style/app_color.dart';

customToast({
      required String title,
      required Color color
    })
{
  Fluttertoast.showToast(
      msg: title,
      textColor: ColorManager.white,
      backgroundColor: color,
      gravity: ToastGravity.TOP
  );

}
