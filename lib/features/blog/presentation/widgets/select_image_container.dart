import 'dart:io';
import 'package:devblogs/core/theme/app_pallete.dart';
import 'package:devblogs/core/utils/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SelectImageContainer extends StatefulWidget {
  final File? selectedImage;
  final ValueChanged<File> onImageSelected;

  const SelectImageContainer({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
  });

  @override
  State<SelectImageContainer> createState() => _SelectImageContainerState();
}

class _SelectImageContainerState extends State<SelectImageContainer> {
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      widget.onImageSelected(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedImage != null
        ? GestureDetector(
            onTap: () {
              selectImage();
            },
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(widget.selectedImage!, fit: BoxFit.cover),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              selectImage();
            },
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: const Radius.circular(10),
                color: AppPallete.borderColor,
                strokeWidth: 1,
                strokeCap: StrokeCap.round,
                dashPattern: const [10, 4],
                padding: EdgeInsets.zero,
              ),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 40),
                    Gap(15),
                    Text('Select Your Image', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          );
  }
}
