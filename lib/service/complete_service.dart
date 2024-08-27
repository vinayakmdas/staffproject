
import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model.dart/complete_model.dart';


class Complete_Datas{

late  Box<CompleteModel>_box;

 Future<void>openbox()async  {

   _box= await Hive.openBox <CompleteModel>('complete');
 }

    Future<void>add(CompleteModel completemodel)async{
      _box.add(completemodel);
      
    }
    Future<void>delete(int  index)async{
    _box.deleteAt(index);
   }
    Future<List<CompleteModel>>getdata()async{
      return _box.values.toList();
    }
    

}
