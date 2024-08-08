import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/model.dart/signupmodel.dart';

class DataManaging{

  late  Box<SignUpModel> _box;

  Future<void>openBox()async{
    print('box is starting soon');
     _box =  await Hive.openBox('signup');
     print("box is opened");
  }
 
 void  adduser(SignUpModel signUpModel)async{
  print(' this add is workinng now');
  await _box.add(signUpModel);

 }
   

    List<SignUpModel> getUsers() {
    return _box.values.toList();
  }



  SignUpModel? getUserAt(int index) {
    return _box.getAt(index);
  }

//   Future<void> saveLoginState() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('isLoggedIn', true);
// }
// Future<void> logout() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('isLoggedIn', false);
// }

}