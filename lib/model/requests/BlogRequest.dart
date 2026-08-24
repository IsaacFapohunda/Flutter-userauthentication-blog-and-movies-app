
class BlogRequest{

  BlogRequest({required this.blogContent, required this.blogTitle});

  final String blogTitle;
  final String blogContent;

  Map<String, dynamic> toJson(){
    return {
      'blogTitle': blogTitle,
      'blogContent': blogContent,

    };
  }

}