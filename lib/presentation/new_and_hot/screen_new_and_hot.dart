import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
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
        body: TabBarView(children: [
          _buildComingSoon(),
          _buildEveryonesWatching(),
        ]),
      ),
    );
  }

  _buildComingSoon() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemBuilder: (BuildContext context, index) => const ComingSoonWidget(),
      itemCount: 10,
    );
  }

  _buildEveryonesWatching() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemBuilder: (BuildContext context, index) =>
          const EveryonesWatchingWidget(),
      itemCount: 10,
    );
  }
}
//
