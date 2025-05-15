
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/studentmanagementprovider.dart';
import 'package:student_app_provider/utilities/customcolor.dart';
import 'package:student_app_provider/utilities/gridstudentwidget.dart';
import 'package:student_app_provider/utilities/liststudentwidget.dart';
import 'package:student_app_provider/view/add%20student%20detail%20screen/addstudentdetailscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primary,
            title: const Text(
              'Student Details',
              style: TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<StudentmanagmentControler>(
                  builder: (context, studentProvider, child) {
                    return TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        studentProvider.searchStudents(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: AppColor.subTitle),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: AppColor.primary, width: 2.0),
                        ),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    );
                  },
                ),
              ),
              const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list, color: AppColor.primary)),
                  Tab(icon: Icon(Icons.grid_3x3_rounded, color: AppColor.primary)),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ListStudentWidget(),
                    GridStudentWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddStudentDetailScreen()),
            );
          },
          label: const Icon(Icons.add, color: AppColor.secondary),
        ),
      ),
    );
  }
}
