-- Target SQLite schema (planned; v0.1 loads JSON assets + SharedPreferences).
CREATE TABLE chapters(id INTEGER PRIMARY KEY, title_ur TEXT, title_en TEXT);
CREATE TABLE entries(
 id TEXT PRIMARY KEY, title TEXT, chapter_id INTEGER REFERENCES chapters(id),
 arabic TEXT, pronunciation TEXT, urdu TEXT, explanation TEXT,
 source_type TEXT, source_book TEXT, source_chapter TEXT, source_number TEXT,
 grading TEXT, count TEXT, recommended_time TEXT, virtue TEXT,
 verification_status TEXT, licensing TEXT);
CREATE TABLE user_state(entry_id TEXT, is_favorite INT, is_bookmark INT);
