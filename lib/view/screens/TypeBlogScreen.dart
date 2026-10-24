import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/internet/internet.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/BlogRequest.dart';
import '../../view_model/notifier/blog_notifier.dart';
import '../constants/strings.dart';
import 'BlogScreen.dart';

class TypeBlogScreen extends ConsumerStatefulWidget {
  const TypeBlogScreen({super.key});

 
  @override
  ConsumerState<TypeBlogScreen> createState() => _BlogScreenState();
}



class _BlogScreenState extends ConsumerState<TypeBlogScreen> {


  TextEditingController blogContentController = TextEditingController();
  TextEditingController blogTitleController = TextEditingController();




  Future<bool> noInternet() async{
    final connectivity = ref.read(internetProvider);
    if(connectivity.status == ConnectivityStatus.disconnected){
      WidgetsBinding.instance.addPostFrameCallback((_){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
              CustomStrings.noInternet1,
              textAlign: TextAlign.center,
            ))
        );
      });
      return true;
    }
    return false;
  }


  Future<bool> postBlog() async{
    if(await noInternet()) return false;
    if( blogContentController.text.isEmpty) return false;
    final success = ref.read(blogNotifierProvider.notifier).postBlog(
        BlogRequest(blogContent: blogContentController.text.trim(),
            blogTitle: blogTitleController.text.trim()));
    return success;

  }

  @override
  Widget build(BuildContext context) {
   final internetState = ref.watch(internetProvider);
   final blogRef = ref.watch(blogNotifierProvider);


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              width: 6,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                Border.all(color: Colors.red),),
              child: TextField(
                controller:  blogContentController,
                decoration: const InputDecoration(
                    hintText: 'Make a post',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20)
                ),
              ),
            ),
          ),
          TextButton(onPressed: () async{
            final success = await postBlog();
            if(!mounted) return;
            if(success){
              Navigator.of(context).pop();
            }

          }, child: const Text('Post')),

          
       //  Expanded(child: Text(data))



        ],
      ),

    );
  }
}