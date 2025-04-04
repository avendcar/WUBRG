import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/player_tile.dart';
import '../objects/user.dart';

List<User> userList = getUserList();

class FindPlayersPage extends StatelessWidget {
  const FindPlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.only(
            top: deviceHeight(context) * 0.095,
            bottom: deviceHeight(context) * 0.095,
            left: deviceWidth(context) * .095,
            right: deviceWidth(context) * .095),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.orange, Colors.black],
          ),
        ),
        child: Container(
          //Grey box
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orangeAccent, width: 10),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.orangeAccent,
                          width: 10,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Player Filters",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Belwe",
                                fontSize: 24),
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.orangeAccent,
                          width: 10,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            for (User user in userList)
                              PlayerTile(
                                  userId: user.userId,
                                  username: user.username,
                                  profilePicture: user.profilePicture,
                                  bio: user.bio),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
