import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/events_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

import 'profile_page.dart';

class EditEvents extends StatelessWidget {
  const EditEvents({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Create the 'create event' page
    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.only(
            top: deviceHeight(context) * 0.095,
            bottom: deviceHeight(context) * 0.095,
            left: deviceWidth(context) * .095,
            right: deviceWidth(context) * .095),
        //Distance of profile box from the edges of the body
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.red, Colors.black],
          ),
        ),
        child: Container(
          //Grey box
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.redAccent, width: 10),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventsPage()),
                      );
                      },
                      child: Text("Click here to go back to the events page"),
                    ),
                    Text(
                      "This will be the page for editing the events shown on the events page",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                SizedBox(width: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
