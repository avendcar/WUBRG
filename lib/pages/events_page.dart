import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/edit_events.dart';
import 'package:flutter_application_3/pages/profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});


  @override
  Widget build(BuildContext context) {
    //TODO: Create events page
    //Displays many events with less detail, as opposed to the detailed event page which displays a single event with more detail.
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EditEvents(),
              ),
            );
          },
          child: Text(
            " Edit Events",
            style: TextStyle(
                color: Colors.white, fontFamily: "Belwe", fontSize: 24),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
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
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ListView(
                            children: [],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
