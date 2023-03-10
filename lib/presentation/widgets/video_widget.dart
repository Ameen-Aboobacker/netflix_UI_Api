import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            kComingSoonImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.4),
            radius: 20,
            child: IconButton(
              iconSize: 20,
              color: kButtonColorwhite,
              icon: const Icon(Icons.volume_off_sharp),
              onPressed: (() {}),
            ),
          ),
        ),
      ],
    );
  }
}