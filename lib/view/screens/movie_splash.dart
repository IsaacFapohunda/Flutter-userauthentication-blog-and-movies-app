import 'package:flutter/material.dart';
import '../../model/theme/app_color.dart';
import '../utilities/app_image.dart';
import '../utilities/textstyle.dart';
import 'movie_screen.dart';


class Splash1 extends StatefulWidget {
  Splash1({super.key,});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {

  @override


  navigat() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesScreen(),
          ));
    });
  }

  @override

  Widget build(BuildContext context) {
    //final movieRequestRef = ref.watch()
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: primaryColor,
        body:
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                  width: size.width*0.8,
                  height: size.width*0.8,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(tv),
                      fit: BoxFit.fitWidth,
                    ),
                  )),


              Text('Welcome to the world of Movies', style:
              apptextwhite(),),


              Container(
                color: Colors.brown,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MoviesScreen()));
                //  Get.to(MoviesScreen());
                  print('boy');
                }, child:   Text('Get Started', style:
                apptextwhite(),),),
              )


            ],
          ),
        )
    );
  }
}