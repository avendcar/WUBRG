import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/table_object.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/models/user.dart' as model;

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

  void _toggleUserAtTable(TableObject table) {
    final model.User signedInUser = MainPage.signedInUser!;
    final isAtTable = table.players.any((p) => p.uid == signedInUser.uid);

    setState(() {
      if (isAtTable) {
        table.players.removeWhere((p) => p.uid == signedInUser.uid);
        table.takenSeats--;

        signedInUser.joinedEvents.removeWhere(
          (eventId) => eventId == widget.eventId.toString(),
        );
      } else {
        if (table.players.length < table.tableSize) {
          table.players.add(signedInUser);
          table.takenSeats++;

          if (!signedInUser.joinedEvents.contains(widget.eventId.toString())) {
            signedInUser.joinedEvents.add(widget.eventId.toString());
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text('Table #${table.tableId} is full.'),
            ),
          );
        }
      }
    });
  }

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
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Belwe",
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Divider(indent: 10, endIndent: widget.endIndent),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: widget.tableList.map((table) {
                  final isFull = table.takenSeats >= table.tableSize;

                  return DefaultTextStyle.merge(
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => _toggleUserAtTable(table),
                                icon: const Icon(
                                  Icons.table_bar_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Text(
                                "Table #${table.tableId} ${table.takenSeats}/${table.tableSize} players: ",
                              ),
                              if (isFull)
                                const Text(
                                  "(Table is full) ",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ...table.players.map(
                                (model.User user) => Text("${user.username}, "),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
