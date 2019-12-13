import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/src/parsed_number.dart';
import 'package:phone_number/src/region.dart';

const _phoneNumberChannel = MethodChannel('com.julienvignali/phone_number');

class PhoneNumber {
  final MethodChannel _channel;

  PhoneNumber._(this._channel);

  factory PhoneNumber() => PhoneNumber._(_phoneNumberChannel);

  @visibleForTesting
  factory PhoneNumber.withChannel(channel) => PhoneNumber._(channel);

  Future<ParsedNumber> parse(String string, {String region}) async {
    final args = {"string": string, "region": region};
    final res = await _channel.invokeMapMethod<String, dynamic>("parse", args);
    return ParsedNumber.fromMap(res);
  }

  Future<dynamic> parseList(List<String> strings, {String region}) {
    final args = {"strings": strings, "region": region};
    return _channel.invokeMethod("parse_list", args);
  }

  Future<dynamic> format(String string, String region) {
    final args = {"string": string, "region": region};
    return _channel.invokeMethod("format", args);
  }

  /// Returns a dictionary of all supported regions & their country code.
  Future<List<Region>> allSupportedRegions() async {
    final list = await _channel.invokeListMethod<Map>(
      "get_all_supported_regions",
    );
    return list.map(Region.fromMap).toList(growable: false);
  }
}
