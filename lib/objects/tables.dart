import 'package:firebase_auth/firebase_auth.dart' as auth;

class SingularTable {
  SingularTable(this.tableSize);

  int tableSize;
  List<auth.User> players = [];

  bool containsPlayer(auth.User user) {
    return players.any((player) => player.uid == user.uid);
  }
}

// All tables in the current event/session
List<SingularTable> tables = [];

List<SingularTable> getListTable() => tables;

void addTableToTableList(int tableSize) {
  tables.add(SingularTable(tableSize));
}

bool addPlayerToTable(SingularTable table, auth.User userToBeAdded) {
  if (table.players.length < table.tableSize && !table.containsPlayer(userToBeAdded)) {
    table.players.add(userToBeAdded);
    return true; // Successfully added
  }
  return false; // Table full or user already in
}

bool removePlayerFromTable(SingularTable table, auth.User userToBeRemoved) {
  int initialLength = table.players.length;
  table.players.removeWhere((player) => player.uid == userToBeRemoved.uid);
  return table.players.length < initialLength; // Returns true if someone was removed
}