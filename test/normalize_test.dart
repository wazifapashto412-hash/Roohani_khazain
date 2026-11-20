import 'package:flutter_test/flutter_test.dart';
import 'package:roohani_khazain/models.dart';
void main() {
  test('diacritics stripped', () {
    expect(normalize('رَبِّ زِدْنِي عِلْمًا'), normalize('رب زدني علما'));
  });
}
