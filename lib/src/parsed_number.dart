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
}

class FormattedNumber {
  final String e164;
  final String national;
  final String international;

  FormattedNumber._({this.e164, this.national, this.international});
}
