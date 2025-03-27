
import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/tables.dart';

//All event information will be placed in this file from back end
class Event {
  Event(
      this.dateTime,
      this.title,
      this.location,
      this.description,
      this.eventImage,
      this.totalSeats,
      this.tables,
      this.tableList,
      this.format);
  DateTime dateTime;
  String title;
  String location;
  String description;
  Image eventImage;
  int totalSeats;
  int tables;
  List<SingularTable> tableList;
  String format;
}

List<SingularTable> generateTableList(int numOfTables, int tableSize) {
  List<SingularTable> tableListToBeReturned = [];
  for (int x = 0; x < numOfTables; x++) {
    tableListToBeReturned.add(
      SingularTable(tableSize),
    );
  }
  return tableListToBeReturned;
}

//Hard coded events used for testing purposes. Will be deleted after API integration.
List<Event> eventsList = [event1, event2, event3, event4];

Event event1 = (Event(
    DateTime.utc(2025, 11, 11, 11, 11),
    "Battle City",
    "123 Street St., El Paso, TX 79835",
    "Become the king of games!",
    Image.asset("images/kuriboh.png"),
    100,
    calculateTables(100, "Commander"),
    generateTableList(calculateTables(100, "Commander"), 5),
    "Commander"));
Event event2 = (Event(
    DateTime.utc(2025, 12, 12, 12, 12),
    "Clash of Cards",
    "456 Avenue, El Paso, TX 79835",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    Image.asset("images/sloth.png"),
    32,
    calculateTables(32, "Standard"),
    generateTableList(calculateTables(100, "Standard"), 2),
    "Standard"));
Event event3 = (Event(
    DateTime.utc(2025, 3, 25, 13, 13),
    "Event Title 3",
    "Event Location 3",
    "Event Description 3",
    Image.asset("images/kuriboh.png"),
    12,
    calculateTables(12, "Commander"),
    generateTableList(calculateTables(100, "Commander"), 5),
    "Commander"));
Event event4 = (Event(
    DateTime.utc(2025, 6, 14, 14, 14),
    "Event Title 4",
    "Event Location 4",
    "Event Description 4",
    Image.asset("images/sloth.png"),
    12,
    calculateTables(12, "Standard"),
    generateTableList(calculateTables(100, "Standard"), 2),
    "Standard"));

//Outputs the event list created in this dart file to be used by outside dart files
List<Event> getEventsList() {
  return eventsList;
}

//Calculates the amount of tables at an event based on the event's format and total seats
int calculateTables(int totalSeats, String format) {
  double tables;
  //the If statements add an additional table if the totalSeats are not evenly
  //divisible by the amount of players required by the event's format.
  //This is done to accomodate for the players in the remainder.
  switch (format) {
    case "Commander":
      tables = totalSeats / 5;
      if (totalSeats % 5 != 0) {
        tables++;
      }
      break;
    case "Standard":
      tables = totalSeats / 2;
      if (totalSeats % 2 != 0) {
        tables++;
      }
      break;
    default:
      tables = totalSeats.toDouble();
  }
  return tables.toInt();
}
