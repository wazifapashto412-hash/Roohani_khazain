import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import 'entry_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final AppState s;
  const SearchScreen(this.s, {super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Entry> results = [];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: TextField(
          autofocus: true, style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: 'اردو یا عربی میں تلاش کریں', border: InputBorder.none),
          onChanged: (q) => setState(() => results = widget.s.repo.search(q)))),
        body: ListView(children: results.map((e) => ListTile(
            title: Text(e.title), subtitle: Text(e.reference),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => EntryDetailScreen(widget.s, e))))).toList()),
      );
}
