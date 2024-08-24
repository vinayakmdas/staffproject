import 'package:flutter/material.dart';
import 'package:staff/add-staff-and-work/workadd.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textcostom.dart';
import 'package:staff/custum.dart/textfield.dart';
import 'package:staff/editsreen.dart/workview.dart';
import 'package:staff/model.dart/complete_model.dart';
import 'package:staff/model.dart/work_model.dart';
import 'package:staff/service.dart/complete_service.dart';
import 'package:staff/service.dart/work_Datas.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  final worksearchcontroller = TextEditingController();
  final WorkDatas _workDatas = WorkDatas(); 
  final Complete_Datas _complete_datas = Complete_Datas();
  List<WorkModel> _list = [];
  List<WorkModel> workvalues = [];

  Future<void> datasave(WorkModel work, int index) async {
    
    CompleteModel completeModel = CompleteModel(
      staffname: work.staffname,
      domainname: work.domainname,
      project: work.project,
      calendarDate: work.calendarDate,
      fileproperties: work.fileproperties,
      description: work.description,
    );
    await _complete_datas.add(completeModel);

    // Delete the work from the current list and Hive box
    await _workDatas.delete(index);
    setState(() {
      workvalues.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _workDatas.openBox().then((_) {
      loadwork();
    });
  }

  @override
  void dispose() {
    worksearchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CostomSerchBar(controller: worksearchcontroller),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: workvalues.length,
              itemBuilder: (context, index) {
                final work = workvalues[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      navigatepush(
                        context,
                        Workview(
                          work: work,
                        ),
                      );
                    },
                    title: Text(work.staffname),
                    subtitle: Text(work.project),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            pending(context, work, index); // Pass the index here
                          },
                          child: const Apptext("Pending", Colors: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          navigatepush(context, const Workadd());
        },
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      ),
    );
  }

  Future<void> loadwork() async {
    List<WorkModel> workList = await _workDatas.getdata();
    setState(() {
      _list = workList;
      workvalues = List.from(_list);
    });
    await _complete_datas.openbox();
  }

  void _onsearchchanged() {
    String query = worksearchcontroller.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        workvalues = List.from(_list);
      } else {
        workvalues = _list.where((work) {
          return work.staffname.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void pending(BuildContext context, WorkModel work, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green,
        title: const Apptext("Complete the work", Colors: Colors.white),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Apptext("Cancel", Colors: Colors.red),
          ),
          ElevatedButton(
            onPressed: () async {
              await datasave(work, index);
              Navigator.of(context).pop();
            },
            child: const Apptext("Complete", Colors: Colors.green),
          ),
        ],
      ),
    );
  }
}
