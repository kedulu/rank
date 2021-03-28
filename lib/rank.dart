library rank;

import 'package:rank/src/utils/utils.dart';

class ResultPrefix {
  final String response;
  final bool hasSuffix;

  ResultPrefix({required this.response, required this.hasSuffix});
}

class Rank {
  /// Possible ranking values (Range)
  String wildcard = 'a';
  String alphabet = 'bcdefghijklmnñopqrstuvwxyz';

  /// Generate a rank based at their neighbors, the [previous] element and [next] element.
  String generate({String previous = '', String next = ''}) {
    String rankGenerated;

    if (previous.length == next.length) {
      ResultPrefix resultPrefix = prefix(previous, next);

      rankGenerated = resultPrefix.response;

      if (resultPrefix.hasSuffix) {
        rankGenerated += alphabet.mean();
      }

      return rankGenerated;
    }

    var order = orderByLength(one: previous, two: next);
    var splitted = splitByShorter(bigger: order[0], shorter: order[1]);

    if (previous.length > next.length) {
      ResultPrefix resultPrefix = prefix(splitted[0], splitted[2]);
      rankGenerated = resultPrefix.response;

      if (resultPrefix.hasSuffix) {
        rankGenerated += suffix(splitted[1], '');
      }

      return rankGenerated;
    }
    //By default previous.length < next.length

    if (next.last() == alphabet.first()) {
      var pref = next.substring(0, next.length - 1);
      //var suff = next.substring(next.length - 1);

      return pref + wildcard + alphabet.mean();

      //rankGenerated += alphabet.first() + alphabet.mean();
    }

    ResultPrefix resultPrefix = prefix(splitted[2], splitted[0]);
    rankGenerated = resultPrefix.response;

    if (resultPrefix.hasSuffix) {
      rankGenerated += suffix('', splitted[1]);
    }

    return rankGenerated;
  }

  /// Split the [larger] element, so that it fits in length to the [shorter] element,
  /// returns a list with the [bigger] element cut, the [shorter] element
  /// and if it exists, the first residue char of the [bigger].
  List<String> splitByShorter(
      {required String bigger, required String shorter}) {
    int limit = shorter.length;
    List<String> response = [];

    response.add(bigger.substring(0, limit));
    response.add(bigger.substring(limit));

    if (limit != 0) {
      response.add(shorter.substring(0, limit));
    }

    return response;
  }

  /// Compare two strings by your length and return a list
  /// with the bigger and shorter.

  List<String> orderByLength({required String one, required String two}) {

    if (one.length > two.length) {
      return [one, two];
    } else {
      return [two, one];
    }
  }

  /// Return a string between [previousRank] and [nextRank]
  /// as a condition, both params must be of the same length
  ResultPrefix prefix(String previousRank, String nextRank) {
    String response = '';

    // if (previousRank.isEmpty) return '';
    // if (nextRank.isEmpty) return '';

    for (int i = 0; i < previousRank.length; i++) {
      var current;

      if (nextRank.at(i) == wildcard) {
        current = wildcard;
      } else if (previousRank.at(i) == wildcard) {
        if (nextRank.at(i) == alphabet.first()) {
          current = wildcard;
        } else {
          current = alphabet.between(alphabet.first(), nextRank.at(i));
        }
      } else {
        current = alphabet.between(previousRank.at(i), nextRank.at(i));
      }

      response += current;

      if (current != previousRank.at(i)) {
        return ResultPrefix(response: response, hasSuffix: false);
      }
    }
    return ResultPrefix(response: response, hasSuffix: true);
  }

  String suffix(String previousRank, String nextRank) {
    if (previousRank.isEmpty && nextRank.isEmpty) return alphabet.mean();

    if (previousRank.contains(wildcard) || nextRank.contains(wildcard)) {
      if (previousRank.isEmpty) {
        // Previous is empty

        var response = nextRank.substring(0, nextRank.length - 1);

        if (nextRank.last() == alphabet.first()) {
          return response + wildcard + alphabet.mean();
        }
        response += alphabet.between(
          alphabet.first(),
          nextRank.last(),
        );

        return response;
      } else {
        // Next is empty

        var response = previousRank.substring(0, previousRank.length - 1);

        response += alphabet.between(previousRank.last(), alphabet.last());

        return response;
      }
    }

    var _prev =
        (previousRank.isEmpty) ? alphabet.first() : previousRank.first();
    var _next = (nextRank.isEmpty) ? alphabet.last() : nextRank.first();

    return alphabet.between(_prev, _next);
  }
}
