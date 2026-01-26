import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomeButton extends StatelessWidget {
  CustomeButton({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.ontap,
    required this.textColor,
  });

  final String title;
  final Color backgroundColor;
  void Function()? ontap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: textColor, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
