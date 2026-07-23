class UploadBlogResponse {
  UploadBlogResponse({
    required this.success,
    required this.responseCode,
    required this.responseMessage,
    required this.responseData,
  });

  final bool? success;
  final dynamic responseCode;
  final String? responseMessage;
  final ResponseData? responseData;

  UploadBlogResponse copyWith({
    bool? success,
    dynamic? responseCode,
    String? responseMessage,
    ResponseData? responseData,
  }) {
    return UploadBlogResponse(
      success: success ?? this.success,
      responseCode: responseCode ?? this.responseCode,
      responseMessage: responseMessage ?? this.responseMessage,
      responseData: responseData ?? this.responseData,
    );
  }

  factory UploadBlogResponse.fromJson(Map<String, dynamic> json){
    return UploadBlogResponse(
      success: json["success"],
      responseCode: json["responseCode"],
      responseMessage: json["responseMessage"],
      responseData: json["responseData"] == null ? null : ResponseData.fromJson(json["responseData"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "responseData": responseData?.toJson(),
  };

  @override
  String toString(){
    return "$success, $responseCode, $responseMessage, $responseData, ";
  }
}

class ResponseData {
  ResponseData({
    required this.blogpostId,
    required this.blogTitle,
    required this.blogContent,
    required this.timeCreated,
    required this.updatedAt,
    required this.commentsResponse,
    required this.blogImage,
    required this.likesCount,
    required this.userDto,
  });

  final String? blogpostId;
  final String? blogTitle;
  final String? blogContent;
  final dynamic timeCreated;
  final dynamic updatedAt;
  final dynamic commentsResponse;
  final dynamic blogImage;
  final int? likesCount;
  final UserDto? userDto;

  ResponseData copyWith({
    String? blogpostId,
    String? blogTitle,
    String? blogContent,
    dynamic? timeCreated,
    dynamic? updatedAt,
    dynamic? commentsResponse,
    dynamic? blogImage,
    int? likesCount,
    UserDto? userDto,
  }) {
    return ResponseData(
      blogpostId: blogpostId ?? this.blogpostId,
      blogTitle: blogTitle ?? this.blogTitle,
      blogContent: blogContent ?? this.blogContent,
      timeCreated: timeCreated ?? this.timeCreated,
      updatedAt: updatedAt ?? this.updatedAt,
      commentsResponse: commentsResponse ?? this.commentsResponse,
      blogImage: blogImage ?? this.blogImage,
      likesCount: likesCount ?? this.likesCount,
      userDto: userDto ?? this.userDto,
    );
  }

  factory ResponseData.fromJson(Map<String, dynamic> json){
    return ResponseData(
      blogpostId: json["blogpostId"],
      blogTitle: json["blogTitle"],
      blogContent: json["blogContent"],
      timeCreated: json["timeCreated"],
      updatedAt: json["updatedAt"],
      commentsResponse: json["commentsResponse"],
      blogImage: json["blog_image"],
      likesCount: json["likesCount"],
      userDto: json["userDTO"] == null ? null : UserDto.fromJson(json["userDTO"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "blogpostId": blogpostId,
    "blogTitle": blogTitle,
    "blogContent": blogContent,
    "timeCreated": timeCreated,
    "updatedAt": updatedAt,
    "commentsResponse": commentsResponse,
    "blog_image": blogImage,
    "likesCount": likesCount,
    "userDTO": userDto?.toJson(),
  };

  @override
  String toString(){
    return "$blogpostId, $blogTitle, $blogContent, $timeCreated, $updatedAt, $commentsResponse, $blogImage, $likesCount, $userDto, ";
  }
}

class UserDto {
  UserDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.profilePicture,
  });

  final String? id;
  final String? email;
  final String? firstName;
  final dynamic profilePicture;

  UserDto copyWith({
    String? id,
    String? email,
    String? firstName,
    dynamic? profilePicture,
  }) {
    return UserDto(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json){
    return UserDto(
      id: json["id"],
      email: json["email"],
      firstName: json["firstName"],
      profilePicture: json["profilePicture"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "profilePicture": profilePicture,
  };

  @override
  String toString(){
    return "$id, $email, $firstName, $profilePicture, ";
  }
}