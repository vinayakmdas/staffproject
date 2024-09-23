

import 'package:hive_flutter/hive_flutter.dart';

part 'signupmodel.g.dart';

@HiveType(typeId: 0)
class SignUpModel{

@HiveField(0)
final String  username;

@HiveField(1)
 final  String  email;

 @HiveField(2)
    String password;
@HiveField(3)
  final  String conformpassword;

SignUpModel({ required this.username , required this.email ,required this.password,required this.conformpassword}

);

}