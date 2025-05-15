import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/studentmanagementprovider.dart';
import 'package:student_app_provider/utilities/customcolor.dart';


class CustomBottomSheet extends StatelessWidget {
  final Function(String) onImagePicked;

  const CustomBottomSheet({
    super.key,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    final studentController = Provider.of<StudentmanagmentControler>(context);

    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconColumn(
            context: context,
            icon: Icons.camera,
            label: 'Camera',
            onTap: () async {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
              studentController.selectedImagePath = pickedFile.path;
                onImagePicked(pickedFile.path);
              }
              Navigator.pop(context);
            },
          ),
          _buildIconColumn(
            context: context,
            icon: Icons.image,
            label: 'Gallery',
          onTap: () async {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
              studentController.selectedImagePath = pickedFile.path;
                onImagePicked(pickedFile.path);
              }
               Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconColumn({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.subTitle),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: onTap,
              icon: Icon(icon, size: 30),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}
