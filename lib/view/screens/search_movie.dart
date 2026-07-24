import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/movie/card_model.dart';
import '../../model/movie/services.dart';
import '../../model/theme/app_color.dart';
import 'movie_screen.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:movies_app/movies_screen.dart';
// import 'package:movies_app/services/card_model.dart';
// import 'package:movies_app/services/services.dart';
//
// import 'constants/app_color.dart';



class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {

  Future<List<ClassModel>>? searchedList;
  bool isLoading = false;

  //MovieRequest movieRequest = Get.put(MovieRequest());

  void updateResult(String name){
    setState(() {
      searchedList = MovieRequest().searchMovies(name);
    });
  }




  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 40,
          title: Container(
            decoration: BoxDecoration(
              border: const Border(bottom: BorderSide(color: Colors.black),
                  top: BorderSide(color: Colors.black), left: BorderSide(color: Colors.black),
                  right: BorderSide(color: Colors.black)),
              borderRadius: const BorderRadius.all(Radius.circular(30),
              ),),
            height: 50,
            width: size.width*0.75,
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.search)),
                hintText: 'Search for location',
                contentPadding: EdgeInsets.only(left: 30),
                fillColor: Colors.white,
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(30),
                  ),
                ),),
              controller: searchController,
              onChanged: (value){
                if(value.isEmpty){
                  setState(() {

                  });


                }
              },
              onFieldSubmitted: (value){
                setState(() {
                  updateResult(value);
                });
              },


            ),
          ),

          leading: Padding(
            padding: const EdgeInsets.only(left: 11),
            child: TextButton(onPressed: (){

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoviesScreen(),
                  ));
             // Get.to(MoviesScreen());

            },
              child: Icon(Icons.arrow_back_ios),),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FutureBuilder<List<ClassModel>>(
                      future: searchedList,
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
            ),
          ],
        )
    );
  }
}