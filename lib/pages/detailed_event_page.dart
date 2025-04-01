import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/table_object.dart';
import 'package:flutter_application_3/pages/events_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/detailed_event_info_card.dart';
import 'package:flutter_application_3/widgets/tables_card.dart';
import 'package:flutter_application_3/widgets/text_card.dart';
import 'profile_page.dart';

class DetailedEventPage extends StatelessWidget {
  const DetailedEventPage({
    super.key,
    required this.dateTime,
    required this.title,
    required this.location,
    required this.description,
    required this.eventImage,
    required this.totalSeats,
    required this.openSeats,
    required this.format,
    required this.tables,
    required this.tableList,
  });
  final DateTime dateTime;
  final String title;
  final String location;
  final String description;
  final Image eventImage;
  final int openSeats;
  final int totalSeats;
  final int tables;
  final List<TableObject>tableList;
  final String format;

  //TODO: Allow for the user to assign themselves to an event's table
  //Displays a single event with more detail, as opposed to the events page which displays multiple events with less detail.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150, left: 150),
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EventsPage(),
              ),
            );
          },
          child: Text(
            "Go back to events page",
            style: TextStyle(
                color: Colors.white, fontFamily: "Belwe", fontSize: 24),
          ),
        ),
      ),
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
          child: Row(
            children: [
              SizedBox(width: 20),
              Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    //.image converts the event Image into the required ImageProvider
                    backgroundImage: eventImage.image,
                    radius: 150,
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextCard(
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.height * .4,
                        title: title,
                        endIndent: 150,
                        textBox: Text(
                          description,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        color: Colors.redAccent),
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                children: [
                  SizedBox(height: 20),
                  TablesCard(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.5,
                    title: "All Tables",
                    endIndent: 720,
                    numOfTables: tables,
                    totalSeats: openSeats,
                    tableList: tableList,
                    format: format,
                    color: Colors.redAccent,
                  ),
                  SizedBox(height: 30),
                  DetailedEventInfoCard(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.5,
                      title: "Event Details",
                      endIndent: 10,
                      color: Colors.redAccent,
                      openSeats: openSeats,
                      format: format,
                      totalSeats: totalSeats,
                      location: location,
                      dateTime: dateTime,
                      tables: tables,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
