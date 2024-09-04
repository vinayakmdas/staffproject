import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staff/custum/customdropdown.dart';
import 'package:staff/custum/textcostom.dart';
import 'package:staff/model/work_model.dart';
import 'package:staff/pdfview.dart';

class Workview extends StatefulWidget {
  final WorkModel work;
  
  const Workview({super.key, required this.work});

  @override
  State<Workview> createState() => _WorkviewState();
}

class _WorkviewState extends State<Workview> {
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(widget.work.calendarDate);

    File? file = widget.work.fileproperties != null
        ? File(widget.work.fileproperties!)
        : null;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: Text(widget.work.staffname),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
              const Apptext(
                "Domain :",Colors: Colors.white,fontSize: 17,
              ),
              const SizedBox(height: 10,)
              ,cusstomContainer(
              data: Center(
                child: Apptext(
                  widget.work.domainname,  
                  Colors: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            
            const SizedBox(height: 20,),
         const Apptext("project :",Colors: Colors.white,fontSize:17 ,)
         ,const SizedBox(height: 10,)
         
          ,cusstomContainer(
              data: Center(
                child: Apptext(
                  widget.work.project,  
                  Colors: Colors.white,
                  fontSize: 18,
                ),
              ),
            )
            

             
              , const SizedBox(height: 20),
               const Apptext("Date :",Colors: Colors.white,)
               ,const SizedBox(height: 10),
                 cusstomContainer(
              data: Center(
                child: Apptext(
                formattedDate
                 , Colors: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
               const SizedBox(height: 20,)
               ,const Apptext("Description",Colors: Colors.white,fontSize: 17)
               ,const SizedBox(height: 10,)
                ,cusstomContainer(
              data: Center(
                child: Apptext(
                widget.work.description
                 , Colors: Colors.white,
                  fontSize: 18,
                ), 
              ),
            ),
                
              const SizedBox(height: 20),
              const Text("Attached File:",
                  style: TextStyle( 
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (file != null &&
                      file.path.endsWith('.pdf')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfViewerScreen(pdfFile: file),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 200,
              width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: displayFile(file),
                ), 
              ),
              const SizedBox(height: 10,),
           const   Divider(), 
        const   SizedBox(height: 10,),
        cusstomContainer(data: Center(child:TextButton(onPressed: (){}, child: const Apptext("EDIT",Colors: Colors.white,fontSize: 21))))
       , const SizedBox(height: 10,)
          ,cusstomContainer(data: Center(child:TextButton(onPressed: (){}, child: const Apptext("DELETE",Colors: Colors.white,fontSize: 21))))
         , const Divider()
            ],
          ),
        ),
      ),
    );
  }
  Widget displayFile(File? file) {
  if (file == null) {
    return const Center(
      child: Text("No Document",
          style: TextStyle(color: Colors.white)),
    );
  }

  final fileExtension = file.path.split('.').last.toLowerCase();

  if (fileExtension == 'pdf') {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf,
              size: 50, color: Colors.red),
          Text('PDF File: ${file.uri.pathSegments.last}',
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  } else if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        file,
        fit: BoxFit.cover,
      ),
    );
  } else if (['doc', 'docx'].contains(fileExtension)) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.description,
              size: 50, color: Colors.blue),
          Text('Document File: ${file.uri.pathSegments.last}',
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  } else {
    return const Center(
        child: Text('Unsupported File Type',
            style: TextStyle(color: Colors.white)));
  }
}


}
