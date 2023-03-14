import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';

import '../widgets/main_title_card.dart';

const image = 'assets/netflix-logo.png';
ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (context, value, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    ListView(
                      children: const [
                        BackgroundCard(),
                        kHeight,
                        MainTitleCard(
                          title: "Released in the Past Year",
                        ),
                        kHeight,
                        MainTitleCard(title: "Trending Now"),
                        kHeight,
                        NumberTitleCard(),
                        kHeight,
                        MainTitleCard(title: "Tense Dramas"),
                        kHeight,
                        MainTitleCard(title: "South Indian Movies"),
                      ],
                    ),
                    scrollNotifier.value
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 1500),
                            width: double.infinity,
                            height: 90,
                            color: Colors.black.withOpacity(0.3),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                        'https://www.linkpicture.com/q/netflix-logo.png',
                                        width: 70,
                                        height: 70),
                                    const Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      color: kwhite,
                                    ),
                                    kwidth,
                                    Container(
                                        height: 20,
                                        width: 20,
                                        color: Colors.blue),
                                    kwidth,
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'TV Shows',
                                      style: kHomeTitleText,
                                    ),
                                    Text(
                                      'Movies',
                                      style: kHomeTitleText,
                                    ),
                                    Text(
                                      'Categories',
                                      style: kHomeTitleText,
                                    )
                                  ],
                                )
                              ],
                            ))
                        : kHeight
                  ],
                ),
              );
            }));
  }
}
