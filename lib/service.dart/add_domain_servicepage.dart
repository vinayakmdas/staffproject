import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/model.dart/domainmodel.dart';

class DomainBox {
  late Box<Domainmodel> _box;

  Future<void> openBox() async {
    print("Box is opening...");
    _box = await Hive.openBox<Domainmodel>("adddomain");
    print("Box is open");
  }

  Future<void> adddomain(Domainmodel domainmodel) async {
    if (!_box.isOpen) {
      await openBox();
    }
    await _box.add(domainmodel);
    print("Box added successfully");
  }


  Future <List<Domainmodel>>getDomain() async{
     
    
     return _box.values.toList();
  }
}
