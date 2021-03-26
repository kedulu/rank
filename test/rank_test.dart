import 'package:rank/src/utils/utils.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import '../lib/rank.dart';

class TestModel {
  final String prev, next, expected;

  TestModel(
      {@required this.prev, @required this.next, @required this.expected});
}

class TestSplitModel {
  final String prev, next;
  final List<String> expected;

  TestSplitModel(
      {@required this.prev, @required this.next, @required this.expected});
}

void main() {
  group('Rank generate', () {
    Rank rank;
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

    valuesList.add(TestModel(prev: 'b', next: 'bb', expected: 'bab'));

    valuesList.add(TestModel(prev: 'b', next: 'bab', expected: 'baab'));

    valuesList.add(TestModel(prev: 'b', next: 'baab', expected: 'baaab'));

    valuesList.add(TestModel(prev: 'g', next: 'h', expected: 'gñ'));
    valuesList.add(TestModel(prev: 'dñ', next: 'e', expected: 'dt'));
    valuesList.add(TestModel(prev: 'dñ', next: 'dr', expected: 'dp'));
    valuesList.add(TestModel(prev: 'don', next: 'gh', expected: 'e'));

    valuesList.add(TestModel(prev: 'mbn', next: 'mñ', expected: 'mh'));
    valuesList.add(TestModel(prev: 'mbno', next: 'mño', expected: 'mh'));
    valuesList.add(TestModel(prev: 'j', next: 'kbskd', expected: 'jb'));
    valuesList.add(TestModel(prev: 'j', next: 'jc', expected: 'jb'));

    valuesList.add(TestModel(prev: 'j', next: 'jbñ', expected: 'jb'));
    valuesList.add(TestModel(prev: 'becedario', next: 'logic', expected: 'g'));

    valuesList.add(TestModel(prev: 'j', next: 'jb', expected: 'jab'));

    setUp(() {
      rank = Rank();
    });

    for (TestModel value in valuesList) {
      test(
          '"${value.prev}" , "${value.next}" : "${value.expected}"',
          () => expect(rank.generate(previous: value.prev, next: value.next),
              value.expected));
    }
  });

  group('Split by shorter', () {
    Rank rank;
    List<TestSplitModel> valuesList = [];

    valuesList.add(
      TestSplitModel(
        prev: 'ameba',
        next: 'ti',
        expected: ['am', 'e', 'ti'],
      ),
    );

    valuesList.add(
      TestSplitModel(
        prev: 'eucalipt',
        next: '',
        expected: ['', 'e'],
      ),
    );

    valuesList.add(
      TestSplitModel(
        prev: 'lib',
        next: 'l',
        expected: ['l', 'i', 'l'],
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
      Rank rank;

      List<TestModel> valuesList = [];
      valuesList.add(TestModel(prev: '', next: '', expected: ''));
      valuesList.add(TestModel(prev: 'a', next: 'n', expected: 'g'));
      valuesList.add(TestModel(prev: 'b', next: 'b', expected: 'b'));
      valuesList.add(TestModel(prev: 'l', next: 'l', expected: 'l'));
      valuesList.add(TestModel(prev: 'hakuna', next: 'matata', expected: 'j'));

      valuesList.add(TestModel(prev: 'na', next: 'nd', expected: 'nb'));

      valuesList
          .add(TestModel(prev: 'abecedario', next: 'logic', expected: 'f'));

      setUp(() => rank = Rank());
      for (TestModel value in valuesList) {
        test(
            '"${value.prev}" , "${value.next}" : "${value.expected}"',
            () => expect(
                rank.prefix(value.prev, value.next).response, value.expected));
      }
    },
  );

  group(
    'Rank sufix',
    () {
      Rank rank;

      setUp(() => rank = Rank());

      test('Before nothing, after nothing',
          () => expect(rank.suffix('', ''), 'ñ'));

      test('Before -> l, after nothing',
          () => expect(rank.suffix('l', ''), 'r'));

      test('Before nothing, after jaja',
          () => expect(rank.suffix('', 'aab'), 'b'));

      test('Before nothing, after jaja',
          () => expect(rank.suffix('a', ''), 'n'));

      test('Before nothing, after jaja',
          () => expect(rank.suffix('', 'a'), 'b'));

      test('Before -> ls, after nothing',
          () => expect(rank.suffix('ls', ''), 'r'));

      test('Before -> las, after l', () => expect(rank.suffix('as', ''), 'n'));

      test('Before -> lfs, after l', () => expect(rank.suffix('fs', ''), 'o'));

      test('Before nothing, after -> h',
          () => expect(rank.suffix('', 'h'), 'e'));

      test('Before nothing, after -> hhh',
          () => expect(rank.suffix('', 'hhh'), 'e'));

      test('Before a, after -> hhh', () => expect(rank.suffix('', 'hh'), 'e'));

      test('Before -> n, after -> ñ', () => expect(rank.suffix('', ''), 'ñ'));

      test('Before -> nñ, after -> ññ', () => expect(rank.suffix('', ''), 'ñ'));

      test('Before -> man, after -> mn',
          () => expect(rank.suffix('n', ''), 's'));
    },
  );
}
//   group(
//     'Rank generate',
//     () {
//       Rank rank;

//       setUp(() => rank = Rank());

//       test('Before nothing, after nothing', () => expect(rank.generate(), 'n'));

//       test('Before -> l, after nothing',
//           () => expect(rank.generate(previous: 'l'), 'r'));

//       test('Before -> ls, after nothing',
//           () => expect(rank.generate(previous: 'ls'), 'r'));

//       test('Before -> las, after l',
//           () => expect(rank.generate(previous: 'las', next: 'l'), 'ln'));

//       test('Before -> l, after nothing',
//           () => expect(rank.generate(next: 'l'), 'f'));

//       test('Before -> ls, after nothing',
//           () => expect(rank.generate(next: 'ls'), 'f'));

//       test('Before -> las, after l',
//           () => expect(rank.generate(previous: 'l', next: 'las'), 'la'));

//       test('Before nothing, after -> h',
//           () => expect(rank.generate(next: 'h'), 'd'));

//       test('Before nothing, after -> hhh',
//           () => expect(rank.generate(next: 'hhh'), 'd'));

//       test('Before -> n, after -> ñ',
//           () => expect(rank.generate(previous: 'n', next: 'ñ'), 'nn'));

//       test('Before -> nñ, after -> ññ',
//           () => expect(rank.generate(previous: 'nñ', next: 'ññ'), 'nñn'));

//       test('Before -> jk, after -> kk',
//           () => expect(rank.generate(previous: 'jk', next: 'kk'), 'jkn'));

//       test('Before -> mb, after -> mn',
//           () => expect(rank.generate(previous: 'mb', next: 'mn'), 'mh'));

//       test('Before -> na, after -> nd',
//           () => expect(rank.generate(previous: 'na', next: 'nd'), 'nb'));

//       test('Before -> man, after -> mn',
//           () => expect(rank.generate(previous: 'man', next: 'mn'), 'mg'));

//       test('Before -> man, after -> mn',
//           () => expect(rank.generate(previous: 'majfosdhn', next: 'mn'), 'mg'));

//       test('Before -> man, after -> mn',
//           () => expect(rank.generate(previous: 'maaspdoan', next: 'mn'), 'mg'));

//       test('Before -> man, after -> mn',
//           () => expect(rank.generate(previous: 'manaosid', next: 'mn'), 'mg'));

//       test('Before -> nd, after -> ng',
//           () => expect(rank.generate(previous: 'nd', next: 'ng'), 'ne'));

//       test('Before -> jkl, after -> jkm',
//           () => expect(rank.generate(previous: 'jkl', next: 'jkm'), 'jkln'));

//       test('Before -> mvc, after -> mzc',
//           () => expect(rank.generate(previous: 'mvc', next: 'mzc'), 'mxc'));

//       test(
//           'Before -> oooooo, after -> pppppp',
//           () => expect(
//               rank.generate(previous: 'oooooo', next: 'pppppp'), 'oooooon'));

//       test(
//           'Before -> hakuna, after -> matata',
//           () => expect(
//               rank.generate(previous: 'hakuna', next: 'matata'), 'jaokpa'));
//     },
//   );

// }
