extension ListX<E> on List<E> {
  List<E> safeSublist(int length) {
    try {
      return sublist(0, length);
    } on RangeError {
      return this;
    }
  }
}

String nthNumber(int day) {
  if (day > 3 && day < 21) return 'th';
  return switch (day % 10) {
    1 => 'st',
    2 => 'nd',
    3 => 'rd',
    _ => 'th',
  };
}
