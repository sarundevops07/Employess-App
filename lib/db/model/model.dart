import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class EmployeeModel {
  @HiveField(0)
  int? deletionKey;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String salary;
  @HiveField(3)
  final String domain;
  @HiveField(4)
  final String age;
  @HiveField(5)
  final String imageFromPhone;
  EmployeeModel(
      {required this.age,
      required this.domain,
      required this.name,
      required this.salary,
      required this.imageFromPhone,
      this.deletionKey});
}
