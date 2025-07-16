import 'dart:io';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
final void Function (File image) onImagePick;

  const UserImagePicker({super.key, required this.onImagePick});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150
      );

  if(pickedImage != null){
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  widget.onImagePick(_image!);
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.backgroundColor,
          backgroundImage: _image != null ? FileImage(_image!) : const AssetImage('assets/images/avatar.png'),
          foregroundColor: AppColors.secondaryColor0,
        ),
        TextButton(
          onPressed: _pickImage, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image, color: AppColors.secondaryColor0,
              ),
              SizedBox(),
              Text('Adicionar nova imagem',
              style: Theme.of(context).textTheme.headlineSmall),
            ],
          )
        )
      ],
    );
  }
}