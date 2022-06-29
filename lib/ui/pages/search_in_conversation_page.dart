import 'package:flutter/material.dart';

class SearchInConversationPage extends StatefulWidget {
  const SearchInConversationPage({Key? key}) : super(key: key);

  @override
  State<SearchInConversationPage> createState() => _SearchInConversationPageState();
}

class _SearchInConversationPageState extends State<SearchInConversationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SafeArea(
          child: Text('Search in conversation'),
        ),
      ),
    );
  }
}
