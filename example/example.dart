import 'package:rank/rank.dart';

void main() {
  var rank = Rank();

  print(rank.generate()); // Expected: ñ

  var previousRank = 'n';
  var nextRank = 'ñ';

  // When there is no space, a character is added
  print(rank.generate(previous: previousRank, next: nextRank)); // Expected: nñ
}
