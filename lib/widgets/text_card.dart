import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.endIndent,
      required this.textBox,
      required this.color});
  final double height;
  final double width;
  final String title;
  final double endIndent;
  final Text textBox;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 43, 42, 42),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 10),
      ),
      height: height,
      width: width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Belwe", fontSize: 24),
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: endIndent,
            /*
            Distance from the right edge of the card
            to the right end of the divider
            */
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textBox,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
