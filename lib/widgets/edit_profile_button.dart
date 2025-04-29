import 'package:flutter/material.dart';

import '../pages/edit_profile_page.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback? setStateCallback;

  const EditProfileButton({super.key, this.setStateCallback});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      child: const Icon(Icons.edit, color: Colors.white),
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditProfilePage()),
        );

        if (result == true && setStateCallback != null) {
          setStateCallback!(); // Trigger refresh
        }
      },
    );
  }
}
