import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/new_and_hot/hot_and_new_service.dart';
import 'package:netflix/domain/new_and_hot/model/hot_and_new_response.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      emit(
        const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          isError: false,
        ),
      );

      final comingSoonResult = await _hotAndNewService.getHotAndNewMovieData();

      final comingSoonState = comingSoonResult.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResponse resp) {
          return HotAndNewState(
            comingSoonList: resp.results,
            everyOneIsWatchingList: state.everyOneIsWatchingList,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(comingSoonState);
    });

    on<LoadDataInEveryoneIsWatching>((event, emit) async {

     emit(
        const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          isError: false,
        ),
      );

      final comingSoonResult = await _hotAndNewService.getHotAndNewTvData();

      final comingSoonState = comingSoonResult.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResponse resp) {
          return HotAndNewState(
            comingSoonList: state.comingSoonList,
            everyOneIsWatchingList: resp.results,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(comingSoonState);

    });
  }
}
