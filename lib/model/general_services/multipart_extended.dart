import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
//import 'package:get/get_connect/http/src/multipart/multipart_file.dart';


class MultipartFileExtended extends MultipartFile {
  final String? filePath; //this one!

  MultipartFileExtended(
      Stream<List<int>> stream,
      length, {
        filename,
        this.filePath,
        contentType,
      }) : super(stream, length, filename: filename, contentType: contentType);

  static MultipartFileExtended fromFileSync(
      String filePath, {
        String? filename,
      }) =>
      multipartFileFromPathSync(filePath,
        filename: filename,);
}

MultipartFileExtended multipartFileFromPathSync(
    String filePath, {
      String? filename,
    }) {
  filename = filePath.split('/').last;
  var file = File(filePath);
  var length = file.lengthSync();
  var stream = file.openRead();
  return MultipartFileExtended(
    stream,
    length,
    filename: filename,
    filePath: filePath,
  );
}