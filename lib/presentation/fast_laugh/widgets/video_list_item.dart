import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.accents[index % Colors.accents.length],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //left
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  radius: 30,
                  child: IconButton(
                    iconSize: 30,
                    color: kButtonColorwhite,
                    icon: const Icon(Icons.volume_off_sharp),
                    onPressed: (() {}),
                  ),
                ),
                //right
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("https://www.themoviedb.org/t/p/w600_and_h900_bestv2/sv1xJUazXeYqALzczSZ3O6nkH75.jpg"),
                      ),
                    ),
                    VideoActionsWidget(
                        title: 'LOL', icon: Icons.emoji_emotions),
                    VideoActionsWidget(title: 'My List', icon: Icons.add),
                    VideoActionsWidget(
                      title: 'Share',
                      icon: Icons.telegram_outlined,
                    ),
                    VideoActionsWidget(title: 'Play', icon: Icons.play_arrow),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  const VideoActionsWidget({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: kwhite,
          ),
          Text(
            title,
            style: const TextStyle(
              color: kwhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
