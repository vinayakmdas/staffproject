import 'package:hive_flutter/hive_flutter.dart';
part 'domainmodel.g.dart';

@HiveType(typeId: 1)
class   Domainmodel {
  @HiveField(0)
  final  String domain;



  Domainmodel({
    required this.domain
  });
}