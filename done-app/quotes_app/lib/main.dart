import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'favourites.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuoteSaverScreen(),
    );
  }
}

class QuoteSaverScreen extends StatefulWidget {
  @override
  _QuoteSaverScreenState createState() => _QuoteSaverScreenState();
}

class _QuoteSaverScreenState extends State<QuoteSaverScreen> {
  List<Quote> _quotes = [];
  List<Quote> favQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    // load the file contents as a string
    String jsonData = await rootBundle.loadString('assets/quotes.json');
    // convert string to json object
    final List<dynamic> quotesData = json.decode(jsonData);
    _quotes = quotesData.map((quoteData) => Quote.fromJson(quoteData)).toList();

    setState(() {});
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: _selectedIndex == 0
              ? const Text('My Quotes')
              : const Text('My favourites')),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            const BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: const Icon(Icons.favorite), label: 'Favourites'),
          ],
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              print(_selectedIndex);
            });
          }),
      body: _selectedIndex == 0
          ? Center(
              child: _quotes.isEmpty
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: _quotes.length,
                      itemBuilder: (BuildContext context, int i) {
                        final alreadySaved = favQuotes.contains(_quotes[i]);
                        return ListTile(
                          title: Text(_quotes[i].quoteText),
                          subtitle: Text(_quotes[i].author),
                          trailing: alreadySaved
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                ),
                          onTap: () {
                            setState(() {
                              alreadySaved
                                  ? favQuotes.remove(_quotes[i])
                                  : favQuotes.add(_quotes[i]);
                            });
                          },
                        );
                      },
                    ),
            )
          : MyFavScreen(quotes: favQuotes),
    );
  }
}

class Quote {
  final String quoteText;
  final String author;

  Quote({required this.quoteText, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(quoteText: json['quote'], author: json['author']);
  }
}
