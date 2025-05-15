import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/studentmanagementprovider.dart';
import 'package:student_app_provider/model/student%20details%20db/studentdetailsdb.dart';
import 'package:student_app_provider/utilities/customcolor.dart';
import 'package:student_app_provider/view/homescreen/homescreen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>('studentBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentmanagmentControler(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.secondary),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
