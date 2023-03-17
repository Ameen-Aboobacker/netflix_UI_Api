import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';



class NumberCard extends StatelessWidget {
  const NumberCard({
    Key? key,
    required this.index,
    required this.tvposter,
  }) : super(key: key);
  final int index;
  final String tvposter;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 60,
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 250,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: kradius,
                  image:  DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      tvposter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            left: 30,
            bottom: -27,
            child: BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 2.0,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                      fontSize: 145,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      color: Colors.black),
                )))
      ],
    );
  }
}
