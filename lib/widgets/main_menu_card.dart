import 'package:flutter/material.dart';

class MainMenuCard extends StatelessWidget {
  const MainMenuCard({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(title,
                    style: TextStyle(fontFamily: "Belwe", fontSize: 32),
                    textAlign: TextAlign.start),
                subtitle: SizedBox(
                  width: 25,
                  height: 200,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        side: WidgetStatePropertyAll(
                          BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      icon: Image.asset(
                          "images/kuriboh.png"), //Placeholder for leading icon before each subtitle
                      label: Text(
                        subtitle,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontFamily: "Belwe", color: Colors.black),
                      ),
                      iconAlignment: IconAlignment.start,
                      onPressed: () {},
                    ),
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
