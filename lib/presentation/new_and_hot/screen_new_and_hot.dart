import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/new_and_hot/widgets.dart/coming_soon_widget.dart';

import 'widgets.dart/everyones_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              'New and Hot',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            titleSpacing: 5,
            actions: [
              const Icon(
                Icons.cast,
                color: kwhite,
              ),
              kwidth,
              Container(height: 35, width: 40, color: Colors.blue),
              kwidth,
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: kblack,
              unselectedLabelColor: kwhite,
              labelStyle: kTabTitleText,
              indicator: BoxDecoration(color: kwhite, borderRadius: kradius30),
              tabs: const [
                Tab(
                  text: '🍿️ Coming Soon',
                ),
                Tab(
                  text: "👀️ Everyone's Watching",
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [
           ComingSoonList(
            key: Key('coming_soon'),
          ),
          EveryonesWatchingList(),
        ]),
      ),
    );
  }

}
//coming soon list

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
        onRefresh: () async {
             BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
          },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error on Loading Data'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('Coming soon is Empty'),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0,20,10,0),
              itemBuilder: (BuildContext context, index) {
                final movie = state.comingSoonList[index];
                log(movie.releaseDate.toString());
                final date = DateTime.parse(movie.releaseDate!);
                final dayformat = DateFormat.MMMd().format(date);
                final month =
                    dayformat.split(' ').first.substring(0, 3).toUpperCase();
                final day = movie.releaseDate!.split('-')[2];
                log(day.toString());
                return ComingSoonWidget(
                  id: movie.id.toString(),
                  month: month,
                  day: day,
                  posterPath: '$kImageAppendUrl${movie.backdropPath}',
                  movieName: movie.originalTitle ?? 'No title available',
                  description: movie.overview ?? "description not available",
                );
              },
              itemCount: state.comingSoonList.length,
            );
          }
        },
      ),
    );
  }
}

// every one watching list
class EveryonesWatchingList extends StatelessWidget {
  const EveryonesWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    return RefreshIndicator(
  
          onRefresh: () async {
             BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
          },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error on Loading Data'),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text("Everyone's watching is Empty"),
            );
          } else {
            return ListView.separated(

              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemBuilder: (BuildContext context, index) {
                 final tv= state.everyOneIsWatchingList[index];
                 final String? path;
                 if(tv.backdropPath==null){
                   path=tv.posterPath;
                 }else{
                  path=tv.backdropPath;
                 }
                 return  EveryonesWatchingWidget(
                posterPath:'$kImageAppendUrl$path' ,
                movieName:tv.originalName??'No title available',
                description: tv.overview??'description not available',
              );},
              itemCount: state.everyOneIsWatchingList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(),
            );
          }
        },
      ),
    );
  }
}
