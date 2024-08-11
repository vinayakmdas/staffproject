import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:staff/model.dart/domainmodel.dart';
import 'package:staff/service.dart/add_domain_servicepage.dart';

class Domain extends StatefulWidget {
  const Domain({super.key});

  @override
  State<Domain> createState() => _DomainState();
}

final domaintext = TextEditingController();

class _DomainState extends State<Domain> {
  DomainBox _domainBox = DomainBox();
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
    setState(() {}); // Ensure the UI updates after loading data
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
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 72),
          child: Text(
            "DOMAIN",
            style: GoogleFonts.getFont('Lato'),
          ),
        ),
      ),
      body:
    
      
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

              }, icon: Icon(Icons.delete,color: Colors.red,)
              
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
                        Navigator.of(context).pop(); // Close the dialog
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
