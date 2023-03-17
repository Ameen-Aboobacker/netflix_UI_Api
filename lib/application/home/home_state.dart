part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String id,
   
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> trendingMovieList,
    required List<HotAndNewData> tenseDramaList,
    required List<HotAndNewData> southIndianMovieList,
    required List<HotAndNewData> tvList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;

  factory HomeState.initial() => const HomeState(
        id:'0',
        pastYearMovieList: [],
        trendingMovieList: [],
        tenseDramaList: [],
        southIndianMovieList: [],
        tvList: [],
        isLoading: false,
        hasError: false, 
      );
}
