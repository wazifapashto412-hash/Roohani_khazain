import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import 'entry_detail_screen.dart';

class EntryListScreen extends StatelessWidget {
  final AppState s; final String title; final List<Entry> items;
  const EntryListScreen(this.s, this.title, this.items, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: items.isEmpty
            ? const Center(child: Text('اس باب میں ابھی مواد شامل نہیں کیا گیا۔'))
            : ListView(children: items.map((e) => ListTile(
                title: Text(e.title), subtitle: Text(e.reference),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => EntryDetailScreen(s, e))))).toList()),
      );
}
