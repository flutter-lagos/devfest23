enum Status {
  success('success'),
  error('error');

  const Status(this.json);

  final String json;
}

extension StatusX on String {
  Status get status {
    return Status.values.firstWhere(
      (element) => element.json == this,
      orElse: () => throw Exception('No status type defined for $this'),
    );
  }
}
