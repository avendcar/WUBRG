import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/tables.dart';

import '../objects/user.dart';

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
    required this.tableList,
  });
  final double height;
  final double width;
  final String title;
  final double endIndent;
  final String format;
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
                    for (int tableCount = 0;
                        tableCount < widget.numOfTables;
                        tableCount++)//Iterates through every table in the event
                      DefaultTextStyle.merge(
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (widget.tableList[tableCount].players
                                      .contains(testUser1)) {
                                    widget.tableList[tableCount].players
                                        .remove(testUser1);
                                  } else {
                                    widget.tableList[tableCount].players
                                        .add(testUser1);
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.table_bar_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            Text("Table #${tableCount + 1} : "),
                            for (int userCount = 0;
                                userCount <
                                    widget.tableList[userCount].players.length;
                                userCount++)//Iterates through every player in the table
                              Text(widget.tableList[userCount]
                                  .players[userCount].username),
                            //TODO: Clicking on the table icon currently assigns test user to all tables and clicking on the table icon again changes nothing
                            //Outputs the username of every user at the given table
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
