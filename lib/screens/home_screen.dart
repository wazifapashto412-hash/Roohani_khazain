import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import 'entry_list_screen.dart';
import 'entry_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState s;
  const HomeScreen(this.s, {super.key});

  @override
  Widget build(BuildContext context) {
    final repo = s.repo;
    final daily = repo.daily();
    final last = repo.lastRead();
    return Scaffold(
      appBar: AppBar(
        title: const Text('روحانی خزائن'),
        actions: [
          IconButton(icon: const Icon(Icons.search), tooltip: 'تلاش',
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen(s)))),
          IconButton(icon: const Icon(Icons.favorite), tooltip: 'پسندیدہ',
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => EntryListScreen(s, 'پسندیدہ', repo.favorites())))),
          IconButton(icon: Icon(s.dark ? Icons.light_mode : Icons.dark_mode), tooltip: 'تھیم',
              onPressed: () => s.setDark(!s.dark)),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(12), children: [
        Image.asset('assets/images/logo.jpg', height: 160),
        const Center(child: Text('مولانا جواد علی صاحب')),
        const SizedBox(height: 12),
        Card(child: ListTile(
          title: const Text('آج کی دعا'), subtitle: Text(daily.title),
          onTap: () => _open(context, daily))),
        if (last != null)
          Card(child: ListTile(
            title: const Text('پڑھنا جاری رکھیں'), subtitle: Text(last.title),
            onTap: () => _open(context, last))),
        const SizedBox(height: 8),
        ...repo.chapters.map((c) => Card(child: ListTile(
              leading: CircleAvatar(child: Text('${c.id}')),
              title: Text(c.ur), subtitle: Text(c.en),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => EntryListScreen(s, c.ur, repo.inChapter(c.id))))))),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text('مواد پر نظرِ ثانی (علماء سے تصدیق) باقی ہے۔',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ),
      ]),
    );
  }

  void _open(BuildContext c, Entry e) =>
      Navigator.push(c, MaterialPageRoute(builder: (_) => EntryDetailScreen(s, e)));
}
