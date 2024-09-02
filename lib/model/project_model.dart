import 'package:hive_flutter/hive_flutter.dart';
part 'project_model.g.dart';

@HiveType(typeId: 3)
class ProjectModel{

@HiveField(0)
final  String projet;

ProjectModel({required this.projet});

}