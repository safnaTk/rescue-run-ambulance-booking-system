
import 'package:flutter/material.dart';

import 'apptext.dart';


class AppButton extends StatelessWidget {
  double ?height, width;
  String?text;
  Color?color;
  double?fontSize;
  Color?fontColor;
  final VoidCallback? onTap;

  AppButton({Key? key,this.text,this.height,this.width,this.fontSize=16,this.fontColor,this.onTap,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color
        ),
        child: Center(child: AppText(data: text,size: fontSize!.toDouble(),color: fontColor,)),
      ),
    );
  }
}
