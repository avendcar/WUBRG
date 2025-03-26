import 'package:flutter_application_3/objects/user.dart';

class Table {
  Table(this.tableSize);
  int tableSize;
}

//Contains a list of all of an event's tables
List<Table> tables = [];

void addTable(int numOfPlayers) {
  Table table = Table(numOfPlayers);
  tables.add(table);
}

List<User> players = [];
void main() {}
