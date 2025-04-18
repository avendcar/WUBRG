import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/player_filters.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/player_tile.dart' hide userList;
import '../objects/user.dart' hide userList;

class FindPlayersPage extends StatefulWidget {
  const FindPlayersPage({super.key});

  @override
  State<FindPlayersPage> createState() => _FindPlayersPageState();
}

class _FindPlayersPageState extends State<FindPlayersPage> {
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
                          Text(
                            "User name",
                            style: TextStyle(
                                fontFamily: "Belwe",
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: "Search by user name",
                                ),
                                onChanged: (value) =>
                                    playerSearchFilter = value,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              filteredList = filterBySearch(
                                  userList, playerSearchFilter.toLowerCase());
                              filteredList =
                                  filterByTags(filteredList, selectedTagFilter);
                              setState(() {});
                            },
                            child: Text("Apply filters"),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Filter by user tags",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Belwe",
                                fontSize: 16),
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "Currently Selected Tags : ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Belwe"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      generateTagOutput(selectedTagFilter),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      updateTagFilter("18+");
                                      setState(() {});
                                    },
                                    child: Text(
                                      "18+",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      updateTagFilter("Competitive");
                                      setState(() {});
                                    },
                                    child: Text("Competitive",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      updateTagFilter("Casual");
                                      setState(() {});
                                    },
                                    child: Text("Casual",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      updateTagFilter(
                                          "Prefers standard format");
                                      setState(() {});
                                    },
                                    child: Text("Prefers standard format",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      updateTagFilter(
                                          "Prefers commander format");
                                      setState(() {});
                                    },
                                    child: Text("Prefers commander format",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      updateTagFilter("Prefers any format");
                                      setState(() {});
                                    },
                                    child: Text("Prefers any format",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (User user in filteredList)
                                PlayerTile(
                                  userId: user.userId,
                                ),
                              if (filteredList.isEmpty)
                                Text(
                                  "No player exists under the searched name.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                            ],
                          ),
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
