import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  const Label({super.key, required this.title, required this.subtitle, required this.route});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            title,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300
            )
        ),
        SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            // Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            subtitle,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}
