import 'package:flutter/material.dart';

import '../pages/main_page.dart';

class PersistentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PersistentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.person_2_rounded),
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ],
      backgroundColor: Colors.black,
      title: Row(
        children: [
          // Wrap the logo in a GestureDetector to open the drawer.
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                child: Text(
                  "WUBRG",
                  style: TextStyle(
                    fontFamily: "Belwe",
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          Spacer(),
          // Search bar widget.
          SizedBox(
            width: 300,
            height: 35,
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
