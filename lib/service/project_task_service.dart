
import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model/project_model.dart';

class ProjectData{

  late Box<ProjectModel>_box;

  Future<void> openBox() async {
    _box = await Hive.openBox<ProjectModel>("Projecttask");
  }

  Future<void> addProject(ProjectModel project) async {
    if (!_box.isOpen) {
      await openBox();  
    }
    await _box.add(project);
    print("Add is successful");
  }
  Future<List<ProjectModel>>getprojectdata()async{
      
       return _box.values.toList();
  }
  Future<void>deletelist(int index)async{
   _box.deleteAt(index);
  }

}