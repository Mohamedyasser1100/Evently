import 'package:evently/core/constatnt/app_colors.dart';
import 'package:flutter/material.dart';

class CustomeTextField extends StatefulWidget {
  const CustomeTextField(
    this.validator, {
    super.key,
    required this.text,
    this.suffixIcon,
    required this.isPassword,
    required this.controller,
    this.prefixIcon,
  });
  final String text;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  bool obscureText = true;
  void hidePass() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: TextInputType.emailAddress,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: widget.text,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: hidePass,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
