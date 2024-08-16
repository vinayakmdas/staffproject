
import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model.dart/project_model.dart';

class ProjectData{


late Box<ProjectModel>_box;


Future<void>openBox()async{

  _box=  await Hive.openBox<ProjectModel>("Projecttask");
}

}