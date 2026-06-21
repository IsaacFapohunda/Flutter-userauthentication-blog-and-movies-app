// import 'package:springboot_flutter_bloggingapp/model/data/token_repository.dart';
//


//abstract class AuthApi{
// Future<Either<ApiException, String>> joinEvent(
//     Map<String, dynamic> request);
// Future<Either<ApiException, List<EventMembersData>>> getEventMembers(
//     Map<String, dynamic> request);
// }
//}




// class AppApiImpl extends AppApi{
//   final ApiClient client;
//   AppApiImpl({required this.client});

  //final TokenRepository _tokenRepository = Get.find();



// @override
// Future<Either<ApiException, List<EventMembersData>>> getEventMembers(
//     Map<String, dynamic> request) async {
//   try {
//
//
//     final httpResponse = await client.get(
//       "${Endpoints.event}members/${request['id']}/",
//
//     );
//     log("createEventForm res ${jsonEncode(httpResponse.data)}");
//     final response = List<EventMembersData>.from(httpResponse.data['data'].map((x) => EventMembersData.fromJson(x)));
//     // totalMessageCount = httpResponse[]
//     return right(response);
//   } catch (err) {
//     log(err.toString());
//
//     return left(ApiException(err.toString()));
//   }
// }




// @override
// Future<Either<ApiException, String>> joinEvent(
//     Map<String, dynamic> request) async {
//   try {
//
//
//     final httpResponse = await client.post(
//       "${Endpoints.event}join/",
//
//       data: request,
//     );
//     log("createEventForm res ${jsonEncode(httpResponse.data)}");
//     // totalMessageCount = httpResponse[]
//     return right("Event joined successfully");
//   } catch (err) {
//     log(err.toString());
//
//     return left(ApiException(err.toString()));
//   }
// }



//}