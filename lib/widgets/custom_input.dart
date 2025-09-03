import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;

  const CustomInput({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.isPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 10, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        controller: textEditingController,
        autocorrect: false,
        keyboardType: textInputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeholder
        ),
      ),
    );
  }
}
