import 'package:flutter_application_3/objects/events.dart';

List<Event> eventsList = getEventsList();

/*
Each filter starts out with a default value that sets no limitations 
the types of events that are displayed.
In other words, these are the default filters 
that do not filter out any events.
*/
String eventFormatFilter = "Any Format";
String eventDateFilter = "All dates";
String eventOpenSeatsFilter = "All";
int eventNumOfTablesFilter = -1;

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

List<Event> filterByNumOfTables(
    List<Event> unfilteredEvents, int desiredNumOfTables) {
  List<Event> listToBeReturned = [];

  switch (desiredNumOfTables) {
    case -1:
      listToBeReturned = unfilteredEvents;
    case 10:
      for (Event event in unfilteredEvents) {
        if (event.tableList.length < 10) {
          listToBeReturned.add(event);
        }
      }
    case 50:
      for (Event event in unfilteredEvents) {
        if (event.tableList.length < 50) {
          listToBeReturned.add(event);
        }
      }
    case 100:
      for (Event event in unfilteredEvents) {
        if (event.tableList.length < 100) {
          listToBeReturned.add(event);
        }
      }
    case 1000:
      for (Event event in unfilteredEvents) {
        if (event.tableList.length < 1000) {
          listToBeReturned.add(event);
        }
      }
    case 1001:
      for (Event event in unfilteredEvents) {
        if (event.tableList.length > 1000) {
          listToBeReturned.add(event);
        }
      }
  }
  return listToBeReturned;
}