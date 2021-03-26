import 'package:rank/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Bigger utils',
    () {
      test('Compare empty with empty ',
          () => expect(compareLength('', ''), Bigger.BOTH));

      test('Compare p with empty ',
          () => expect(compareLength('p', ''), Bigger.PREV));

      test('Compare empty with j ',
          () => expect(compareLength('', 'j'), Bigger.NEXT));
    },
  );
}
