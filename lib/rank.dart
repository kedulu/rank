library rank;

import 'package:rank/src/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:dartdoc/dartdoc.dart';

class ResultPrefix {
  final String response;
  final bool hasSuffix;

  ResultPrefix({@required this.response, @required this.hasSuffix});
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
    } else if (previous.length < next.length) {
      if (next.last() == alphabet.first()) {
        var pref = next.substring(0, next.length - 1);
        var suff = next.substring(next.length - 1);

        return pref + wildcard + suff;

        //rankGenerated += alphabet.first() + alphabet.mean();
      }

      ResultPrefix resultPrefix = prefix(splitted[2], splitted[0]);
      rankGenerated = resultPrefix.response;

      if (resultPrefix.hasSuffix) {
        rankGenerated += suffix('', splitted[1]);
      }

      return rankGenerated;
    }
  }

  /// Split the [larger] element, so that it fits in length to the [shorter] element,
  /// returns a list with the [bigger] element cut, the [shorter] element
  /// and if it exists, the first residue char of the [bigger].
  List<String> splitByShorter({String bigger, String shorter}) {
    int limit = shorter.length;
    List<String> response = [];

    response.add(bigger.substring(0, limit));
    response.add(bigger.substring(limit, limit + 1));

    if (limit != 0) {
      response.add(shorter.substring(0, limit));
    }

    return response;
  }

  List<String> orderByLength({String one, String two}) {
    if (one.length > two.length) {
      return [one, two];
    } else {
      return [two, one];
    }
  }

  ResultPrefix prefix(String previousRank, String nextRank) {
    String response = '';

    // if (previousRank.isEmpty) return '';
    // if (nextRank.isEmpty) return '';

    for (int i = 0; i < previousRank.length; i++) {
      print('$previousRank es decir - $nextRank');
      var current = alphabet.between(previousRank.at(i), nextRank.at(i));

      response += current;

      if (current != previousRank.at(i)) {
        return ResultPrefix(response: response, hasSuffix: false);
      }
    }
    return ResultPrefix(response: response, hasSuffix: true);
  }

  String suffix(String previousRank, String nextRank) {
    if (previousRank.isEmpty && nextRank.isEmpty) return alphabet.mean();

    var _prev =
        (previousRank.isEmpty) ? alphabet.first() : previousRank.first();
    var _next = (nextRank.isEmpty) ? alphabet.last() : nextRank.first();

    return alphabet.between(_prev, _next);
  }
}

/// A Rank.
class Rank2 {
  /// Get the position based at [before] element and [after] element.
  String position2({String before, String after}) => before + after;

  //Basado en el ranking Jira

  String position({String before = '', String after = ''}) {
    //Alfabeto de posibles valores del ranking
    List alfabeto = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'ñ',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z',
      '0'
    ];

    /// Before y after vacio al inicio
    String bef = '';
    String aft = '';

    //Indices por defecto son los extremos
    int indexBef = 0;
    int indexAft = alfabeto.length - 1;

    //Letra asignada
    String nowIndex = '';

    //Prefijo de la asignacion
    String prefix = '';

    //Que indice es mas largo, el anterior o el posterior?
    //0 si es el anterior
    //1 si es el posterior
    //2 si son iguales
    int big = (before.length > after.length)
        ? 0
        : (before.length < after.length)
            ? 1
            : 2;

    //Si el anterior no esta vacio
    //Si el anterior es mayor o son iguales
    if (before != '' && big != 1) {
      // //print('if 1');
      // //print('getRank PREFIX : $prefix');
      bef = before.substring(before.length - 1);
      // //print('getRank BEF : $bef');
      indexBef = alfabeto.indexOf(bef);
      // //print('getRank INDEX BEF : $indexBef');
    } else {
      //Si el anterior esta vacio
      //Si el anterior es menor
      bef = 'a';
    }
    if (after != '' && big != 0) {
      //Si despues no esta vacio
      // y si el despues es mayor o son iguales
      // //print('if 2');
      aft = after.substring(after.length - 1);
      indexAft = alfabeto.indexOf(aft);
      // //print('indes AFT = $indexAft');
    }

    if (big == 0) {
      if (after == '') {
        // //print('pick in a up');
        prefix = before.substring(0, before.length - 1);
      } else {
        // //print('pick in a up ELSE');
        prefix = before.substring(0, before.length - 1);
      }

      // //print('0 : $prefix');
    } else if (big == 1) {
      if (before == '') {
        // //print('ariana g');
        prefix = after.substring(0, after.length - 1);
      } else {
        // //print('ariana g ELSE');
        prefix = before;
      }
      // //print('1 : $prefix');
    } else {
      //Cuando son iguales en longitud
      if (before.length > 1) {
        prefix = before.substring(0, before.length - 1);
      } else {
        prefix = ''; // before.substring(0, before.length - 1);
      }
    }
    // //print('PREFIXXXXX : $prefix');

    int difference = indexAft - indexBef;
    // //print('getRank INDEX AFT : $indexAft');
    // //print('getRank INDEX BEF : $indexBef');
    if (difference <= 1) {
      // //print('if 3');
      nowIndex = bef + 'n';
    } else {
      // //print('if 4 else');
      // //print('getRank DIFF : $difference');
      int index = ((difference / 2) + indexBef).floor();
      // //print('getRank INDEX : $index');
      nowIndex = alfabeto[index];
//    if (big != 2) {
//      // //print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEENNNNNNNNNNNTTTRO');
//      nowIndex = before + nowIndex;
//    }
      // //print('getRank NOW : $nowIndex');
      //TODO insertar a cuando se requiera poner algo antes de a
    }

    // //print('WITH PREFIX ${prefix + nowIndex}');

    return prefix + nowIndex;
  }
}
