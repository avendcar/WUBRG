import 'package:flutter_application_3/objects/user.dart';

class Table {
  Table(this.tableSize);
  //Each table will have a list of players and a max size
  int tableSize;
  List<User> players = [];
  //Each table object will contain a list of players
  //Multiple table objects will be stored in an event
}

//Contains a list of all of an event's tables
List<Table> tables = [];

List<Table> getListTable() {
  return tables;
}

List<Table> generateTableList(int numOfTables, int tableSize) {
  List<Table> tableListToBeReturned = [];
  for (int x = 0; x < numOfTables; x++) {
    tableListToBeReturned.add(
      Table(tableSize),
    );
  }
  return tableListToBeReturned;
}

void addTablesToTableList(int tableSize) {
  Table table = Table(tableSize);
  tables.add(table);
}

void addPlayerToTable(Table table, User userToBeAdded) {
  if (table.players.length < table.tableSize) {
    table.players.add(userToBeAdded);
    print("Player added to table");
  } else {
    print("This table is full and a player could not be added");
  }
}

void removePlayerFromTable(Table table, User userToBeRemoved) {
  bool playerIsInTable = false;
  for (var player in table.players) {
    if (player == userToBeRemoved) {
      table.players.remove(player);
      playerIsInTable = true;
    }
  }
  if (playerIsInTable) {
    print("$userToBeRemoved has been removed from the table");
  } else {
    print("The desired player is not in this table");
  }
}
