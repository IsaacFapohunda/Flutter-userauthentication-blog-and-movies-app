import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/BlogRequest.dart';

import '../../model/app_features/app_services/blog_service.dart';
import '../../model/response/upload_blog_response.dart';

final blogNotifierProvider = StateNotifierProvider<BlogNotifier,
    AsyncValue<BlogResponse>>((ref){
  return BlogNotifier(ref.read(blogProvider));
});


class BlogNotifier extends StateNotifier<AsyncValue<BlogResponse>>{
  final BlogApi blogApi;
  BlogNotifier(this.blogApi) : super(const AsyncValue.loading());


  Future<bool> postBlog(BlogRequest blogRequest) async{
    final result = blogApi.postBlog(blogRequest);
    return result.fold(
            (error){
      state = AsyncValue.error(error, StackTrace.current);
      return false;
    }, (response){
      state = AsyncValue.data(response.responseData!);
      return true;
    });
  }


}