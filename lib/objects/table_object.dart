import 'package:flutter_application_3/objects/user.dart';

class TableObject {
  TableObject(this.tableSize, this.tableId);
  //Each table will have a list of players, a max size, and an ID
  int tableSize;
  int takenSeats = 0;
  int tableId;
  List<User> players = [];
  bool isUserInPlayerList(List<User> playerList, User desiredUser) {
    for (User player in playerList) {
      if (player.userId == desiredUser.userId) {
        return true;
      }
    }
    return false;
  }

  void removePlayerFromTable(TableObject table, User userToBeRemoved) {
    int userId = userToBeRemoved.userId;
    table.players.removeWhere((id)=> id == userId);
  }
  //Each table object will contain a list of players
  //Multiple table objects will be stored in an event
}

//Contains a list of all of an event's tables
List<TableObject> tables = [];

List<TableObject> getListTable(List<TableObject> tableListToBeReturned) {
  return tables;
}

List<TableObject> generateTableList(int numOfTables, int tableSize) {
  List<TableObject> tableListToBeReturned = [];
  for (int x = 0; x < numOfTables; x++) {
    tableListToBeReturned.add(
      TableObject(
        tableSize,
        (x + 1),
      ),
    );
  }
  return tableListToBeReturned;
}

void addPlayerToTable(TableObject table, User userToBeAdded) {
  if (table.players.length < table.tableSize) {
    /* Only adds userToBeAdded to the TableObject if the TableObject's length is greater
    than the length of the list of players in that TableObject.
    This is done to make sure user cannot add themselves to a table that is already full */
    table.players.add(userToBeAdded);
  } else {
    //Otherwise it runs this code
  }
}
