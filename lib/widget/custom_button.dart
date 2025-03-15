import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.borderColor = Colors.grey,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = 100.0,
    this.padding = const EdgeInsets.all(12),
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
