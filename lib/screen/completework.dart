import 'package:flutter/material.dart';
import 'package:staff/add-staff-and-work/workadd.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/custum/textcostom.dart';


import 'package:staff/model.dart/complete_model.dart';
import 'package:staff/service/complete_service.dart';

class Completework extends StatefulWidget {
  const Completework({super.key});

  @override
  State<Completework> createState() => _CompleteworkState();
}

class _CompleteworkState extends State<Completework> {
  Complete_Datas completeDatas = Complete_Datas();
  List<CompleteModel> completeValues = [];

  @override
  void initState() {
    super.initState();
    completeDatas.openbox().then((_) {
      loadWork();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: completeValues.length,
              itemBuilder: (context, index) {
                final work = completeValues[index];
                return Card(
                  child: ListTile(
                    // onTap: () {
                    //   navigatepush(
                    //     context,
                    //     Workview(work:work ),
                    //   );
                    // },
                    title: Text(work.staffname),
                    subtitle: Text(work.project),
                    trailing: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Apptext("Completed", Colors:Color.fromARGB(255, 15, 122, 19),fontSize: 17)
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

  Future<void> loadWork() async {
    List<CompleteModel> completeList = await completeDatas.getdata();
    setState(() {
      completeValues = completeList;
    });
  }

  
}
