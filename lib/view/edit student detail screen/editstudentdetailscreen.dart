import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/studentmanagementprovider.dart';
import 'package:student_app_provider/model/student%20details%20db/studentdetailsdb.dart';
import 'package:student_app_provider/utilities/custombottomsheet.dart';
import 'package:student_app_provider/utilities/custombutton.dart';
import 'package:student_app_provider/utilities/customcolor.dart';
import 'package:student_app_provider/utilities/customsnackbar.dart';
import 'package:student_app_provider/utilities/customtextformfield.dart';

class EditStudentDetailScreen extends StatelessWidget {
  final StudentModel student;
  final int index;

  const EditStudentDetailScreen({
    super.key,
    required this.student,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age.toString());
    final phnoController = TextEditingController(text: student.phoneNumber);
    final formKey = GlobalKey<FormState>();

    final studentController = Provider.of<StudentmanagmentControler>(context);

    studentController.selectedImagePath = student.imagePath;

    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.secondary),
        backgroundColor: AppColor.primary,
        title: Text(
          'Edit Student Details',
          style: TextStyle(
            color: AppColor.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<StudentmanagmentControler>(
        builder: (context,studentController,child) => Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: studentController.selectedImagePath.isNotEmpty
                      ? ClipRRect(
                          child: Image.file(
                            File(studentController.selectedImagePath),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(child: Text('No image added')),
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Change Image',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return CustomBottomSheet(onImagePicked: (imagePath) {
                          studentController.selectedImagePath = imagePath;
                          log(studentController.selectedImagePath);
                          log(imagePath);
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Student name*'),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: nameController,
                      width: 400,
                      borderRadius: 15,
                      hintText: 'Enter student name',
                      validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                            return 'enter student name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 25),
                    Text('Age*'),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: ageController,
                      width: 400,
                      borderRadius: 15,
                      hintText: 'Enter age',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                            return 'enter age';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 25),
                    Text('Phone number*'),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: phnoController,
                      width: 400,
                      borderRadius: 15,
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                            return 'enter the phone  Number';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
                SizedBox(height: 70),
                CustomButton(
                  text: 'Update Details',
                  width: 400,
                  borderRadius: 10,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final updatedStudent = StudentModel(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        phoneNumber: phnoController.text,
                        imagePath: studentController.selectedImagePath,
                      );

                      studentController.editUserRecords(updatedStudent, index);
                      Navigator.pop(context);
                      CustomSnackbar.show(
                        context: context,
                        text: 'Student details updated successfully!',
                        backgroundColor: AppColor.success,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
