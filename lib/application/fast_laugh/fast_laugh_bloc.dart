import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final videoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
];

ValueNotifier<Set<int>> likedVideosNotifier=ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadsRepo downloadService,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      emit(
        const FastLaughState(
          videosList: [],
          isLoading: true,
          isError: false,
        ),
      );

      final result = await downloadService.getDownloadsImage();
      final resultState = result.fold(
        (l) {
          return const FastLaughState(
            videosList: [],
            isLoading: false,
            isError: true,
          );
        },
        (response) => FastLaughState(
          videosList: response,
          isLoading: false,
          isError: false,
        ),
      );
      emit(resultState);
    });
    on<LikeVideos>((event, emit) async {
      likedVideosNotifier.value.add(event.id);
      likedVideosNotifier.notifyListeners();
    });

    on<UnlikeVideos>((event, emit) async {
      likedVideosNotifier.value.remove(event.id);
      likedVideosNotifier.notifyListeners();
    });
  }
}
