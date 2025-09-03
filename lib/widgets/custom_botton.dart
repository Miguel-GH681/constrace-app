import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomBotton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Colors.black26,
      elevation: 3,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: Center(
          child: Text(
       text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          ),
        ),
      )
    );
  }
}
