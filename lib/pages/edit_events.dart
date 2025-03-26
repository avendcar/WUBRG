import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/pages/events_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'profile_page.dart';

DateTime timeOfEvent = DateTime(2017, 9, 7, 17, 30);
String title = "Example Event Title";
String location = "Example Event Location";
String description = "Example Event Description";
int totalSeats = 24;
int takenSeats = 0;
String format = "Example Event Format";

List<Event> eventsList = [];
int eventIndex = 0;

class Event {
  Event(DateTime dateTime, String title, String location, String description,
      int eventID);
}

void addEvent(
    DateTime dateTime, String title, String location, String description) {
  Event event = Event(dateTime, title, location, description, eventIndex);
  eventsList.add(event);
  eventIndex++;
}

void removeEvent(int eventID) {
  eventsList.removeWhere((item) => eventIndex == eventID);
  eventIndex--;
}

List<Event> getEventsList() {
  return eventsList;
}

class EditEvents extends StatefulWidget {
  const EditEvents({super.key});

  @override
  State<EditEvents> createState() => _EditEventsState();
}

class _EditEventsState extends State<EditEvents> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //TODO: Restrict access to only allow access to this page for admins

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
                Center(
                  child: Column(
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
                      ),
                      SizedBox(
                        width: 500,
                        height: 500,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  hintText: "Type the event title",
                                  labelText: "Title",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  hintText: "Type the event location",
                                  labelText: "Location",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  hintText: "Type the event description",
                                  labelText: "Description",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Theme(
                                data:
                                    ThemeData(splashColor: Colors.transparent),
                                child: DropdownButtonFormField(
                                  value: null,
                                  style: TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                      labelText: "Format",
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  validator: (value) {
                                    return null;
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: null,
                                      child: Container(
                                        height: 48,
                                        color: Colors.transparent,
                                        child: Text("Select a format..."),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "Commander",
                                      child: Container(
                                        height: 48,
                                        color: Colors.transparent,
                                        child: Text("Commander"),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "Standard",
                                      child: Container(
                                        height: 48,
                                        color: Colors.transparent,
                                        child: Text("Standard"),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                style: TextStyle(color: Colors.white),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                  //Allows for only numbers to be inputted
                                ],
                                decoration: InputDecoration(
                                  hintText: "Type the total number of seats",
                                  labelText: "Number of Seats",
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Add Event",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
