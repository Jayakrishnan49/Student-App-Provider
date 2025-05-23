import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/studentmanagementprovider.dart';
import 'package:student_app_provider/utilities/customalertdialog.dart';
import 'package:student_app_provider/utilities/customcolor.dart';
import 'package:student_app_provider/view/edit%20student%20detail%20screen/editstudentdetailscreen.dart';
import 'package:student_app_provider/view/student%20detail%20screen/studentddetailsscreen.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController = Provider.of<StudentmanagmentControler>(context);
    
    return SizedBox(
      child: Consumer(
        builder: (context,studentcontroller,child) {
        final listItems=studentController.filteredItems();
        if(listItems.isEmpty){
          return Center(
            child: Text('No student found'),
          );
        }
        return ListView.builder(
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            final item = listItems[index];

            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetailScreen(student: item, index: index)));
                
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: (item.imagePath.isNotEmpty)
                      ? FileImage(File(item.imagePath))
                      : null,
                  child: (item.imagePath.isEmpty)
                      ? Icon(Icons.person, color: Colors.grey)
                      : null,
                ),
                title: Text(item.name),
                subtitle: Text(item.age.toString()),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          final orginalIndex=studentController.items.indexOf(item);
                          // if(orginalIndex!=1){
                            Navigator.of(context).push(MaterialPageRoute(builder:(context) => EditStudentDetailScreen(student: item, index: orginalIndex)));
                          // }
                        },
                        icon: Icon(Icons.edit, color: AppColor.primary),
                      ),
                   IconButton(
  onPressed: () {
    showDialog(context: context, builder:(context) {
                          
        return CustomAlertDialog(titleText: 'Delete Student', contentText: 'Are you sure you want to delete this student?', buttonText1: 'yes', buttonText2: 'no',
        onPressButton1: () {
          final orginalIndex=studentController.items.indexOf(item);
          // if(orginalIndex!=1){
            studentController.deleteUserRecords(orginalIndex);
          // }
        Navigator.pop(context);
       
                           }, onPressButton2: () { 
                            Navigator.pop(context);
                            },);
                        },);

                },
  icon: Icon(Icons.delete, color: Colors.red),
)
,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

