import 'package:flutter/material.dart';
import 'main.dart';

class MyFavScreen extends StatefulWidget {
  final List<Quote> quotes;
  const MyFavScreen({super.key, required this.quotes});

  @override
  State<MyFavScreen> createState() => _MyFavScreenState();
}

class _MyFavScreenState extends State<MyFavScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.quotes.isEmpty
        ? Center(
            child: Container(
                child: const Text(
                    'You do not have anything in your favourites yet!')))
        : ListView.builder(
            itemCount: widget.quotes.length,
            itemBuilder: (BuildContext ctxt, int i) {
              return ListTile(
                  title: Text(widget.quotes[i].quoteText),
                  subtitle: Text(widget.quotes[i].author));
            });
  }
}
