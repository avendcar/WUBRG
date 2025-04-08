import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/user.dart';
import 'package:flutter_application_3/pages/detailed_find_players_page.dart';

List<User> userList = getUserList();

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    super.key,
    required this.userId,
  });
  final int userId;

  @override
  Widget build(BuildContext context) {
    User currentUser = userList.firstWhere((user) => user.userId == userId);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 143,
      child: ButtonTheme(
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 5, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DetailedFindPlayersPage(
                  userId: userId,
                ),
              ),
            );
          },
          label: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: ClipOval(
                    child: currentUser.profilePicture,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 250,
                  child: Text(
                    currentUser.username,
                    style: TextStyle(
                        fontFamily: "Belwe", fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    currentUser.bio,
                    style: TextStyle(
                        fontFamily: "Belwe", fontSize: 20, color: Colors.white),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
