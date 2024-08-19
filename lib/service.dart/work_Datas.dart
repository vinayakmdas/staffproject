

import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model.dart/work_model.dart';

class WorkDatas{

late Box<WorkModel>_box;

  Future <void>openBox()async{
    
    _box= await Hive.openBox<WorkModel>(" workdatas");
    print(" work box is open");
  }
  


}