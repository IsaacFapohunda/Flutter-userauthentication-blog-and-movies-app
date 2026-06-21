import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/search_movie.dart';

import '../../model/movie/card_model.dart';
import '../../model/movie/services.dart';
import '../utilities/app_color.dart';
import '../utilities/textstyle.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'dart:convert';
import 'dart:io';
import 'dart:math';




// import 'package:movies_app/constants/app_color.dart';
// import 'package:movies_app/search_movie.dart';
// import 'package:movies_app/services/card_model.dart';
// import 'package:movies_app/services/services.dart';
//
// import 'constants/textstyle.dart';

class MoviesScreen extends ConsumerStatefulWidget {

  const MoviesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {
  late Future<List<ClassModel>> classModelList;
  bool isLoading = false;
  TextEditingController movieNameController = TextEditingController();
    @override
  void initState() {
    // TODO: implement initState
   classModelList = MovieRequest().getMovies();
  }
  @override
  Widget build(BuildContext context) {

    final movieRef = ref.watch(movieRequestProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red,
              ),

              onPressed: (){
                movieRef.getMovies();
              }, child: Text('Discover Trending movies Movies', style: appbartextStyle(),),),
            TextButton(

              onPressed: (){
               //
                // Get.to(SearchMovie());
                movieRef.searchMovies(movieNameController.text);
              }, child: Icon(Icons.search),)
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextButton(
            onPressed: (){

              //Get.off(MovieRequest());

            },
            child: Icon(Icons.arrow_back_ios),),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<ClassModel>>(
              future: classModelList,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                }


                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: primaryColor,
                          height: 300,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    "http://image.tmdb.org/t/p/w1280/" + snapshot.data![index].backdrop_paths,

                                  ),
                                ),
                                SizedBox(height: size.height*0.007,),
                                Center(child: Text(snapshot.data![index].original_title, style: TextStyle(fontSize: 20, color: Colors.green))),
                                SizedBox(height: size.height*0.005,),
                                Text("Overview: " + snapshot.data![index].overview, style: TextStyle(fontSize: 10, color: Colors.green)),
                                SizedBox(height: size.height*0.005,),
                                Row(
                                  children: [
                                    Text("Original Language: " + snapshot.data![index].original_language, style: TextStyle(fontSize: 10, color: Colors.green)),
                                    SizedBox(width: size.width*0.33,),
                                    Text("Release date: " + snapshot.data![index].release_date, style: TextStyle(fontSize: 10, color: Colors.green))
                                  ],
                                )
                              ],
                            ),
                          ),

                        ),
                      );
                    });


              })
      ),

    );
  }
}