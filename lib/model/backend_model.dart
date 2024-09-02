import 'package:hive_flutter/hive_flutter.dart';
part 'backend_model.g.dart';

@HiveType(typeId: 6)
class BackendModel{
  @HiveField(0)
  final String backend;

  BackendModel({required this.backend});
}
