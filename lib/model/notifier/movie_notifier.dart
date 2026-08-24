import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/feature_services/movie/movie_api.dart';

import '../response/movie_response.dart';


final movieNotifierProvider = StateNotifierProvider<MovieNotifier, AsyncValue<List<Result>>>((ref){
  return MovieNotifier(ref.read(movieApiProvider));
});


class MovieNotifier extends StateNotifier<AsyncValue<List<Result>>> {
  final MovieApi movieApi;
  MovieNotifier(this.movieApi) : super(const AsyncValue.loading()) {
    fetchMovies();
  }



  Future<void> fetchMovies()async {
    state = const AsyncValue.loading();
    final result = movieApi.getMovie();

    result.fold(
            (error){
      state = AsyncValue.error(error, StackTrace.current);
    }, (movieResponse){
      state = AsyncValue.data(movieResponse.results);
    });
  }


  Future<void> searchMovies(String name) async{
    state = const AsyncValue.loading();
    final result = movieApi.searchMovie(name);

    result.fold(
            (error){
          state = AsyncValue.error(error, StackTrace.current);
        }, (movieResponse){
      state = AsyncValue.data(movieResponse.results);
    });
  }

}