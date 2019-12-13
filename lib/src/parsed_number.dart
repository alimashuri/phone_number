class ParsedNumber {
  final String type;
  final String countryCode;
  final String nationalNumber;
  final String inputString;
  final FormattedNumber formatted;

  ParsedNumber._({
    this.type,
    this.countryCode,
    this.nationalNumber,
    this.inputString,
    this.formatted,
  });

  factory ParsedNumber.fromMap(map) {
    return ParsedNumber._(
      type: map['type'],
      countryCode: map['country_code'],
      nationalNumber: map['national_number'],
      formatted: FormattedNumber._(
        e164: map['e164'],
        national: map['national'],
        international: map['international'],
      ),
    );
  }

  @override
  String toString() {
    return 'ParsedNumber{type: $type, countryCode: $countryCode, nationalNumber: $nationalNumber, inputString: $inputString, formatted: $formatted}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParsedNumber &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          countryCode == other.countryCode &&
          nationalNumber == other.nationalNumber &&
          inputString == other.inputString &&
          formatted == other.formatted;

  @override
  int get hashCode =>
      type.hashCode ^
      countryCode.hashCode ^
      nationalNumber.hashCode ^
      inputString.hashCode ^
      formatted.hashCode;
}

class FormattedNumber {
  final String e164;
  final String national;
  final String international;

  FormattedNumber._({this.e164, this.national, this.international});

  @override
  String toString() {
    return 'FormattedNumber{e164: $e164, national: $national, international: $international}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormattedNumber &&
          runtimeType == other.runtimeType &&
          e164 == other.e164 &&
          national == other.national &&
          international == other.international;

  @override
  int get hashCode =>
      e164.hashCode ^ national.hashCode ^ international.hashCode;
}
