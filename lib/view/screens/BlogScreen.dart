import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../model/notifier/blog_notifier.dart';
import '../../model/theme/app_color.dart';
import 'TypeBlogScreen.dart';



class BlogScreen extends ConsumerStatefulWidget {
  const BlogScreen({super.key});

  @override
  ConsumerState<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends ConsumerState<BlogScreen> {
  @override

  Widget build(BuildContext context) {
    final blogRef = ref.watch(blogNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          const Text("BM App",),


          Expanded(
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              const TypeBlogScreen()));
            }, child: const Text('Post Blog')),
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
      body: Container(
        decoration: const BoxDecoration(
      gradient: LinearGradient(
      colors: [Colors.white, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),

    ),
        child: blogRef.when(
            data: (result){
              Text(result.blogTitle!);
              Text(result.blogContent!);
            }, error: (err, _){
          Text('Error: $err');
        }, loading: (){
          return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? kWhite
                      : kBlack, size: 25));
        }),
      )
    );
  }
}