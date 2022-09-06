
///Extension for get
extension IterableExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final E element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

///Extension for parser String to bool
extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}