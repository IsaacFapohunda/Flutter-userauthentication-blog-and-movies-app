class UploadDpRequest{
  ///my s3 bucket free session expired for the month

  UploadDpRequest({required this.profilePictureString, required this.userId});

  final String profilePictureString;
  final String userId;

  @override

  Map<String, dynamic> toJson(){
    return {
      'profilePictureString' : profilePictureString,
      'userId': userId,
    };
  }


}