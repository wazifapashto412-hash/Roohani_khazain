import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../app_state.dart';
import '../models.dart';

class EntryDetailScreen extends StatefulWidget {
  final AppState s; final Entry e;
  const EntryDetailScreen(this.s, this.e, {super.key});
  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  @override
  void initState() { super.initState(); widget.s.repo.setLastRead(widget.e.id); }

  String get _text => '${widget.e.arabic}\n\n${widget.e.urdu}\n\n${widget.e.reference}\n— روحانی خزائن';

  @override
  Widget build(BuildContext context) {
    final e = widget.e, repo = widget.s.repo, f = widget.s.fontScale;
    Widget sec(String h, String b) => b.isEmpty ? const SizedBox() : Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(h, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14 * f)),
          Text(b, style: TextStyle(fontSize: 18 * f, height: 1.9))]));
    return Scaffold(
      appBar: AppBar(title: Text(e.title), actions: [
        IconButton(icon: Icon(repo.isFav(e.id) ? Icons.favorite : Icons.favorite_border),
            onPressed: () async { await repo.toggleFav(e.id); setState(() {}); }),
        IconButton(icon: Icon(repo.isBookmarked(e.id) ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () async { await repo.toggleBookmark(e.id); setState(() {}); }),
        IconButton(icon: const Icon(Icons.copy), onPressed: () {
          Clipboard.setData(ClipboardData(text: _text));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('کاپی ہو گیا')));
        }),
        IconButton(icon: const Icon(Icons.share), onPressed: () => Share.share(_text)),
      ]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(e.arabic, textAlign: TextAlign.center, textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 28 * f, height: 2.0)),
        sec('اردو ترجمہ', e.urdu),
        sec('تلفظ', e.pronunciation),
        sec('وضاحت', e.explanation),
        sec('حوالہ', e.reference),
        sec('تعداد', e.count),
        sec('درجہ (حدیث)', e.grading),
        sec('فضیلت', e.virtue),
        sec('تحقیقی حیثیت', e.verificationStatus == 'pending_scholar_review'
            ? 'عالمِ دین سے تصدیق باقی ہے' : e.verificationStatus),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(icon: const Icon(Icons.text_decrease), onPressed: () => setState(() => widget.s.setFont((f - .1).clamp(.8, 1.8)))),
          IconButton(icon: const Icon(Icons.text_increase), onPressed: () => setState(() => widget.s.setFont((f + .1).clamp(.8, 1.8)))),
          TextButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('اصلاح بھیجنے کی سہولت جلد شامل کی جائے گی'))),
              child: const Text('غلطی کی اطلاع')),
        ]),
      ]),
    );
  }
}
