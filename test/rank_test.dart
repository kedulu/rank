import 'package:test/test.dart';
import 'package:meta/meta.dart';

import '../lib/rank.dart';

class TestModel {
  final String prev, next, expected;

  TestModel(
      {required this.prev, required this.next, required this.expected});
}

class TestSplitModel {
  final String prev, next;
  final List<String> expected;

  TestSplitModel(
      {required this.prev, required this.next, required this.expected});
}

void main() {
  group(
    'Rank generate',
    () {
      late Rank rank;
      List<TestModel> valuesList = [];

      // Values for generated test
      valuesList.add(TestModel(prev: '', next: '', expected: 'ñ'));
      valuesList.add(TestModel(prev: 'b', next: 'z', expected: 'n'));
      valuesList.add(TestModel(prev: 'b', next: 'n', expected: 'h'));
      valuesList.add(TestModel(prev: 'n', next: 'z', expected: 's'));
      valuesList.add(TestModel(prev: 'b', next: 'ñ', expected: 'h'));
      valuesList.add(TestModel(prev: 'b', next: 'f', expected: 'd'));
      valuesList.add(TestModel(prev: 'b', next: 'e', expected: 'c'));
      valuesList.add(TestModel(prev: 'b', next: 'c', expected: 'bñ'));
      valuesList.add(TestModel(prev: 'b', next: 'bn', expected: 'bh'));
      valuesList.add(TestModel(prev: 'b', next: 'bg', expected: 'bd'));
      valuesList.add(TestModel(prev: 'b', next: 'bd', expected: 'bc'));

      valuesList.add(TestModel(prev: 'b', next: 'bc', expected: 'bb'));

      valuesList.add(TestModel(prev: 'b', next: 'bb', expected: 'bañ'));

      valuesList.add(TestModel(prev: 'b', next: 'bañ', expected: 'bah'));

      valuesList.add(TestModel(prev: 'b', next: 'bbc', expected: 'bb'));

      valuesList.add(TestModel(prev: 'b', next: 'bbbc', expected: 'bb'));

      valuesList.add(TestModel(prev: 'g', next: 'h', expected: 'gñ'));
      valuesList.add(TestModel(prev: 'dñ', next: 'e', expected: 'dt'));
      valuesList.add(TestModel(prev: 'dñ', next: 'dr', expected: 'dp'));
      valuesList.add(TestModel(prev: 'don', next: 'gh', expected: 'e'));
      valuesList.add(TestModel(prev: 'mbn', next: 'mñ', expected: 'mh'));
      valuesList.add(TestModel(prev: 'mbno', next: 'mño', expected: 'mh'));
      valuesList.add(TestModel(prev: 'j', next: 'kbskd', expected: 'jb'));
      valuesList.add(TestModel(prev: 'j', next: 'jc', expected: 'jb'));

      valuesList.add(TestModel(prev: 'j', next: 'jbñ', expected: 'jb'));
      valuesList
          .add(TestModel(prev: 'becedario', next: 'logic', expected: 'g'));

      valuesList.add(TestModel(prev: 'j', next: 'jb', expected: 'jañ'));

      valuesList.add(TestModel(prev: 'jk', next: 'jkb', expected: 'jkañ'));

      valuesList.add(TestModel(prev: 'jk', next: 'jkab', expected: 'jkaañ'));

      valuesList.add(TestModel(prev: 'jkaab', next: 'jkab', expected: 'jkaan'));

      valuesList
          .add(TestModel(prev: 'jkaab', next: 'jkaañ', expected: 'jkaah'));

      setUp(() {
        rank = Rank();
      });

      for (TestModel value in valuesList) {
        test(
          '"${value.prev}" , "${value.next}" : "${value.expected}"',
          () => expect(rank.generate(previous: value.prev, next: value.next),
              value.expected),
        );
      }
    },
  );

  group('Split by shorter', () {
    late Rank rank;
    List<TestSplitModel> valuesList = [];

    valuesList.add(
      TestSplitModel(
        prev: 'ameba',
        next: 'ti',
        expected: ['am', 'eba', 'ti'],
      ),
    );

    valuesList.add(
      TestSplitModel(
        prev: 'eucalipt',
        next: '',
        expected: ['', 'eucalipt'],
      ),
    );

    valuesList.add(
      TestSplitModel(
        prev: 'lib',
        next: 'l',
        expected: ['l', 'ib', 'l'],
      ),
    );

    valuesList.add(
      TestSplitModel(
        prev: 'e',
        next: '',
        expected: ['', 'e'],
      ),
    );
    valuesList.add(
      TestSplitModel(
        prev: 'even',
        next: 'odd',
        expected: ['eve', 'n', 'odd'],
      ),
    );

    setUp(() {
      rank = Rank();
    });

    for (TestSplitModel value in valuesList) {
      test(
          '"${value.prev}" , "${value.next}" : "${value.expected}"',
          () => expect(
              rank.splitByShorter(bigger: value.prev, shorter: value.next),
              value.expected));
    }
  });

  group(
    'Rank prefix',
    () {
      late Rank rank;

      List<TestModel> valuesList = [];
      valuesList.add(TestModel(prev: '', next: '', expected: ''));
      valuesList.add(TestModel(prev: 'a', next: 'n', expected: 'h'));
      valuesList.add(TestModel(prev: 'b', next: 'b', expected: 'b'));
      valuesList.add(TestModel(prev: 'l', next: 'l', expected: 'l'));
      valuesList.add(TestModel(prev: 'hakuna', next: 'matata', expected: 'j'));

      valuesList.add(TestModel(prev: 'na', next: 'nd', expected: 'nc'));

      valuesList
          .add(TestModel(prev: 'abecedario', next: 'logic', expected: 'g'));

      setUp(() => rank = Rank());
      for (TestModel value in valuesList) {
        test(
            '"${value.prev}" , "${value.next}" : "${value.expected}"',
            () => expect(
                rank.prefix(value.prev, value.next).response, value.expected));
      }
    },
  );

  group('Rank sufix', () {
    late Rank rank;

    List<TestModel> valuesList = [];
    valuesList.add(TestModel(prev: '', next: '', expected: 'ñ'));
    valuesList.add(TestModel(prev: 'l', next: '', expected: 'r'));
    valuesList.add(TestModel(prev: '', next: 'aab', expected: 'aaañ'));
    valuesList.add(TestModel(prev: 'a', next: '', expected: 'n'));
    valuesList.add(TestModel(prev: '', next: 'a', expected: 'b'));
    valuesList.add(TestModel(prev: 'ls', next: '', expected: 'r'));
    valuesList.add(TestModel(prev: 'as', next: '', expected: 'av'));
    valuesList.add(TestModel(prev: 'fs', next: '', expected: 'o'));
    valuesList.add(TestModel(prev: '', next: 'añ', expected: 'ah'));
    valuesList.add(TestModel(prev: '', next: 'h', expected: 'e'));
    valuesList.add(TestModel(prev: '', next: 'hhh', expected: 'e'));
    valuesList.add(TestModel(prev: 'n', next: '', expected: 's'));

    setUp(() => rank = Rank());

    for (TestModel value in valuesList) {
      test('"${value.prev}" , "${value.next}" : "${value.expected}"',
          () => expect(rank.suffix(value.prev, value.next), value.expected));
    }
  });
}
