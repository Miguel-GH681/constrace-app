import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key});

  @override
  Widget build(BuildContext context) {

    Size mediaQuery = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
            top: 25,
            left: 15,
            child: Container(
              height: 180,
              width: mediaQuery.width * 0.9,
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(2,4)
                    )
                  ]
              ),
            )
        ),
        Positioned(
          top: 5,
          left: 25,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              height: 170,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.secondary,
                  image: DecorationImage(
                      image: AssetImage('assets/house-icon.png'),
                      fit: BoxFit.fill
                  )
              ),
            ),
          ),
        ),
        Positioned(
          top: 45,
          left: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Encargado',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Alberto Perez',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.text70,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text('albertop@gmail.com')
            ],
          ),
        )
      ],
    );
  }
}
