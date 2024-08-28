


import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model/staffmodel.dart';

class StaffDatas{

  late  Box<StaffModel> _box;

  
  Future<void>openbox()async{
    print(" box is opening soon staff");
    _box= await Hive.openBox<StaffModel>("staffdetails");
    print(" staff box is  open ");
  }

  Future<void> adddetails(StaffModel staffmodel)async{
    print("staff adding working soon");
  await  _box.add(staffmodel);
  print("staff add is succes ");
  }


  Future<List<StaffModel>>getstaffdetails()async{
    return _box.values.toList();
  }

  Future<void>updatevalue( int index,StaffModel update)async{
    print("before  open update box");
     _box.putAt( index, update);
     print("complet update");
  }

  Future<void>delete(int index)async{

  _box.deleteAt(index);
  }

}