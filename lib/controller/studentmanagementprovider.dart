import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_provider/model/student%20details%20db/studentdetailsdb.dart';


class StudentmanagmentControler extends ChangeNotifier {
    final Debouncer debouncer = Debouncer(delay: Duration(milliseconds: 500));
    List<StudentModel> items = [];
  String searchItems = '';
  String selectedImagePath = '';

StudentmanagmentControler() {
  loadStudents();
}

  void setImagePath(String path) {
  selectedImagePath = path;
  notifyListeners();
}


  void loadStudents() {
    final userRecordData = Hive.box<StudentModel>('studentBox');
    items = userRecordData.values.toList();
    notifyListeners();
  }

  void addUserRecords(StudentModel value) {
    final userRecordData = Hive.box<StudentModel>('studentBox');
    userRecordData.add(value);
    items.add(value); 
 for (final item in items) {
      log("Added Item: ${item.name}, Age: ${item.age}, Image Path: ${item.imagePath}");
    } 
    clearSelectedImage();
    notifyListeners();
  }

  void editUserRecords(StudentModel value, int index) {
    final userRecordData = Hive.box<StudentModel>('studentBox');
    userRecordData.putAt(index, value);
    items[index] = value;
    selectedImagePath = '';
    notifyListeners();
  }

void deleteUserRecords(int index) {
  final userRecordData = Hive.box<StudentModel>('studentBox');
  userRecordData.deleteAt(index);
  items.removeAt(index);
  notifyListeners();
}
  List<StudentModel> filteredItems() {
    if (searchItems.isEmpty) {
      return items;
    } else {
      return items
          .where((student) =>
              student.name.toLowerCase().contains(searchItems.toLowerCase()))
          .toList();
    }
  }

void searchStudents(String value){
  debouncer.run((){
    searchItems=value;
    notifyListeners();
  });
  notifyListeners();
}

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath= image.path;
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath= image.path;
      notifyListeners();
    }
  }
  void clearSelectedImage() {
  selectedImagePath = '';
  notifyListeners();
}

}

/////  debounce
class Debouncer {
  final Duration delay;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}