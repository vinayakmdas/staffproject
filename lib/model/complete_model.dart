import 'package:hive_flutter/hive_flutter.dart';

part 'complete_model.g.dart';

@HiveType(typeId: 5)
class CompleteModel{
 


@HiveField(0)
 final String  staffname;

@HiveField(1)
 final String domainname;

 @HiveField(2)
 final String project;

@HiveField(3)
 final DateTime calendarDate;
@HiveField(4)
final String ? fileproperties;
@HiveField(5)
final String   description;

CompleteModel({ required this.staffname ,required this.domainname ,
 required this.project , required this.calendarDate
,required this.fileproperties, required this.description
});



}