import 'package:flutter/material.dart';
import 'package:staff/add_staff_and_work/workadd.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/custum/textcostom.dart';


import 'package:staff/model/complete_model.dart';
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
                    trailing:  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: ()async{
showalertdelete(context,index);
                          
                        }, icon: Icon(Icons.delete,color:Colors.red,))
                        ,const Apptext("Completed", Colors:Color.fromARGB(255, 15, 122, 19),fontSize: 17)
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
  

  
  showalertdelete(context,index){
    showDialog(context: context, builder:(context)=>AlertDialog(
    title:Apptext("Delte the work.."),
    actions: [
        Column(
          children: [
            Row(
            
              children: [
                TextButton(onPressed: (){
                dleted(index);
                }, child: Apptext("Delete")),
                TextButton(onPressed: (){
                          Navigator.of(context).pop(); 
                }, child: Apptext("cancel")),
              ],
            )

          ],
        )
    ],
    ) );
  }
  dleted(index)async{
   await completeDatas.delete(index);
   setState(() { });
completeValues.removeAt(index);
         Navigator.of(context).pop();
  }
}
