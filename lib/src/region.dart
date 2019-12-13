class Region {
  final int code;
  final String countryCode;

  Region._({this.code, this.countryCode});

  static Region fromMap(map) {
    return Region._(
      countryCode: map['country_code'],
      code: map['code'],
    );
  }

  @override
  String toString() {
    return 'Region{code: $code, countryCode: $countryCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Region &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          countryCode == other.countryCode;

  @override
  int get hashCode => code.hashCode ^ countryCode.hashCode;
}
