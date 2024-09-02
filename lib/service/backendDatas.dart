

import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model/backend_model.dart';

class BackendDatas {


  late Box<BackendModel>_box;

    Future<void> openBox() async {
    _box = await Hive.openBox<BackendModel>("backendmodel");
  }
   Future<void> addProject(BackendModel backendmoedel) async {
    if (!_box.isOpen) {
      await openBox();  
    }
    await _box.add(backendmoedel);
    print("Add is successful");
  }
   Future<List<BackendModel>>getbackenddata()async{
      
       return _box.values.toList();
  }
  Future<void>deletelist(int index)async{
   _box.deleteAt(index);
  }




}