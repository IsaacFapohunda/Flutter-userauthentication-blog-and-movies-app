// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// import '../../model/internet/internet.dart';
// import '../../view_model/utilities.dart';
// import '../utilities/app_button.dart';
// import '../utilities/app_color.dart';
// import '../utilities/back_button.dart';
// import 'package:mime/mime.dart';
// // import 'package:myroute/flows/registration/AddPayment/views/addPayment.dart';
// // import 'package:myroute/flows/registration/Reg_global_File/globalfile.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:myroute/services/connectivity_provider.dart';
// // import '../../../../constants/app_color.dart';
// // import '../../../../constants/app_image.dart';
// // import '../../../../services/update_dp.dart';
// // import '../../../../services/user_authentication.dart';
// // import '../../ninRegistration.dart';
// // import '../utilities.dart';
//
// class AddProfilePic extends ConsumerStatefulWidget {
//   final String email;
//   const AddProfilePic({
//     super.key,
//     required this.email,
//   });
//
//   ConsumerState<AddProfilePic> createState() => _AddProfilePicState();
// }
//
// class _AddProfilePicState extends ConsumerState<AddProfilePic> {
//   XFile? _imageFile;
//   bool isLoading = false;
//
//
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordCcontroller = TextEditingController();
//   TextEditingController passwordCcontroller2 = TextEditingController();
//   var sex = "Male";
//
//   String dataUri = '';
//
//   bool isImageGood() {
//     return _imageFile != null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final internetState = ref.watch(internetProvider);
//     final imageUploadref = ref.watch(userImageProvider);
//     //final Imageref = ref.watch(profilePicProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: AppBackButton(),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: Text('Title'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//               "Add a profile picture",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Upload your picture",
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Make sure it meets the requirements",
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Clearly visible face \nNo sunglasses\nGood lighting, no filters.",
//               style: TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Center(
//                 child: Stack(
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: _imageFile == null
//                         ? Image.asset(userIcon).image
//                         : FileImage(File(_imageFile!.path)),
//                   ),
//                   Positioned(
//                     bottom: 9,
//                     right: 15,
//                     child: GestureDetector(
//                       onTap: () async {
//                         ImageUploadref.uploadImage(context, (pickedImg) async {
//                           setState(() {
//                             _imageFile = pickedImg;
//                             isLoading = true;
//                           });
//                           List<int> imageBytes = await pickedImg.readAsBytes();
//                           String imageBase64 = base64Encode(imageBytes);
//                           imageBase64 = imageBase64.replaceAll('/', '');
//                           final String? mimeType =
//                               lookupMimeType('', headerBytes: imageBytes);
//
//                           setState(() {
//                             isLoading = false;
//                             dataUri = "data:$mimeType;base64,$imageBase64";
//
//                           });
//                           print(dataUri);
//                         });
//                       },
//                     child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: primaryColor,
//                           ),
//                           shape: BoxShape.circle,
//                           color: kWhite,
//                         ),
//                         child: const Icon(Icons.edit)),
//                   ),
//                 )
//               ],
//             )),
//             const SizedBox(
//               height: 20,
//             ),
//
//             Container(
//                 child: isLoading
//                     ? Center(
//                     child: LoadingAnimationWidget.inkDrop(
//                         color: primaryColor, size: 25))
//                     :
//                     AppButton(
//                         textColor: kWhite,
//                         onPressed: () async {
//                           if (internetState.status ==
//                               ConnectivityStatus.disconnected) {
//                             WidgetsBinding.instance.addPostFrameCallback((_) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                     'No internet connection',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               );
//                             });
//                           } else {
//                             setState(() {
//                               isLoading = true;
//                             });
//
//                             if (_imageFile != null) {
//                               var imageResponse = await Imageref.addProfilePic(
//                                   widget.email, dataUri);
//                               print(imageResponse);
//                               print(dataUri);
//                               if (imageResponse == 'updated') {
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const MainPage(),
//                                   ),
//                                 );
//                               }
//                             } else {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             }
//                           }
//                         },
//                         label: "Submit",
//                       )),
//
//             TextButton(onPressed: (){}, child: const Text('Skip')),
//           ],
//         ),
//       ),
//     );
//   }
// }