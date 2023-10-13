import 'dart:io';
import 'package:employees_app/widgets/drawer.dart';
import 'package:employees_app/widgets/sized.dart';
import 'package:employees_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhoto extends StatefulWidget {
  final String photoText;
  final Function(File?) onImageSelected;
  const AddPhoto(
      {Key? key, required this.photoText, required this.onImageSelected})
      : super(key: key);

  @override
  State<AddPhoto> createState() => AddPhotoState();
}

class AddPhotoState extends State<AddPhoto> {
  ColorTheme instanceOfColor = ColorTheme(0);
  final String avtarDP = "lib/assets/avatar.webp";
  File? imageFromPhone;

  Future<void> galleryPicker() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imageFromPhone = File(imagePicked.path);
        // widget.onImageSelected(imageFromPhone); // Call the callback function
      });
    }
  }

  Future<void> cameraPicker() async {
    final imageClicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageClicked != null) {
      setState(() {
        imageFromPhone = File(imageClicked.path);
        //  widget.onImageSelected(imageFromPhone); // Call the callback function
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.photoText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDarkModeOn
                  ? instanceOfColor.greyColor
                  : instanceOfColor.blackColor),
        ),
        const Sized(heights: 10),
        Stack(
          children: [
            CircleAvatar(
              radius: 35,
              child: CircleAvatar(
                maxRadius: 50,
                backgroundImage: imageFromPhone != null
                    ? FileImage(imageFromPhone!) as ImageProvider<Object>?
                    : AssetImage(avtarDP),
              ),
            ),
            Positioned(
              bottom: -5,
              right: -5,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 100,
                        color: Colors.teal[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                cameraPicker();
                              },
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                galleryPicker();
                              },
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.photo_library,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.add_a_photo,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
