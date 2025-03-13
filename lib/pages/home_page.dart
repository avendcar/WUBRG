import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main_page.dart'; // Import your MainPage widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showAuthFields = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// Sends a POST request to your backend to create a new user.
  Future<void> createAccount(String username, String password) async {
    // Replace with your actual server URL/IP.
    final url = Uri.parse('http://192.168.1.131:3000/create-user');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      } else {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${responseData['error']}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a background image
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/mtg-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Opacity(
              opacity: 0.9,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Welcome text
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Welcome to WUBRG!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontFamily: "Belwe",
                          fontSize: 24,
                        ),
                      ),
                    ),
                    // Show "Sign Up/Sign In" button if auth fields are hidden.
                    if (!_showAuthFields)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _showAuthFields = true;
                            });
                          },
                          child: Text(
                            "Sign Up/Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: "Belwe",
                            ),
                          ),
                        ),
                      ),
                    // Display authentication fields when the button is pressed.
                    if (_showAuthFields)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            // Username/Email text field.
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: "Username/Email",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Password text field.
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Hyperlink for new users to create an account.
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  String username =
                                      _usernameController.text.trim();
                                  String password =
                                      _passwordController.text.trim();
                                  if (username.isEmpty || password.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please enter a username and password')),
                                    );
                                    return;
                                  }
                                  await createAccount(username, password);
                                },
                                child: Text(
                                  "New user? Create an account",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // "Enter" button for sign in.
                            ElevatedButton(
                              onPressed: () {
                                print("Enter button pressed");
                                String username =
                                    _usernameController.text.trim();
                                String password =
                                    _passwordController.text.trim();
                                if (username.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Please enter a username and password')),
                                  );
                                  return;
                                }
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()),
                                );
                              },
                              child: Text("Enter"),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
