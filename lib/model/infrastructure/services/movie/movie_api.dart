
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/infrastructure/external_api_client.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/exceptions.dart';
import 'package:springboot_flutter_bloggingapp/model/response/movie_response.dart';

import '../../endpoints/movie_endpoint.dart';


final movieApiProvider = Provider<MovieApi>((ref) {
  final client = ref.watch(tmdbClientProvider);
  return MovieApiImpl(client);
});



final tmdbClientProvider = Provider<ExternalApiClient>((ref){
  final accessToken = dotenv.env['tdmb_access_token'];
  return ExternalApiClient(baseUrl: MovieEndpoints.movieBaseUrl,
      accessToken: accessToken
  );
});

abstract class MovieApi{
  Future<Either<ApiException, MovieResponse>> getMovie();
  Future<Either<ApiException, MovieResponse>> searchMovie(String name);
}


class MovieApiImpl extends MovieApi{

  MovieApiImpl(this.externalApiClient);
  final ExternalApiClient externalApiClient;



  @override
  Future<Either<ApiException, MovieResponse>> getMovie() async {
    try{
      final httpResponse = await externalApiClient .get(
          MovieEndpoints.getMovies,
      );
      final response = MovieResponse.fromJson(httpResponse.data);
      return Right(response);
    }catch(err){
      if(err is DioException){
        return Left(ApiException.getException(err));
      }
      return Left(ApiException(err.toString()));
    }

  }

  @override
  Future<Either<ApiException, MovieResponse>> searchMovie(String name) async{
    try{
      final httpResponse = await externalApiClient.get(
          MovieEndpoints.searchMovies,
        queryParameters: {
            'query': name,
          'include_adult': false,
          'language': 'en-US',
          'page': 1,
        }
      );
      final response = MovieResponse.fromJson(httpResponse.data);
      return Right(response);

    }on DioException catch(err){
        return Left(ApiException.getException(err));

    } catch(e){
      return Left(ApiException(e.toString()));
    }
  }


}