import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/detailed_find_players_page.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile(
      {super.key,
      required this.userId,
      required this.username,
      required this.profilePicture,
      required this.bio});
  final int userId;
  final String username;
  final String bio;
  final Image profilePicture;

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => ProfilePage(
                  username: username,
                  profilePicture: profilePicture,
                  bio: bio,
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
                    child: profilePicture,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 250,
                  child: Text(
                    username,
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
                    bio,
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
