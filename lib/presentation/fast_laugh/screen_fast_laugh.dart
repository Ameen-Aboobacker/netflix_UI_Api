import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/presentation/fast_laugh/widgets/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastLaughBloc, FastLaughState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.isError) {
              return const Center(
                child: Text('ERROR'),
              );
            } else if (state.videosList.isEmpty) {
              return const Center(
                child: Text('List is empty'),
              );
            } else {
              return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  state.videosList.length,
                  (index) {
                    return VideoListItemInheritedWidget(
                      widget: VideoListItem(
                        key: Key(index.toString()),
                        index: index,
                      ),
                      movieData: state.videosList[index],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
