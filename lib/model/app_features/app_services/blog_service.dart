import 'dart:math';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/api_client.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/BlogRequest.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/commentRequest.dart';

import '../../general_services/exceptions.dart';
import '../../response/comment_on_blog_response.dart';
import '../../response/upload_blog_response.dart';
import '../endpoints/blog_endpointUrl.dart';


final blogProvider = Provider<BlogApiImpl>((ref){
  final apiClient = ref.watch(apiClientProvider);
  return BlogApiImpl(apiClient);
});

abstract class BlogApi{
  Future<Either<ApiException, UploadBlogResponse>> postBlog(BlogRequest blogRequest);
  Future<Either<ApiException, CommentBlogResponse>> replyBlog(CommentRequest commentRequest);
}

class BlogApiImpl implements BlogApi{
  BlogApiImpl(this.apiClient);
  ApiClient apiClient;
  @override
  Future<Either<ApiException, UploadBlogResponse>> postBlog(BlogRequest blogRequest) async{
    try{
      final httpResponse = await apiClient.post(
          BlogEndpoints.uploadBlog,
        data: blogRequest.toJson(),
      );
      final response = UploadBlogResponse.fromJson(httpResponse.data);
      return Right(response);

    } catch(err){
      if(err is DioException){
        return Left(ApiException.getException(err));
      }
      return Left(ApiException(err.toString()));
    }

  }

  @override
  Future<Either<ApiException, CommentBlogResponse>> replyBlog(CommentRequest commentRequest) async{

    try{
      final httpResponse = await apiClient.get(
        BlogEndpoints.commentOnBlog,
        data:  commentRequest.toJson(),
      );

     final  response = CommentBlogResponse.fromJson(httpResponse.data);
     return Right(response);
    } catch (err){
      if(err is DioException){
        return Left(ApiException.getException(err));
      }
      return Left(ApiException(err.toString()));
    }
    }
  }