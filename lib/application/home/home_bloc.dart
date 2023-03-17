import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/new_and_hot/hot_and_new_service.dart';
import 'package:netflix/domain/new_and_hot/model/hot_and_new_response.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService homeService;
  HomeBloc(this.homeService) : super(HomeState.initial()) {
    on<GetHomeScreenData>(
      (event, emit) async {
        emit(
          state.copyWith(
            isLoading: true,
            hasError: false,
          ),
        );

        final movieData = await homeService.getHotAndNewMovieData();
        final tvData = await homeService.getHotAndNewTvData();

        //movieData
        final movieState = movieData.fold(
          (MainFailure failure) {
            return  HomeState(
               id:DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramaList: [],
              southIndianMovieList: [],
              tvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResponse resp) {
            
            final pastYearList=resp.results.toList();
            final trendingList = resp.results.toList();
            final tenseDramaList = resp.results.toList();
            final southIndianList = resp.results.toList();
            pastYearList.shuffle();
            trendingList.shuffle();
            southIndianList.shuffle();
            return HomeState(
              id:DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: pastYearList,
              trendingMovieList: trendingList,
              tenseDramaList: tenseDramaList,
              southIndianMovieList: southIndianList,
              tvList: state.tvList,
              isLoading: false,
              hasError: false, 
            );
          },
        );
        emit(movieState);

        //tvdata
        final tvState = tvData.fold(
          (MainFailure failure) {
            return HomeState(
               id:DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramaList: [],
              southIndianMovieList: [],
              tvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResponse resp) {
            return HomeState(
               id:DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: state.trendingMovieList,
              tenseDramaList: state.tenseDramaList,
              southIndianMovieList: state.southIndianMovieList,
              tvList: resp.results,
              isLoading: false,
              hasError: false,
            );
          },
        );
        emit(tvState);
      },
    );
  }
}
