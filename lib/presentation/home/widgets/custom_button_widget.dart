import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key, required this.icon, required this.title,  this.iconSize, this.textSize,
  });
   final IconData icon;
   final String title;
   final double? iconSize;
    final double? textSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Icon(
          icon,
          color: kwhite,
          size: iconSize,
        ),
        Text(title,style: TextStyle(fontSize: textSize),),
      ],
    );
  }
}
