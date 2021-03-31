/// Helps to obtain characters or characteristics related to a String
extension StringUtils on String {
  /// Returns the character [at] the position of [index].
  String at(int index) => String.fromCharCode(codeUnitAt(index));

  /// Returns the [first] character of the String.
  String first() => at(0);

  /// Returns the [last] character of the String.
  String last() => at(length - 1);

  /// Returns the [mean] character of the String.
  ///
  /// For example in the string 'aureo', returns 'r'
  String mean() => at(length ~/ 2);

  /// Returns the [mean] character relative to others chars.
  /// [one] and [two]
  ///
  /// For example in the string 'aureo',
  /// with parameters one='a' and two = 'r',
  /// returns 'u'
  String between(String one, String two) {
    var oneIndex = indexOf(one);
    var twoIndex = indexOf(two);

    var betweenIndex = (oneIndex + twoIndex) ~/ 2;

    return at(betweenIndex);
  }

  /// Returns true when the string [hasTogether] to [one] and [two].
  ///
  /// For example in the string 'aureo',
  /// with parameters one='a' and two = 'r',
  /// returns 'False'
  /// but, in the same string 'aureo',
  /// with parameters one='u' and two = 'r',
  /// returns 'True'
  bool hasTogether(String one, String two) {
    var oneIndex = indexOf(one);
    var twoIndex = indexOf(two);

    return (oneIndex - twoIndex).abs() <= 1; // == or <=
  }
}
