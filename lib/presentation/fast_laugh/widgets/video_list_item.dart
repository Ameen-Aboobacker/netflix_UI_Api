import 'package:flutter/material.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';

import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(key: key, child: widget);
  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  const VideoListItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoLink = videoUrls[index % videoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(videoUrl: videoLink, onStateChanged: (boolean) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage("$kImageAppendUrl$posterPath"),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: likedVideosNotifier,
                        builder: (context, Set<int> liked, _) {
                          final ind = index;
                          if (likedVideosNotifier.value.contains(ind)) {
                            return GestureDetector(
                              onTap: () {
                                likedVideosNotifier.value.remove(ind);
                                likedVideosNotifier.notifyListeners();
                              },
                              child: VideoActionsWidget(
                                title: 'LOL',
                                icon: Icons.emoji_emotions,
                                color: Colors.yellow.shade600,
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                likedVideosNotifier.value.add(ind);
                                likedVideosNotifier.notifyListeners();
                              },
                              child: const VideoActionsWidget(
                                title: 'LOL',
                                icon: Icons.emoji_emotions,
                              ),
                            );
                          }
                        }),
                    const VideoActionsWidget(
                      title: 'My List',
                      icon: Icons.add,
                    ),
                    GestureDetector(
                      onTap: () {
                        final movieName =
                            VideoListItemInheritedWidget.of(context)
                                ?.movieData
                                .posterPath;
                        if (movieName != null) {
                          Share.share(movieName);
                        }
                      },
                      child: const VideoActionsWidget(
                        title: 'Share',
                        icon: Icons.telegram_outlined,
                      ),
                    ),
                    const VideoActionsWidget(
                      title: 'Play',
                      icon: Icons.play_arrow,
                    ),
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
  const VideoActionsWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.color = kButtonColorwhite,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Color color;
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
            color: color,
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  FastLaughVideoPlayerState createState() => FastLaughVideoPlayerState();
}

class FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    videoPlayerController.initialize().then((value) {
      setState(() {});
      videoPlayerController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
