
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'card_model.dart';


///so i extracted this code from a movies personal app i made with Get and http package in order to
///have a mutli feature app, would sort it out

final movieRequestProvider = Provider<MovieRequest>((ref)=>MovieRequest());

class MovieRequest{

  Future<List<ClassModel>> getMovies() async {
    ///THE DOT ENV HAS GOT TO BE IN THE ORIGINAL APP DIRECTORY
    await dotenv.load();
    String token = dotenv.get("Token");
    print(token);
    String message = "Something went wrong";
    final url = Uri.parse('https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );


    final responseData = json.decode(response.body);
    if(response.statusCode == 200) {
      List<ClassModel> classModelList = [];

      for (var result in responseData['results']) {
        classModelList.add(ClassModel(
          original_title: result["original_title"],
          backdrop_paths: result["backdrop_path"],
          original_language: result["original_language"],
          overview: result["overview"],
          release_date: result["release_date"],
        ));
      }

      for (var classModel in classModelList){
        print(classModel.original_title);

      }

      return classModelList;
    }

    else{
      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'];
      throw Exception(
          'Request failed with status: ${response.statusCode}, Message: $message');

    }

  }


  Future<List<ClassModel>> searchMovies(String name) async {
    await dotenv.load();
    dynamic token = dotenv.get("Token");
    print(token + ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

    final url = Uri.parse('https://api.themoviedb.org/3/search/movie?query=$name&include_adult=false&language=en-US&page=1');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200){
      List<ClassModel> searchedList = [];

      for (var result in responseData['results']) {
        searchedList.add(ClassModel(
          original_title: result["original_title"],
          backdrop_paths: result["poster_path"],
          original_language: result["original_language"],
          overview: result["overview"],
          release_date: result["release_date"],
        ));
      }

      for (var classModel in searchedList){
        print(classModel.backdrop_paths);

      }

      return searchedList;
    }
    else{
      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'];
      throw Exception(
          'Request failed with status: ${response.statusCode}, Message: $message');

    }

  }
}