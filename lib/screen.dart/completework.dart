import 'package:flutter/material.dart';
import 'package:staff/add-staff-and-work/workadd.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textcostom.dart';
import 'package:staff/custum.dart/textfield.dart';
import 'package:staff/model.dart/work_model.dart';
import 'package:staff/service.dart/work_Datas.dart';

class Completwork extends StatefulWidget {
  const Completwork({super.key});

  @override
  State<Completwork> createState() => _CompletworkState();
}

class _CompletworkState extends State<Completwork> {
  final worksearchcontroller = TextEditingController();
  final WorkDatas _workDatas = WorkDatas();
  List<WorkModel> _list = [];
  List<WorkModel> workvalues = [];

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
            child: ValueListenableBuilder<List<WorkModel>>(
              valueListenable: _workDatas.workNotifier,
              builder: (context, value, _) {
                final work = value.where((element) => element.status).toList();
                return ListView.builder(
                  itemCount: work.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          // navigatepush(
                          // //   context,
                          // //   Workview(work: work[index]),
                          // // );
                        },
                        title: Text(work[index].staffname),
                        subtitle: Text(work[index].project),
                        trailing: TextButton(
                          onPressed: () {
                            showPendingDialog(work[index]);
                          },
                          child: const Apptext(
                            "Pending",
                            Colors: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
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
  }

  void showPendingDialog(WorkModel work) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red,
        title: const Apptext(
          "Move to Pending",
          Colors: Colors.white,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Apptext(
              "Cancel",
              Colors: Colors.grey,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              work.status = false;
              await _workDatas.edit(work);
              loadwork();
              Navigator.of(context).pop();
            },
            child: const Apptext(
              "Pending",
              Colors: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

