import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailedEventInfoCard extends StatefulWidget {
  //Card that is displayed in the detailed events page that contains
  //the location, date, and the number of open seats for the given event.
  const DetailedEventInfoCard(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.endIndent,
      required this.color,
      required this.openSeats,
      required this.totalSeats,
      required this.location,
      required this.dateTime,
      required this.format,
      required this.tables});
  final double height;
  final double width;
  final String title;
  final DateTime dateTime;
  final double endIndent;
  final String location;
  final String format;
  final int openSeats;
  final int totalSeats;
  final int tables;
  final Color color;

  @override
  State<DetailedEventInfoCard> createState() => _DetailedEventInfoCardState();
}

class _DetailedEventInfoCardState extends State<DetailedEventInfoCard> {
  @override
  Widget build(BuildContext context) {
    final f = DateFormat("yyyy-MM-dd hh:mm a");
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
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Belwe", fontSize: 24),
                ),
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
                child: DefaultTextStyle.merge(
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  child: Column(
                    children: [
                      Text("Location : ${widget.location}"),
                      SizedBox(height: 10),
                      Text("Format : ${widget.format}"),
                      SizedBox(height: 10),
                      Text("Date : ${f.format(widget.dateTime)}"),
                      SizedBox(height: 10),
                      Text("Open Seats : ${widget.openSeats}/${widget.totalSeats}"),
                      SizedBox(height: 10),
                      Text("Number of Tables : ${widget.tables}"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
