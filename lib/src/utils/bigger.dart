enum Bigger { PREV, BOTH, NEXT }

extension Actions on Bigger {
  void biggest(
      {Function? prev = null, Function? next = null, Function? both = null}) {
    switch (this) {
      case Bigger.PREV:
        prev;
        break;
      case Bigger.NEXT:
        next;
        break;
      default:
        both;
    }
  }
}

Bigger compareLength(String prev, String next) {
  switch (prev.length.compareTo(next.length)) {
    case 1:
      return Bigger.PREV;
      break;
    case -1:
      return Bigger.NEXT;
      break;
    default:
      return Bigger.BOTH;
  }
}
