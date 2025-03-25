import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/edit_events.dart';
import 'package:flutter_application_3/pages/profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/event_tile.dart';

List eventList = getEventsList();

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
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
                                      hintText: "Select format...",
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
                                      hintText: "Select date",
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
                                  //Filter for how many days away the events are
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownMenu(
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
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                      fontFamily: "Belwe",
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Padding(
                                  //Filter for how many miles away the events are
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownMenu(
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                            value: Text("Any Distance"),
                                            label: "Any Distance"),
                                        DropdownMenuEntry(
                                            value: Text("<5 miles"),
                                            label: "<5 miles"),
                                        DropdownMenuEntry(
                                            value: Text("<10 miles"),
                                            label: "<10 miles"),
                                        DropdownMenuEntry(
                                            value: Text("<20 miles"),
                                            label: "<20 miles"),
                                        DropdownMenuEntry(
                                            value: Text("<50 miles"),
                                            label: "<50 miles"),
                                        DropdownMenuEntry(
                                            value: Text(">50 miles"),
                                            label: ">50 miles"),
                                      ],
                                    ),
                                  ),
                                )
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
                              child: Column(
                                children: [
                                  for (int x = 0; x < 7; x++)
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: EventTile(),
                                    ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
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
