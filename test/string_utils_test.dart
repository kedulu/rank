import 'package:rank/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group(
    'String utils',
    () {
      test('Get the N character', () => expect('eucalipto'.at(5), 'i'));

      test('Get the first character', () => expect('eucalipto'.first(), 'e'));

      test('Get the last character', () => expect('eucalipto'.last(), 'o'));

      test('Get the mean character, alphabet odd',
          () => expect('eucalipto'.mean(), 'l'));

      test('Get the mean character, alphabet even',
          () => expect('stark'.mean(), 'a'));
    },
  );
}
