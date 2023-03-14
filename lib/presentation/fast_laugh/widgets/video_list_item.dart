import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(key:key,child: widget);
  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData !=movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context)
  {
    return context.dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {

  const VideoListItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final posterPath=VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
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
                  children:  [
                    Padding(
                      padding:const  EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath==null?null: NetworkImage("$kImageAppendUrl$posterPath"),
                      ),
                    ),
                    const VideoActionsWidget(
                        title: 'LOL', icon: Icons.emoji_emotions),
                    const VideoActionsWidget(title: 'My List', icon: Icons.add),
                    const VideoActionsWidget(
                      title: 'Share',
                      icon: Icons.telegram_outlined,
                    ),
                   const  VideoActionsWidget(title: 'Play', icon: Icons.play_arrow),
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

