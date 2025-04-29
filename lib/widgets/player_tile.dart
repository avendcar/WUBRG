import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/models/user.dart' as model;
import 'package:flutter_application_3/pages/detailed_find_players_page.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({super.key, required this.uid});
  final String uid;

  Future<model.User?> _fetchUser() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return model.User.fromFirestore(doc.data()!, doc.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<model.User?>(
      future: _fetchUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final currentUser = snapshot.data!;

        Color getBorderColor() {
          if (currentUser.tags.contains("Competitive")) return Colors.redAccent;
          if (currentUser.tags.contains("Casual")) return Colors.greenAccent;
          if (currentUser.tags.contains("18+")) return Colors.orangeAccent;
          return Colors.grey;
        }

        void showZoomedAvatar() {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              child: InteractiveViewer(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(currentUser.profileImageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          );
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 143,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(side: const BorderSide(width: 5, color: Colors.grey)),
            onPressed: () {
              if (uid == MainPage.signedInUser!.uid) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PersonalProfilePage()));
              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (_) => DetailedFindPlayersPage(uid: uid),
                ));
              }
            },
            label: Row(
              children: [
                GestureDetector(
                  onTap: showZoomedAvatar,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: getBorderColor(), width: 4),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        currentUser.profileImageUrl ?? 'https://example.com/default-avatar.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 250,
                  child: Text(
                    currentUser.username,
                    style: const TextStyle(fontFamily: "Belwe", fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: 300,
                  child: Text(
                    currentUser.bio ?? "No bio provided",
                    style: const TextStyle(fontFamily: "Belwe", fontSize: 20, color: Colors.white),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
