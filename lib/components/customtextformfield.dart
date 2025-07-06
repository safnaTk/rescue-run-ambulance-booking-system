import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;

  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int?maxlines;
  final type;
  TextStyle? style;

  CustomTextFormField({
    Key? key,
    this.style,
    required this.controller,
    this.type=TextInputType.text,
    required this.hintText,
    this.obscureText = false,
    this.maxlines=1,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.style,
      keyboardType: widget.type,
      maxLines: widget.maxlines,
      controller: widget.controller,
      decoration: InputDecoration(

        hintText: widget.hintText,
        enabledBorder: widget.enabledBorder,
        focusedBorder: widget.focusedBorder,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : widget.suffixIcon,
      ),
      obscureText: widget.obscureText && _obscureText,
      validator: widget.validator,
    );
  }
}
