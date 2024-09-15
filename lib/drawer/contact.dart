import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:staff/custum/textcostom.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
         backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
        title: Apptext("contact"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 34),
        child: Column(
          children: [
            Center(
              child: LottieBuilder.asset('lib/asset/gif/animation/Animation - 1726423818558.json',) ,
              
              
            ),
            SizedBox(height: 52,),
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                            children: [
                const Apptext("By phone number:",Colors: Colors.black,fontSize:21,),
                TextButton(onPressed:(){
                  _makePhoneCall('tel:8848561548');
                } , child: const Text("8848561548",))
                            ],
                          ),
              ),
              SizedBox(height: 14,)
           ,Padding(
             padding: const EdgeInsets.only(left: 21),
             child: Row(
                       children: [
                Apptext("By Email :",Colors: Colors.black,fontSize:21),
                TextButton(onPressed: (){
                     
                }, child: Apptext("staffspherecalicut@gmail.com"))
                       ],
                     ),
           )
          ],
        ),
      ) ,
    );
  }
    Future<void> _makePhoneCall(String phoneNumber) async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}