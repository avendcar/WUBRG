import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
class DeckBuilderPage extends StatefulWidget {
  const DeckBuilderPage({super.key});

  @override
  State<DeckBuilderPage> createState() => _DeckBuilderPageState();
}

class _DeckBuilderPageState extends State<DeckBuilderPage> {
  final currentUser = auth.FirebaseAuth.instance.currentUser;
  final DatabaseReference _cardsRef = FirebaseDatabase.instance.ref('cards');

  List<Map<String, dynamic>> allCards = [];
  List<Map<String, dynamic>> deckCards = [];

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
    final snapshot = await _cardsRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      setState(() {
        allCards = data.entries.map((e) {
          final value = Map<String, dynamic>.from(e.value);
          value['id'] = e.key;
          return value;
        }).toList();
      });
    }
  }

  void addToDeck(Map<String, dynamic> card) {
    setState(() {
      deckCards.add(card);
    });
  }

  void removeFromDeck(Map<String, dynamic> card) {
    setState(() {
      deckCards.remove(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MTG Deck Builder')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: allCards.length,
              itemBuilder: (context, index) {
                final card = allCards[index];
                return ListTile(
                  leading: card['imageUrl'] != null
                      ? Image.network(card['imageUrl'], width: 50, height: 50)
                      : const Icon(Icons.image_not_supported),
                  title: Text(card['name'] ?? 'Unnamed Card'),
                  subtitle: Text(card['manaCost'] ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => addToDeck(card),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Deck Preview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: deckCards.length,
              itemBuilder: (context, index) {
                final card = deckCards[index];
                return Card(
                  child: Column(
                    children: [
                      card['imageUrl'] != null
                          ? Image.network(card['imageUrl'], width: 80, height: 110)
                          : const Icon(Icons.image, size: 80),
                      Text(card['name'] ?? '', style: const TextStyle(fontSize: 12)),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => removeFromDeck(card),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
