import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/event_tile.dart';
import "package:flutter_application_3/objects/events.dart";

List<Event> eventsList = getEventsList();

String eventFormatFilter = "Any Format";
String eventDateFilter = "All dates";
String eventOpenSeatsFilter = "All";

List<Event> filteredList = eventsList;

/*
Summary of filter methods:

Takes in an event list and a filter as parameters.
If the parameter specifies "all (data type)", the method returns the unchanged list
Otherwise, the unfiltered list is iterated through and each event is
checked for if it fits the desired data type.
Once this process finishes, the list generated is returned.
*/
List<Event> filterByFormat(List<Event> unfilteredEvents, String desiredFormat) {
  List<Event> listToBeReturned = [];
  if (desiredFormat == "Any Format") {
    return unfilteredEvents;
  }
  for (Event event in unfilteredEvents) {
    if (event.format == desiredFormat) {
      listToBeReturned.add(event);
    }
  }
  return listToBeReturned;
}

List<Event> filterByDate(List<Event> unfilteredEvents, String desiredDate) {
  DateTime referenceDate = DateTime.now();
  List<Event> listToBeReturned = [];
  bool afterAYear = false;
/*
Becomes true only if the filter is "Beyond a year".
This triggers a flag later to check for dates that are further out than
a year as opposed to the other cases where the event's date is checked
for dates that are within a time frame.
*/
  switch (desiredDate) {
    case "All dates":
      return unfilteredEvents;
    case "Within the week":
      referenceDate = DateTime(
          referenceDate.year, referenceDate.month, referenceDate.day + 7);
    case "Within the month":
      referenceDate = DateTime(
          referenceDate.year, referenceDate.month + 1, referenceDate.day);
    case "Within 3 months":
      referenceDate = DateTime(
          referenceDate.year, referenceDate.month + 3, referenceDate.day);
    case "Within the year":
      referenceDate = DateTime(
          referenceDate.year + 1, referenceDate.month, referenceDate.day);
    case "Beyond a year":
      referenceDate = DateTime(
          referenceDate.year + 1, referenceDate.month, referenceDate.day);
      afterAYear = true;
  }

  for (Event event in unfilteredEvents) {
    if (afterAYear) {
      if (event.dateTime.isAfter(referenceDate)) {
        listToBeReturned.add(event);
      }
      continue;
    }
    if (referenceDate.isAfter(event.dateTime)) {
      listToBeReturned.add(event);
    }
  }
  return listToBeReturned;
}

List<Event> filterByOpenSeats(
    List<Event> unfilteredEvents, String desiredOpenSeats) {
  List<Event> listToBeReturned = [];
  if (desiredOpenSeats == "All") {
    return unfilteredEvents;
  }
  for (Event event in unfilteredEvents) {
    switch (desiredOpenSeats) {
      case "Yes":
        if (event.takenSeats < event.totalSeats) {
          listToBeReturned.add(event);
        }
      case "No":
        if (event.takenSeats == event.totalSeats) {
          listToBeReturned.add(event);
        }
    }
  }
  return listToBeReturned;
}

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
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
                                          eventFormatFilter = value!;
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
                                          value: "Any Format",
                                          label: "Any Format",
                                        ),
                                        DropdownMenuEntry(
                                            value: "Commander",
                                            label: "Commander"),
                                        DropdownMenuEntry(
                                            value: "Standard",
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
                                          eventDateFilter = value!;
                                        });
                                      },
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                            value: "All dates",
                                            label: "All dates"),
                                        DropdownMenuEntry(
                                            value: "Within the week",
                                            label: "Within the week"),
                                        DropdownMenuEntry(
                                            value: "Within the month",
                                            label: "Within the month"),
                                        DropdownMenuEntry(
                                            value: "Within 3 months",
                                            label: "Within 3 months"),
                                        DropdownMenuEntry(
                                            value: "Within the year",
                                            label: "Within the year"),
                                        DropdownMenuEntry(
                                            value: "Beyond the year",
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
                                          eventOpenSeatsFilter = value!;
                                        });
                                      },
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                            value: "All", label: "All"),
                                        DropdownMenuEntry(
                                            value: "Yes", label: "Yes"),
                                        DropdownMenuEntry(
                                            value: "No", label: "No"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    filteredList = filterByFormat(
                                        eventsList, eventFormatFilter);
                                    filteredList = filterByDate(
                                        filteredList, eventDateFilter);
                                    filteredList = filterByOpenSeats(
                                        filteredList, eventOpenSeatsFilter);
                                    setState(() {});
                                  },
                                  child: Text("Apply filters"),
                                ),
                                SizedBox(height: 20),
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
                                    for (var event in filteredList)
                                      EventTile(
                                        title: event.title,
                                        dateTime: event.dateTime,
                                        description: event.description,
                                        location: event.location,
                                        eventImage: event.eventImage,
                                        totalSeats: event.totalSeats,
                                        takenSeats: event.totalSeats,
                                        tables: event.tables,
                                        tableList: event.tableList,
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
