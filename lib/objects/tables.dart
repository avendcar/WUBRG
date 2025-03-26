import 'package:flutter_application_3/objects/user.dart';

class Table {
  Table(this.tableSize, this.players);
  //Each table will have a list of players and a max size
  int tableSize;
  List<User> players;
}

//Contains a list of all of an event's tables
List<Table> tables = [];

void addTable(int numOfPlayers, List<User> players) {
  Table table = Table(numOfPlayers, players);
  tables.add(table);
}

List<User> players = [];
void main() {}
