import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';

import '../widgets/main_title_card.dart';

const image = 'assets/netflix-logo.png';
ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
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
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.hasError) {
                          return const Center(
                            child: Text('ERROR'),
                          );
                        } else {
                     
                          log("past");
                          final pastYear = state.pastYearMovieList.map((m) {
                           
                            return '$kImageAppendUrl${m.posterPath}';
                          }).toList();
                        
                          log("trending");
                          final trending = state.trendingMovieList.map((m) {
                          
                            return '$kImageAppendUrl${m.posterPath}';
                          }).toList();

                          final tenseDrama = state.tenseDramaList.map((m) {
                            return '$kImageAppendUrl${m.posterPath}';
                          }).toList();
                          //backgorund
                          
                          final southIndianMovie =
                              state.southIndianMovieList.map((m) {
                            return '$kImageAppendUrl${m.posterPath}';
                          }).toList();
                          log(pastYear.toString());
                         
                          final tvlist =
                              state.tvList.map((t) {
                            return '$kImageAppendUrl${t.posterPath}';
                          }).toList();

                          return ListView(
                            children: [
                               BackgroundCard(
                                image: '$kImageAppendUrl${southIndianMovie.first}',
                              ),
                              kHeight,
                              MainTitleCard(
                                postersList: pastYear,
                                title: "Released in the Past Year",
                              ),
                              kHeight,
                              MainTitleCard(
                                postersList: trending,
                                title: "Trending Now",
                              ),
                              kHeight,
                               NumberTitleCard(
                                tvlist:tvlist,
                               ),
                              kHeight,
                              MainTitleCard(
                                title: "Tense Dramas",
                                postersList: tenseDrama,
                              ),
                              kHeight,
                              MainTitleCard(
                                title: "South Indian Movies",
                                postersList: southIndianMovie,
                              ),
                            ],
                          );
                        }
                      },
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
                                    /*Image.network(
                                        'https://www.linkpicture.com/q/netflix-logo.png',
                                        width: 70,
                                        height: 70),
                                    const Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      color: kwhite,
                                      size: 30,
                                    ),*/
                                    kwidth,
                                  Image.network(avatarImage,width: 25,),
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
