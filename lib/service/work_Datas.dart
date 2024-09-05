

import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model/work_model.dart';

class WorkDatas{

late Box<WorkModel>_box;

  Future <void>openBox()async{
    
    _box= await Hive.openBox<WorkModel>(" workdatas");
    print(" work box is open");
  }
  
   Future <void> addwork(WorkModel workmodel)async{
    _box.add(workmodel);
   }
  Future<List<WorkModel>>getdata()async{
    return _box.values.toList();

  }
   Future<void>delete(int index)async{
    _box.deleteAt(index);
   }
    Future<void>updatevalue( int index,WorkModel update)async{
    print("before  open update box");
     _box.putAt( index, update);
     print("complet update");
  }
}