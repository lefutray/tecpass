import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.labelText,
    this.initialValue,
    this.hintText,
    this.icon,
    this.autofillHints = const [AutofillHints.username, AutofillHints.email],
    this.obscureText = false,
    this.inputType = TextInputType.name,
    this.controller,
    this.onChanged,
    this.validator,
  });

  final String? initialValue;
  final List<String> autofillHints;
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final bool obscureText;
  final TextInputType inputType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        autofillHints: autofillHints,
        obscureText: obscureText,
        autocorrect: false,
        keyboardType: inputType,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorStyle: TextStyle(color: Colors.red, backgroundColor: Theme.of(context).scaffoldBackgroundColor),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
          hintStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w200),
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          prefixIcon: (icon == null) ? null : Icon(icon, color: Colors.white70),
        ),
      ),
    );
  }
}
