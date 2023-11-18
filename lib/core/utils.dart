extension ListX<E> on List<E> {
  List<E> safeSublist(int length) {
    try {
      return sublist(0, length);
    } on RangeError {
      return this;
    }
  }
}
