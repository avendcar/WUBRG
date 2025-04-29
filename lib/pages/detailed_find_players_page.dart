import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/models/user.dart' as model;
import 'package:flutter_application_3/pages/find_players_page.dart';
import 'package:flutter_application_3/widgets/user_info_card.dart';
import '../widgets/app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/text_card.dart';

class DetailedFindPlayersPage extends StatefulWidget {
  const DetailedFindPlayersPage({super.key, required this.uid});
  final String uid; // Firebase UID

  @override
  State<DetailedFindPlayersPage> createState() => _DetailedFindPlayersPageState();
}

class _DetailedFindPlayersPageState extends State<DetailedFindPlayersPage> {
  late Future<model.User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUser();
  }

  Future<model.User?> _fetchUser() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
    if (!doc.exists) return null;
    return model.User.fromFirestore(doc.data()!, doc.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150, left: 150),
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FindPlayersPage()),
            );
          },
          child: const Text(
            "Go back to the find players page",
            style: TextStyle(color: Colors.white, fontFamily: "Belwe", fontSize: 24),
          ),
        ),
      ),
      endDrawer: AppDrawer(),
      appBar: const PersistentAppBar(),
      body: FutureBuilder<model.User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final currentUser = snapshot.data!;
          return Container(
            padding: EdgeInsets.only(
              top: deviceHeight(context) * 0.095,
              bottom: deviceHeight(context) * 0.095,
              left: deviceWidth(context) * .095,
              right: deviceWidth(context) * .095,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.black],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 43, 42, 42),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromARGB(255, 23, 100, 163),
                  width: 10,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            currentUser.username,
                            style: const TextStyle(
                              fontFamily: "Belwe",
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 45),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 175,
                                  backgroundImage: NetworkImage(currentUser.profileImageUrl ?? 'https://example.com/default-avatar.png'),

                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextCard(
                            title: "Decks",
                            textBox: const Text(
                              "This is filler text",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Belwe",
                                fontSize: 18,
                              ),
                            ),
                            height: MediaQuery.of(context).size.width * 0.165,
                            width: MediaQuery.of(context).size.width * 0.2,
                            endIndent: 270,
                            color: const Color.fromARGB(255, 23, 100, 163),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 120),
                    Column(
                      children: [
                        UserInfoCard(
                          title: "User Info",
                          height: MediaQuery.of(context).size.width * 0.175,
                          width: MediaQuery.of(context).size.width * 0.5,
                          endIndent: 770,
                          color: const Color.fromARGB(255, 23, 100, 163),
                          bio: currentUser.bio ?? "No bio provided",
                          tags: currentUser.tags,
                        ),
                        const SizedBox(height: 60),
                        Expanded(
                          child: TextCard(
                            title: "Friends",
                            textBox: const Text(
                              "This is filler text",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Belwe",
                                fontSize: 18,
                              ),
                            ),
                            height: MediaQuery.of(context).size.width * 0.18,
                            width: MediaQuery.of(context).size.width * 0.5,
                            endIndent: 820,
                            color: const Color.fromARGB(255, 23, 100, 163),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
