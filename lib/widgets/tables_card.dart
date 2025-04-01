import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/table_object.dart';
import 'package:flutter_application_3/objects/user.dart';

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
  });
  final double height;
  final double width;
  final String title;
  final double endIndent;
  final String format;
  final int totalSeats;
  final int numOfTables;
  final List<TableObject> tableList;
  final Color color;

  @override
  State<TablesCard> createState() => _TablesCardState();
}

class _TablesCardState extends State<TablesCard> {
  @override
  Widget build(BuildContext context) {
    User testUser1 = User(
      "test username",
      1,
      "test bio",
      Image.asset("images/kuriboh.png"),
    );

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
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    switch (table.isUserInPlayerList(
                                        table.players, testUser1)) {
                                      //Switch statement for checking if the test user is in the table of the current iteration
                                      case true:
                                      //TODO: Add ability for the active user to remove themselves from a table
                                        table.players.remove(testUser1);
                                      case false:
                                        if (table.tableSize >
                                            table.players.length) {
                                          /*
                                            If statement for checking if adding the current user would cause the table to go over its maximum size.
                                            Successfully adds the player if there is room, displays a snackbar and does not add the player if there is
                                            no room.
                                            */
                                          table.players.add(testUser1);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  const Duration(seconds: 1),
                                              content: Text(
                                                  '${testUser1.username} could not be added to table #${table.tableId} because it is full.'),
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
                            Text("Table #${table.tableId} : "),
                            for (User user in table
                                .players) //Outputs all the usernames of the players within the table
                              Text("${user.username}, "),
                          ],
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
