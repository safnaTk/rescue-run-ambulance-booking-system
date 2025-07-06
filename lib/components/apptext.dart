
import 'package:flutter/material.dart';


class AppText extends StatelessWidget {
  final String?data;
  final double? size;
  final FontWeight? fw;
  final FontStyle? fs;

  final Color? color;
  final TextAlign? alignment;
  final overflow;
  final lines;
  const AppText( {Key? key,this.data,this.lines=1,this.overflow=TextOverflow.visible,this.size=16,this.fw=FontWeight.w500,this.color=Colors.black,this.alignment=TextAlign.left,this.fs=FontStyle.italic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

      data.toString(),
      maxLines: lines,
      textAlign: alignment,
      overflow: overflow,
      style: TextStyle(
          color:color,
          fontWeight:fw,
          fontSize: size),
    );
  }
}
