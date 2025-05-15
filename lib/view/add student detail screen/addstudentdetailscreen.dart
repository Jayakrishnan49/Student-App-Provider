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

class AddStudentDetailScreen extends StatelessWidget {
  const AddStudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<StudentmanagmentControler>(context, listen: false);
        // .clearSelectedImage();
  // });
    // Provider.of<StudentmanagmentControler>(context, listen: false).clearSelectedImage();

    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController phnoController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    //  final studentController = Provider.of<StudentmanagmentControler>(context);

    // studentController.selectedImagePath = student.imagePath;

    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.secondary),
        backgroundColor: AppColor.primary,
        title: Text(
          'Add student details',
          style: TextStyle(
            color: AppColor.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: 
      Consumer<StudentmanagmentControler>(
        builder: (context, studentController, child) {
          log('inside');
          return Form(
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
                      child:
                          studentController.selectedImagePath.isNotEmpty
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(studentController.selectedImagePath.toString()),
                                  fit: BoxFit.cover,
                                ),
                              )
                              : const Center(child: Text('No image added')),
                    ),

                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Add Image',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return CustomBottomSheet(
                              onImagePicked: (imagePath) {
                                studentController.setImagePath(imagePath);
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Student name*'),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: nameController,
                          width: 400,
                          borderRadius: 15,
                          hintText: 'Add student name',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                            return 'enter student name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        const Text('Age*'),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: ageController,
                          width: 400,
                          borderRadius: 15,
                          hintText: 'Add age',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                            return 'enter age';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 25),
                        const Text('Phone number*'),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: phnoController,
                          width: 400,
                          borderRadius: 15,
                          hintText: 'Add phone number',
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
                    const SizedBox(height: 70),
                    CustomButton(
                      text: 'Save Details',
                      width: 400,
                      borderRadius: 10,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          final student = StudentModel(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            phoneNumber: phnoController.text,
                            imagePath: studentController.selectedImagePath,
                          );
                          studentController.addUserRecords(student);
                          CustomSnackbar.show(
                            context: context,
                            text: 'Student details added successfully!',
                            backgroundColor: AppColor.success,
                          );
                          Navigator.pop(context); 
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
