import 'package:flutter/material.dart';
import 'package:flutter_application_3/delegates/search_delegate.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 35,
      child: TextButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchScreenProviderDelegate(),
          );
        },
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.white, size: 32),
            SizedBox(width: 10),
            Text(
              "Search for users and events...",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Belwe",
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
