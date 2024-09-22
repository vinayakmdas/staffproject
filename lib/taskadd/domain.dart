import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:staff/model/domainmodel.dart';
import 'package:staff/service/add_domain_servicepage.dart';

class Domain extends StatefulWidget {
  const Domain({super.key});

  @override
  State<Domain> createState() => _DomainState();
}

final domaintext = TextEditingController();

class _DomainState extends State<Domain> {
  final DomainBox _domainBox = DomainBox();
  List<Domainmodel> _list = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _domainBox.openBox();
    await _loaddomains();
  }

  Future<void> _loaddomains() async {
    _list = await _domainBox.getDomain();
    setState(() {}); 
  }

  Future<void> submit() async {
    final name = domaintext.text.trim();

    if (name.isNotEmpty) {
      Domainmodel domainmodel = Domainmodel(domain: name);
      await _domainBox.adddomain(domainmodel);
      domaintext.clear(); 
      await _loaddomains(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: Text(
          "DOMAIN",
          style: GoogleFonts.getFont('Lato'),
        ),
      ),
      body:
    _list.isEmpty?const Center(child: Text("No Domains Are Added")):
      
       ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final domain = _list[index];
          return ListTile(
            title: Text(domain.domain),
              trailing: IconButton(onPressed: ()async{
                   _domainBox.delete(index);
                   setState(() { });
                   _list.removeAt(index);

              }, icon: const Icon(Icons.delete,color: Colors.red,)
              
              ),
            
          );
        },
      ),
  
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showdiolog();
        },
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> showdiolog() async {
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
                      "Enter Domain name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                TextField(
                  controller: domaintext,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await submit();
                        Navigator.of(context).pop() ;
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Color.fromRGBO(22, 38, 52, 1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
