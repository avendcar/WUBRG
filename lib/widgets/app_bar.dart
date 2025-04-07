import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar_search_bar.dart';
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
                child: Tooltip(
                  //Universal home page button
                  message: "Click to go to Home",
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "WUBRG",
                      style: TextStyle(
                        fontFamily: "Belwe",
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Spacer(),
          // Search bar widget.
          AppBarSearchBar(),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
