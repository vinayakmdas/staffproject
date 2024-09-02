import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff/model/backend_model.dart';
import 'package:staff/service/backendDatas.dart';

class Backend extends StatefulWidget {
   Backend({super.key});

  @override
  State<Backend> createState() => _BackendState();
}

class _BackendState extends State<Backend> {
   final backendcontroller = TextEditingController();

BackendDatas backendDatas=BackendDatas();

  List<BackendModel>_list= [];

  firstrunning() async {
    await backendDatas.openBox();
    getdata();
  }

  getdata() async {
    _list = await backendDatas.getbackenddata();
    setState(() {});
  }

saveproject() async {
    final backendtext = backendcontroller.text.trim();
    if (backendtext.isNotEmpty) {
      BackendModel backendModel = BackendModel( backend:  backendtext);
      await backendDatas.addProject(backendModel);
      await getdata();
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstrunning();
  }



  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 72),
          child: Text(
            "BACKEND DATAS",
            style: GoogleFonts.getFont('Lato'),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            final back = _list[index];
            return ListTile(
              title: Text(back.backend),
              trailing: IconButton(
                  onPressed: () {
                    backendDatas.deletelist(index);
                    setState(() {});
                    _list.removeAt(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showdiologproject();
        },
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );




  }
Future showdiologproject() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
            content: Container(
              height: 212,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Enter BACKEND TASK ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  TextField(
                    controller: backendcontroller,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            saveproject();
                            Navigator.of(context).pop();
                            backendcontroller.clear();
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: const Color.fromRGBO(22, 38, 52, 1)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

}