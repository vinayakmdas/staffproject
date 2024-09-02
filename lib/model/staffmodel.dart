import 'package:hive_flutter/hive_flutter.dart';
part 'staffmodel.g.dart';


@HiveType(typeId: 2)
class StaffModel extends HiveObject{

@HiveField(0)

final String username;



@HiveField(1)
final  String phonenumber;


@HiveField(2)
final String email;


@HiveField(3)
 final  String  domain;


@HiveField(4)
final String gender;


@HiveField(5)
  final String? image;

@HiveField(6)
final String ?proofimage;


StaffModel({ required this.username, required this.phonenumber,required this.email , required this.domain
,required this.gender, this.image,  this.proofimage
});

}