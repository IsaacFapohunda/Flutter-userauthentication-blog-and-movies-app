import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/utilities/app_color.dart';

final userImageProvider = Provider<ImageUpload>((ref) => ImageUpload());
class ImageUpload{
  XFile? pickedImg;
  final ImagePicker _picker = ImagePicker();
  int? imageQuality;

  void _pickImg(ImageSource source, void Function(XFile pickedImg) imgPickFn) async {
    final pickedImgFile = await _picker.pickImage(source: source, imageQuality: imageQuality);
    if (pickedImgFile !=null){
      pickedImg = XFile(pickedImgFile.path);
      imgPickFn(XFile(pickedImgFile.path));
    }
  }


  uploadImage(context, void Function(XFile pickedImg) imgPickFn){
    return showModalBottomSheet(
      context: context,
      builder: (context) => SelectOptions(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: (){
                Navigator.pop(context);
                _pickImg(ImageSource.camera, imgPickFn);
              }, icon: const Icon(Icons.photo_camera,
              size: 50,
              color: primaryColor,
            ),
              label: const Text('Camera',
                style: TextStyle(
                  color: primaryColor,
                ),
              ),),
            TextButton.icon(
              onPressed: (){
                Navigator.pop(context);
                _pickImg(ImageSource.gallery, imgPickFn);
              }, icon: const Icon(Icons.file_copy,
              size: 50,
              color: primaryColor,
            ),
              label: const Text('Gallery',
              style: TextStyle(
                color: primaryColor,
              ),
              ),
              ),
          ],
        ),
      ),);
  }
}

class SelectOptions extends StatelessWidget {
  const SelectOptions({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}