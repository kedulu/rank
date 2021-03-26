extension StringUtils on String {
  String at(index) => String.fromCharCode(this.codeUnitAt(index));

  String first() => at(0);

  String last() => at(this.length - 1);

  String mean() => at(this.length ~/ 2);

  String between(String one, String two) {
    int oneIndex = this.indexOf(one);
    int twoIndex = this.indexOf(two);

    int betweenIndex = (oneIndex + twoIndex) ~/ 2;

    return this.at(betweenIndex);
  }

  bool hasTogether(String one, String two) {
    int oneIndex = this.indexOf(one);
    int twoIndex = this.indexOf(two);

    return (oneIndex - twoIndex).abs() <= 1; // == or <=
  }
}
