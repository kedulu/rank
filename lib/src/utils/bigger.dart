/// Which of the two strings is [Bigger]
enum Bigger {
  /// The [PREV] (previous) element is [Bigger]
  PREV,

  /// [BOTH] are equals in length
  BOTH,

  /// The [NEXT] element  is [Bigger]
  NEXT
}

/// Helper to avoid having to write the switch in the main function.
extension Actions on Bigger {
  /// Execute the function depending on the [Bigger]
  Function? biggest({Function? prev, Function? next, Function? both}) {
    switch (this) {
      case Bigger.PREV:
        return prev;
      case Bigger.NEXT:
        return next;
      default:
        return both;
    }
  }
}

/// [compareLength] of the two strings, the [prev] (previous) and
/// the [next], returns a [Bigger].
Bigger compareLength(String prev, String next) {
  switch (prev.length.compareTo(next.length)) {
    case 1:
      return Bigger.PREV;
    case -1:
      return Bigger.NEXT;
    default:
      return Bigger.BOTH;
  }
}
