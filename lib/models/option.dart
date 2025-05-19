class Option<T> {
  final String label;
  final T value;

  const Option({required this.label, required this.value});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Option<T> &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          value == other.value;

  @override
  int get hashCode => label.hashCode ^ value.hashCode;
}
