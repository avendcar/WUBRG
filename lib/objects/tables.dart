import 'package:flutter_application_3/objects/user.dart';

class TableObject {
  TableObject(this.tableSize);
  //Each table will have a list of players and a max size
  int tableSize;
  List<User> players = [];
  //Each table object will contain a list of players
  //Multiple table objects will be stored in an event
}

//Contains a list of all of an event's tables
List<TableObject> tables = [];

List<TableObject> getListTable() {
  return tables;
}

List<TableObject> generateTableList(int numOfTables, int tableSize) {
  List<TableObject> tableListToBeReturned = [];
  for (int x = 0; x < numOfTables; x++) {
    tableListToBeReturned.add(
      TableObject(tableSize),
    );
  }
  return tableListToBeReturned;
}

void addTablesToTableList(int tableSize) {
  TableObject table = TableObject(tableSize);
  tables.add(table);
}

void addPlayerToTable(TableObject table, User userToBeAdded) {
  if (table.players.length < table.tableSize) {
    table.players.add(userToBeAdded);
  
  } else {
   
  }
}

void removePlayerFromTable(TableObject table, User userToBeRemoved) {
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
