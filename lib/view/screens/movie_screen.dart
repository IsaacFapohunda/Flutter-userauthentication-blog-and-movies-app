import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:springboot_flutter_bloggingapp/view_model/widgets/no_internet_widget.dart';
import '../../model/internet/internet.dart';
import '../../model/notifier/movie_notifier.dart';
import '../../model/theme/app_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/constants/textstyle.dart';





class MoviesScreen extends ConsumerStatefulWidget {

  const MoviesScreen({super.key});

  @override
  ConsumerState<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {

  TextEditingController movieNameController = TextEditingController();

  bool isLoading = false;
  bool isConnected = false;

  void movieSearch() async{
    final param = movieNameController.text.trim();
    if(param.isEmpty){
      ref.read(movieNotifierProvider.notifier).fetchMovies();

    }
    ref.read(movieNotifierProvider.notifier).searchMovies(movieNameController.text);

  }

  @override
  Widget build(BuildContext context) {

    final internetState =  ref.watch(internetProvider);
    Size size = MediaQuery.of(context).size;
    final movieRef = ref.watch(movieNotifierProvider);

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if(internetState.status == ConnectivityStatus.connected){

      return Scaffold(
        appBar: AppBar(

          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red,
                  ),
                  onPressed: (){
                  }, child: Text('Discover Trending movies Movies', style: appbartextStyle(),),
                ),

                SizedBox(
                  width: size.width*0.04,
                ),

                Expanded(
                  child: Container(
                    width: 6,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:
                      Border.all(color: Colors.red),),
                    child: TextField(
                      controller: movieNameController,
                      onChanged: (value){
                        movieSearch();
                      },
                      decoration: const InputDecoration(
                          hintText: 'Enter movie name',

                          // suffixIcon: IconButton(
                          //     onPressed: () {
                          //         setState(() {
                          //
                          //         });
                          //     },
                          //     icon: const Icon(
                          //                 Icons.search,
                          //                 color: Colors.black,
                          //                 size: 15)
                          // ),

                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),


          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,),
            onPressed: Navigator.of(context).pop,
          ),
        ),
        body:
        movieRef.when(
            data: (movies){
              return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index){
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        //color:kWhite,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kSecondaryColor,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500/${movie.backdropPath}" ?? '',
                                  //  "http://image.tmdb.org/t/p/w1280/" + snapshot.data![index].backdrop_paths,
                                  height: 250,
                                ),

                              ),

                              SizedBox(height: size.height*0.007,),
                              Center(child: Text(movie.originalTitle ?? '', style: headline3(kBlack))),
                              SizedBox(height: size.height*0.005,),
                              Text("Overview: ${movie.overview ?? 'No overview'}", style: headline4(kBlack)),
                              SizedBox(height: size.height*0.005,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Original Language: ${movie.originalLanguage}" ?? 'N/A', style: headline3(kSecondaryColor)),
                                  SizedBox(width: size.width*0.33,),
                                  Text("Release date: ${movie.releaseDate}" ?? 'Unknown', style: headline3(kSecondaryColor))
                                ],
                              )
                            ],
                          ),
                        ),

                      ),
                    );
                  });
            }, error: (err, _){

          Text('Error: $err');
        },
            loading: (){
              return Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? kWhite
                          : kBlack, size: 25));
            }),


      );
    } else{
      return const NoInternetWidget();
    }
  }
}