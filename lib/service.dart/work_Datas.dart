import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:staff/model.dart/work_model.dart';

class WorkDatas {

  ValueNotifier<List<WorkModel>>workNotifier=ValueNotifier<List<WorkModel>>([]);

  late Box<WorkModel> _box;

  Future<void> openBox() async {
    _box = await Hive.openBox<WorkModel>('workBox');
  }

  Future<List<WorkModel>> getdata() async {
    return _box.values.toList();
  }

  Future<void> addWork(WorkModel work) async {
    int id = await _box.add(work);
    work.id = id;
    await _box.put(id, work);
  }

  Future<void> edit(WorkModel work) async {
    if (work.id != null) {
      await _box.put(work.id, work);
    }
  }
}

