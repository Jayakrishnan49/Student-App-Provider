import 'package:hive/hive.dart';

part 'studentdetailsdb.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {

  @HiveField(0)
  String ?id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int age;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String imagePath;

  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.imagePath,
  });
}
