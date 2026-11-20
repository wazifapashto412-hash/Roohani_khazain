import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class Repository {
  List<Chapter> chapters = [];
  List<Entry> entries = [];
  late SharedPreferences prefs;

  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    final c = jsonDecode(await rootBundle.loadString('assets/content/chapters.json')) as List;
    final e = jsonDecode(await rootBundle.loadString('assets/content/entries.json')) as List;
    chapters = c.map((x) => Chapter.fromJson(x)).toList();
    entries = e.map((x) => Entry.fromJson(x)).toList();
  }

  List<Entry> inChapter(int id) => entries.where((e) => e.chapter == id).toList();

  List<Entry> search(String q) {
    final n = normalize(q.trim());
    if (n.isEmpty) return [];
    return entries.where((e) => normalize('${e.title} ${e.arabic} ${e.urdu} ${e.pronunciation}').contains(n)).toList();
  }

  Set<String> _set(String k) => (prefs.getStringList(k) ?? []).toSet();
  bool isFav(String id) => _set('fav').contains(id);
  Future<void> toggleFav(String id) async {
    final s = _set('fav'); s.contains(id) ? s.remove(id) : s.add(id);
    await prefs.setStringList('fav', s.toList());
  }
  List<Entry> favorites() => entries.where((e) => isFav(e.id)).toList();

  bool isBookmarked(String id) => _set('bm').contains(id);
  Future<void> toggleBookmark(String id) async {
    final s = _set('bm'); s.contains(id) ? s.remove(id) : s.add(id);
    await prefs.setStringList('bm', s.toList());
  }
  Future<void> setLastRead(String id) => prefs.setString('last', id);
  Entry? lastRead() {
    final id = prefs.getString('last');
    return entries.where((e) => e.id == id).cast<Entry?>().firstOrNull;
  }
  // Daily supplication: deterministic by date.
  Entry daily() {
    final d = DateTime.now();
    return entries[(d.year * 366 + d.month * 31 + d.day) % entries.length];
  }
}
