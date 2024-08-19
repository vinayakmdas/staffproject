
   import 'package:hive_flutter/hive_flutter.dart';

part 'work_model.g.dart';

@HiveType(typeId: 4)
class WorkModel{

@HiveField(0)
 final String  staffname;

@HiveField(1)
 final String domainname;

 @HiveField(2)
 final String project;

@HiveField(3)
 final DateTime calendarDate;
@HiveField(4)
final String  fileproperties;
@HiveField(5)
final String   description;

WorkModel({ required this.staffname ,required this.domainname ,
 required this.project , required this.calendarDate
,required this.fileproperties, required this.description
});

}


