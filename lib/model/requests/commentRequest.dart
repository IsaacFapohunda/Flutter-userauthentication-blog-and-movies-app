
//https://springbootrolebaseauth.onrender.com/api/v1/role_base/blogComment?blogPostId=040183d1-fe88-4c74-81a2-3ba54142dbc2




class CommentRequest{

  CommentRequest({required this.comment});

  final String comment;

  Map<String, dynamic> toJson(){
    return {
      'comment': comment,

    };
  }

}