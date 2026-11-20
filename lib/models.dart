class Chapter {
  final int id; final String ur; final String en;
  Chapter(this.id, this.ur, this.en);
  factory Chapter.fromJson(Map<String, dynamic> j) => Chapter(j['id'], j['ur'], j['en']);
}

class Entry {
  final String id, title, arabic, pronunciation, urdu, explanation, sourceType,
      sourceBook, sourceChapter, sourceNumber, grading, count, recommendedTime,
      virtue, verificationStatus, licensing;
  final int chapter;
  Entry.fromJson(Map<String, dynamic> j)
      : id = j['id'], title = j['title'], chapter = j['chapter'],
        arabic = j['arabic'], pronunciation = j['pronunciation'] ?? '',
        urdu = j['urdu'], explanation = j['explanation'] ?? '',
        sourceType = j['sourceType'], sourceBook = j['sourceBook'],
        sourceChapter = j['sourceChapter'], sourceNumber = j['sourceNumber'],
        grading = j['grading'] ?? '', count = j['count'] ?? '',
        recommendedTime = j['recommendedTime'] ?? '', virtue = j['virtue'] ?? '',
        verificationStatus = j['verificationStatus'], licensing = j['licensing'];

  String get reference => '$sourceBook - $sourceChapter - $sourceNumber';
}

/// Strip Arabic diacritics/tatweel and unify letter forms so searches match.
String normalize(String s) => s
    .replaceAll(RegExp('[\u064B-\u065F\u0670\u06D6-\u06ED\u0640]'), '')
    .replaceAll(RegExp('[\u0622\u0623\u0625]'), '\u0627')
    .replaceAll('\u064A', '\u06CC').replaceAll('\u0649', '\u06CC')
    .replaceAll('\u0643', '\u06A9').toLowerCase();
