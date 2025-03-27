import 'package:flutter_application_3/objects/user.dart';

class Table {
  Table(this.tableSize, this.players);
  //Each table will have a list of players and a max size
  int tableSize;
  List<User> players;
  //Each table object will contain a list of players
  //Multiple table objects will be stored in an event
}

//Contains a list of all of an event's tables
List<Table> tables = [];

void addTable(int numOfPlayers, List<User> listOfPlayers) {
  Table table = Table(numOfPlayers, listOfPlayers);
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
  for (var player in table.players) {
    if (player == userToBeRemoved) {
      table.players.remove(player);
      print("$userToBeRemoved has been removed from the table");
    }
  }
}



