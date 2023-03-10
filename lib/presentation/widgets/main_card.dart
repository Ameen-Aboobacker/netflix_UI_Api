import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';

const imageUrl= "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/sv1xJUazXeYqALzczSZ3O6nkH75.jpg";

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 250,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: kradius,
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageUrl,
                ),),),
      ),
    );
  }
}