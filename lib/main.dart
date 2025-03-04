import 'package:flutter/material.dart';
import 'package:flutter_application_3/profile_page.dart';

void main() {
  runApp(HomePage());
}

String? _dropdownValue;

void dropdownCallBack(String? selectedValue) {
  if (selectedValue is String) {
    _dropdownValue = selectedValue;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              color: Colors.white,
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(Icons.home),
            );
          }),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          actions: [
            SearchBar(
              constraints: BoxConstraints(maxWidth: 450, minHeight: 30),
              leading: Icon(Icons.search),
              hintText: "Search...",
            ),
            Container(
              width: 130,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.rectangle,
                border: Border.all(width: 3, color: Colors.white),
                borderRadius: BorderRadius.circular(10)
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 125,
                child: new DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text(
                      "Search filters",
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
                          ),
                        ),
                      ),
                    ],
                    value: _dropdownValue,
                    onChanged: dropdownCallBack,
                  ),
                ),
              ),
            ),
            Builder(builder: (context) {
              return TextButton(
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
            }),
          ],
          backgroundColor: Colors.black,
          title: Text(
            textAlign: TextAlign.center,
            'W U B R G',
            style: TextStyle(fontFamily: 'Belwe', color: Colors.white),
          ),
        ),
        body: Image.asset('images/mtg-background.png'),
      ),
    );
  }
}
