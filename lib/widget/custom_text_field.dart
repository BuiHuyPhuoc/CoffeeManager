import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget CustomTextField(
    {Icon? prefixIcon,
    required BuildContext context,
    String hintText = "...",
    TextEditingController? controller,
    bool obscureText = false,
    IconButton? suffixIcon,
    int maxLines = 1,
    bool readOnly = false,
    String? value,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool enable = true,
    bool enableSuggestions = true,
    bool autocorrect = true,
    InputDecoration? decoration,
    TextInputType? keyboardType
    }) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Color(0xffEEEEEE),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      initialValue: value,
      readOnly: readOnly,
      maxLines: maxLines,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      controller: controller,
      decoration: decoration ?? InputDecoration(
        contentPadding: (prefixIcon != null) ? EdgeInsets.only(top: 12) :  EdgeInsets.only(top: 0),
        border: InputBorder.none,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black26),
        suffixIcon: suffixIcon,
      ),
    ),
  );
}