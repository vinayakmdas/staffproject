import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff/model/project_model.dart';
import 'package:staff/service/project_task_service.dart';

class Frontend extends StatefulWidget {
 

  const Frontend({super.key,  });

  @override
  State<Frontend> createState() =>_FrontendState();
}

final projecttext = TextEditingController();

class _FrontendState extends State<Frontend> {
  final ProjectData _projectData = ProjectData();
  List<ProjectModel> list = [];
  firstrunning() async {
    await _projectData.openBox();
    getdata();
  }

  getdata() async {
    list = await _projectData.getprojectdata();
    setState(() {});
  }

  saveproject() async {
    final projectname = projecttext.text.trim();
    if (projectname.isNotEmpty) {
      ProjectModel projectModel = ProjectModel(projet: projectname);
      await _projectData.addProject(projectModel);
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
        centerTitle: true ,
        title: Text(
          "FRONTEND DATAS",
          style: GoogleFonts.getFont('Lato'),
        ),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final project = list[index];
            return ListTile(
              title: Text(project.projet),
              trailing: IconButton(
                  onPressed: () {
                    _projectData.deletelist(index);
                    setState(() {});
                    list.removeAt(index);
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
                        "Enter project ",
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
                    controller: projecttext,
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
                            projecttext.clear();
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
