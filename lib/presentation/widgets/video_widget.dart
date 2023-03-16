import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class VideoWidget extends StatelessWidget {
  final String image;
  const VideoWidget({
    super.key, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            image,
            fit: BoxFit.fill,
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
