import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/app_bar_search_results.dart';
import 'package:flutter_application_3/objects/events.dart';
import 'package:flutter_application_3/objects/table_object.dart';
import 'package:flutter_application_3/objects/user.dart';
import 'package:flutter_application_3/pages/main_page.dart';

class TablesCard extends StatefulWidget {
  const TablesCard({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.endIndent,
    required this.color,
    required this.numOfTables,
    required this.format,
    required this.totalSeats,
    required this.tableList,
    required this.eventId,
  });
  final double height;
  final double width;
  final String title;
  final double endIndent;
  final String format;
  final int totalSeats;
  final int numOfTables;
  final List<TableObject> tableList;
  final int eventId;
  final Color color;

  @override
  State<TablesCard> createState() => _TablesCardState();
}

class _TablesCardState extends State<TablesCard> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 43, 42, 42),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: widget.color, width: 10),
      ),
      height: widget.height,
      width: widget.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Belwe", fontSize: 24),
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: widget.endIndent,
            /*
            Distance from the right edge of the card
            to the right end of the divider
            */
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (TableObject table in widget
                        .tableList) //Iterates through every table in an event's table list
                      DefaultTextStyle.merge(
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis
                                .horizontal, //Allows for horizontal scrolling/dragging if the user list at a table overflows
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        switch (table.isUserInPlayerList(
                                            table.players,
                                            MainPage.signedInUser)) {
                                          //Switch statement for checking if the test user is in the table of the current iteration
                                          case true:
                                            table.players.removeWhere((item) =>
                                                item.userId ==
                                                MainPage.signedInUser
                                                    .userId); //Removes player from the table

                                            MainPage.signedInUser.joinedEvents
                                                .remove(eventsList.firstWhere(
                                                    (event) =>
                                                        event.eventId ==
                                                        widget
                                                            .eventId)); //Removes event from the user's joined events list

                                            table.takenSeats--;
                                          case false:
                                            if (table.tableSize >
                                                table.players.length) {
                                              /*
                                                  If statement for checking if adding the current user would cause the table to go over its maximum size.
                                                  Successfully adds the player if there is room, displays a snackbar and does not add the player if there is
                                                  no room.
                                                  */
                                              table.players.add(MainPage
                                                  .signedInUser); //Adds player to the table
                                              if (!MainPage //Only adds the event to the user's joined events list if that event is not already in the joined events list
                                                  .signedInUser
                                                  .joinedEvents
                                                  .contains(eventList
                                                      .firstWhere((event) =>
                                                          event.eventId ==
                                                          widget.eventId))) {
                                                MainPage
                                                    .signedInUser.joinedEvents
                                                    .add(eventsList.firstWhere(
                                                        (event) =>
                                                            event.eventId ==
                                                            widget.eventId));
                                              }
                                              //Adds event to the user's joined events list

                                              table.takenSeats++;
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: Text(
                                                      'Could not join table #${table.tableId} because it is full.'),
                                                ),
                                              );
                                            }
                                            break;
                                        }
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.table_bar_rounded,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                Text(
                                    "Table #${table.tableId} ${table.takenSeats}/${table.tableSize} players : "),
                                if (table.takenSeats >= table.tableSize)
                                  Text("(Table is full) "),
                                for (User user in table
                                    .players) //Outputs all the usernames of the players within the table
                                  Text("${user.username}, "),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
