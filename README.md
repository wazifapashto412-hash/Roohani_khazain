# Roohani Khazain — روحانی خزائن
Author/compiler: مولانا جواد علی صاحب

**Status: early skeleton (v0.1), untested, 9 sample entries, 14 chapter shells.**
All Arabic and hadith references were written without database verification and must be reviewed by a qualified scholar. Hadith numbers are marked "pending".

## Setup
1. Install Flutter (stable). 2. In this folder run `flutter create . --platforms=android,ios` to generate native folders (they are not included). 3. `flutter pub get` 4. `flutter run`.
5. Add fonts per docs/FONTS notes in pubspec.yaml.

## Ads
Disabled by default (lib/ads_config.dart). google_mobile_ads is commented out in pubspec; consent (UMP) and production IDs are still to do.

## Not yet built
SQLite migration (docs/schema.sql), Asma ul Husna, chapters 2–14 content, book/PDF/EPUB, splash/icon, error-report form, ads integration.
