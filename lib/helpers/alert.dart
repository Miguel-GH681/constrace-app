import 'package:chat_app/models/status.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle){
  showDialog(
    context: context, 
    builder: (_) => AlertDialog(
      title: Text( title ),
      content: Text( subtitle ),
      actions: [
        MaterialButton(
          child: Text('Ok'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: ()=> Navigator.pop(context),
        )
      ],
    )
  );
}

showFormAlert(BuildContext context, String title, Widget child){
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        title: Text( title ),
        content: Container(
          height: 200,
          child: child
        ),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: ()=> Navigator.pop(context),
          )
        ],
      )
  );
}