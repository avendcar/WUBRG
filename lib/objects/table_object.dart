import 'package:flutter_application_3/models/user.dart' as model;

class TableObject {
  TableObject(this.tableSize, this.tableId);

  int tableSize;
  int takenSeats = 0;
  int tableId;
  List<model.User> players = [];

  bool isUserInPlayerList(model.User desiredUser) {
    for (var player in players) {
      if (player.uid == desiredUser.uid) {
        return true;
      }
    }
    return false;
  }

  void removePlayerFromTable(model.User userToBeRemoved) {
    players.removeWhere((player) => player.uid == userToBeRemoved.uid);
  }
}

List<TableObject> tables = [];

List<TableObject> getListTable() {
  return tables;
}

List<TableObject> generateTableList(int numOfTables, int tableSize) {
  return List.generate(
    numOfTables,
    (index) => TableObject(tableSize, index + 1),
  );
}

void addPlayerToTable(TableObject table, model.User userToBeAdded) {
  if (table.players.length < table.tableSize) {
    table.players.add(userToBeAdded);
  } else {
  }
}

