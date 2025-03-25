import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

import 'profile_page.dart';

class DetailedEventPage extends StatelessWidget {
  const DetailedEventPage({super.key});
  //TODO: Create detailed event page and add navigation to this page.
  //Displays a single event with more detail, as opposed to the events page which displays many events with less detail.
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.only(
            top: deviceHeight(context) * 0.095,
            bottom: deviceHeight(context) * 0.095,
            left: deviceWidth(context) * .095,
            right: deviceWidth(context) * .095),
        //Distance of events box from the edges of the body
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.red, Colors.black],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.redAccent, width: 10),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text("This is the detailed events page.", style: TextStyle(color: Colors.white),),
            
          ),
        ),
      ),
    );
  }
}
