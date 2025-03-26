import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/event_tile.dart';
import "package:flutter_application_3/objects/events.dart";

List<Event> eventsList = getEventsList();

String eventFormatFilter = "Any format";
String eventDateFilter = "All dates";
String eventOpenSeatsFilter = "All";

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    //Displays many events with less detail, as opposed to the detailed event page which displays a single event with more detail.
    return Scaffold(
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
            child: Row(
              children: [
                Expanded(
                  //Filters section
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Colors.redAccent, width: 10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Event Filters",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Belwe",
                                      fontSize: 24),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Text(
                                  "Format",
                                  style: TextStyle(
                                      fontFamily: "Belwe",
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownMenu(
                                      //Dropdown for adding a MTG format filter
                                      hintText: eventFormatFilter,
                                      onSelected: (value) {
                                        setState(() {
                                          eventFormatFilter = value.toString();
                                        });
                                      },
                                      menuStyle: MenuStyle(
                                        /*Feel free to expand this list with any of these formats:
                                        https://magic.wizards.com/en/formats
                                        */
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.white),
                                      ),
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                          value: Text("Any Format"),
                                          label: "Any Format",
                                        ),
                                        DropdownMenuEntry(
                                            value: Text("Commander"),
                                            label: "Commander"),
                                        DropdownMenuEntry(
                                            value: Text("Standard"),
                                            label: "Standard"),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      fontFamily: "Belwe",
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Padding(
                                  //Filter for how many days away the events are
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownMenu(
                                      hintText: eventDateFilter,
                                      onSelected: (value) {
                                        setState(() {
                                          eventDateFilter = value.toString();
                                        });
                                      },
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                            value: Text("All dates"),
                                            label: "All dates"),
                                        DropdownMenuEntry(
                                            value: Text("Within the week"),
                                            label: "Within the week"),
                                        DropdownMenuEntry(
                                            value: Text("Within the month"),
                                            label: "Within the month"),
                                        DropdownMenuEntry(
                                            value: Text("Within 3 months"),
                                            label: "Within 3 months"),
                                        DropdownMenuEntry(
                                            value: Text("Within the year"),
                                            label: "Within the year"),
                                        DropdownMenuEntry(
                                            value: Text("Beyond the year"),
                                            label: "Beyond the year"),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Has open seats",
                                  style: TextStyle(
                                      fontFamily: "Belwe",
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Padding(
                                  //Filter for if the event has open seats
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownMenu(
                                      hintText: eventOpenSeatsFilter,
                                      onSelected: (value) {
                                        setState(() {
                                          eventOpenSeatsFilter =
                                              value.toString();
                                        });
                                      },
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                            value: Text("Yes"), label: "Yes"),
                                        DropdownMenuEntry(
                                            value: Text("No"), label: "No"),
                                        DropdownMenuEntry(
                                            value: Text("All"), label: "All"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  //Events table
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Colors.redAccent, width: 10),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    for (var event in eventsList)
                                      EventTile(
                                        title: event.title,
                                        dateTime: event.dateTime,
                                        description: event.description,
                                        location: event.location,
                                        eventImage: event.eventImage,
                                        totalSeats: event.totalSeats,
                                        openSeats: event.totalSeats,
                                        tables: event.tables,
                                        format: event.format,
                                      ),
                                    SizedBox(height: 10)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
