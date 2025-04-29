import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.endIndent,
      required this.bio,
      required this.color,
      required this.tags});
  final double height;
  final double width;
  final String title;
  final double endIndent;
  final List<String> tags;
  final String bio;
  final Color color;

  String generateTagOutput(List<String> tags) {
    String tagOutput = "";
    for (String tag in tags) {
      tagOutput += " $tag,";
    }
    if (tagOutput == "") {
      return "None";
    } else {
      tagOutput = tagOutput.substring(0, tagOutput.length - 1);
      tagOutput += ".";
      return tagOutput;
    }
  }

  String generateBioOutput(String bio) {
    String bioOutput = "";
    if (bio.isEmpty) {
      bioOutput = "This user has not set a bio";
    } else {
      bioOutput = "Bio : $bio";
    }
    return bioOutput;
  }

  @override
  Widget build(BuildContext context) {
    String tagOutput = generateTagOutput(tags);
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
            padding: const EdgeInsets.only(left: 2.0, top: 8.0),
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
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 2.0),
  child: Align(
    alignment: Alignment.centerLeft,
    child: Text(
      "Tags : $tagOutput",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: "Belwe",
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    ),
  ),
),

          Expanded(
  child: Padding(
    padding: const EdgeInsets.all(2.0),
    child: SingleChildScrollView(
      child: Text(
        generateBioOutput(bio),
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Belwe",
          fontSize: 24,
        ),
      ),
    ),
  ),
),

        ],
      ),
    );
  }
}
