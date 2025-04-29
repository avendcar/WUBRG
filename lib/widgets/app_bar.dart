import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/search_bar_widget.dart';
import '../pages/main_page.dart';

class PersistentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;

  const PersistentAppBar({super.key, this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      bottom: bottom,
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.person_2_rounded),
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ],
      title: Row(
        children: [
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
                  message: "Click to go to Home",
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: const Text(
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
          const Spacer(),
          const SearchBarWidget(),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
