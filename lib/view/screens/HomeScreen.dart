import 'dart:async';
import 'package:flutter/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/scheduler.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/movie_screen.dart';

import '../../model/data/token_repository.dart';
import '../../model/gen/assets.gen.dart';
import '../../model/theme/app_color.dart';
import '../../view_model/constants/strings.dart';
import 'BlogScreen.dart';
import 'TypeBlogScreen.dart';

class HomeScreen extends ConsumerStatefulWidget {


  const HomeScreen({
    super.key,

  });

  @override
  ConsumerState<HomeScreen> createState() => _PassengerHomeState();
}

class _PassengerHomeState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
 
  }

  

  @override
  Widget build(BuildContext context) {
    final tokenRef = ref.watch(tokenRepositoryProvider);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(

          ),
          drawer: AppDrawer(
              name: tokenRef.getUserCredentials().user?.responseData?.firstName
          ),
          body: Stack(
            children: [
              const Text(CustomStrings.onboardingMessage),

              DecoratedBox(decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

              ), child: Center(
                child: Assets.pngs.autoLayoutHorizontal.image(),
              ),
              ),
            ],
          )),
    );
  }
}

class AppDrawer extends ConsumerWidget {
  //final String name;
  const AppDrawer({
   // required this.name,
    super.key, required name,
  });

  @override
  Widget build(BuildContext context, ref) {
   
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: kBlack,
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(Icons.supervised_user_circle)),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kPrimaryColor,
                                ),
                                shape: BoxShape.circle,
                                color: kWhite,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 15,
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child:
                        Text('Isaac', style: TextStyle(color: Colors.white),),

                  )
                ],
              )),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('Movies'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MoviesScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_outlined),
            title: const Text('Blogs'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BlogScreen()));
            },
          ),

          Container(
            color: grey5,
            height: 5,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}