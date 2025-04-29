import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/event_filters.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/event_tile.dart';

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
            top: deviceHeight(context) * 0.060,
            bottom: deviceHeight(context) * 0.060,
            left: deviceWidth(context) * .060,
            right: deviceWidth(context) * .060),
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
                                  "Event name",
                                  style: TextStyle(
                                      fontFamily: "Belwe",
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(),
                                        hintText: "Search by event name",
                                      ),
                                      onChanged: (value) =>
                                          eventSearchFilter = value,
                                    ),
                                  ),
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
                                  "Number of tables",
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
                                      hintText: "Any number",
                                      onSelected: (value) {
                                        setState(() {
                                          eventNumOfTablesFilter = value!;
                                        });
                                      },
                                      menuStyle: MenuStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.white),
                                      ),
                                      dropdownMenuEntries: [
                                        DropdownMenuEntry(
                                          value: -1,
                                          label: "Any number",
                                        ),
                                        DropdownMenuEntry(
                                            value: 10, label: "Less than 10"),
                                        DropdownMenuEntry(
                                            value: 50, label: "Less than 50"),
                                        DropdownMenuEntry(
                                            value: 100, label: "Less than 100"),
                                        DropdownMenuEntry(
                                            value: 1000,
                                            label: "Less than 1,000"),
                                        DropdownMenuEntry(
                                            value: 1001,
                                            label: "More than 1,000"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    filteredList = filterBySearch(
                                        eventsList, eventSearchFilter.toLowerCase());
                                    filteredList = filterByFormat(
                                        filteredList, eventFormatFilter);
                                    filteredList = filterByDate(
                                        filteredList, eventDateFilter);
                                    filteredList = filterByNumOfTables(
                                        filteredList, eventNumOfTablesFilter);
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
                                       eventId: event.eventId,
                                      ),
                                    if (filteredList.isEmpty)
                                      Text(
                                        "No event falls within the specified event filters.",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 24),
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
