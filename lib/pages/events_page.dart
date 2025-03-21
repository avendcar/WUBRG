import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Create events page
    //Displays many events with less detail, as opposed to the detailed event page which displays a single event with more detail.
    return Scaffold(
      appBar: PersistentAppBar(),
      endDrawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/mtg-background.png"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 100, right: 100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height,
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
