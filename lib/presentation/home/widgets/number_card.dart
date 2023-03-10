import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
const imageUrl= "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/sv1xJUazXeYqALzczSZ3O6nkH75.jpg";
class NumberCard extends StatelessWidget {
const NumberCard({ Key? key, required this.index }) : super(key: key);
final int index;
  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width:60,
              height: 150,
            ),
            Padding(
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
            ),
          ],
        ),
        Positioned(
          left:30,
         bottom: -27,
          child: BorderedText(
            strokeColor: Colors.white,
            strokeWidth: 2.0,
            child: Text(
              '${index+1}',
            style:const  TextStyle(
              fontSize: 145,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              color: Colors.black),))
          )
      ],
    );
  }
}