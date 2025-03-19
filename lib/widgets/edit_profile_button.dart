import 'package:flutter/material.dart';

import '../pages/edit_profile_page.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfilePage(),
          ),
        );
      },
      child: Text(
        " Edit Profile",
        style:
            TextStyle(color: Colors.white, fontFamily: "Belwe", fontSize: 24),
      ),
    );
  }
}
