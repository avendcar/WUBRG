import 'package:flutter/material.dart';
import 'package:flutter_application_3/profile_page.dart';

void main() {
  runApp(HomePage());
}

String? _dropdownValue;
String displayedDropdownText = "Search filters";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void dropdownChangeText(String? selectedValue) {
    if (selectedValue is String) {
      setState(
        () {
          _dropdownValue = selectedValue;
          displayedDropdownText = selectedValue;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(
                //Consiste
                builder: (context) {
                  return IconButton(
                    padding: EdgeInsets.only(left: 5, right: 20),
                    color: Colors.white,
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    icon: const Icon(Icons.home),
                  );
                },
              ),
              Text(
                'W U B R G',
                style: TextStyle(
                    fontFamily: 'Belwe', color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SearchBar(
                  //Acts as the main search bar for the site
                  backgroundColor: WidgetStatePropertyAll(Colors.grey),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .4,
                      minHeight: 30),
                  leading: Icon(Icons.search),
                  hintText: "Search...",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  //Sets desired search filter
                  width: 130,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 125,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        dropdownColor: Colors.grey,
                        onTap: () {},
                        hint: Text(
                          displayedDropdownText,
                          selectionColor: Colors.white,
                          textAlign: TextAlign.justify,
                        ),
                        alignment: Alignment.centerLeft,
                        items: const [
                          DropdownMenuItem(
                            value: "All",
                            child: Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                "All",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: "Belwe"),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Events",
                            child: Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Text(
                                "Events",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: "Belwe"),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Players",
                            child: Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Text(
                                "Players",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: "Belwe"),
                              ),
                            ),
                          ),
                        ],
                        value: _dropdownValue,
                        onChanged: dropdownChangeText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          leadingWidth: MediaQuery.of(context).size.width,
          actions: [
            Builder(
              builder: (context) {
                return TextButton(
                  //Transitions to profile page
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                  child: Icon(Icons.person, color: Colors.white),
                );
              },
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: Container(
          //Background Image
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mtg-background.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SizedBox(
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: 500,
                      width: 1600,
                      child: Positioned(
                        child: Image(
                          image: AssetImage("images/sloth.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Main Content
        ),
      ),
    );
  }
}
