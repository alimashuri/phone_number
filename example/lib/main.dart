import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  PhoneNumber _plugin = PhoneNumber();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      final parsed = await _plugin.parse("49988151701", region: "BR");

      platformVersion = """   
      
type: ${parsed.type}
e164: ${parsed.formatted.e164} 
international: ${parsed.formatted.international}
national: ${parsed.formatted.national}
country code: ${parsed.countryCode}
national number: ${parsed.nationalNumber}
      """;

      final formatted = await _plugin.format('+47234723432', 'BR');
      platformVersion += """
      
partially: ${formatted['formatted']}
      """;

      final parsedValues =
          await _plugin.parseList(["+48606723456", "+48774843312"]);

      parsedValues.forEach((number, parsed) {
        if (parsed != null) {
          platformVersion += """
          
type: ${parsed['type']}
e164: ${parsed['e164']}
international: ${parsed['international']}
national: ${parsed['national']}
country code: ${parsed['country_code']}
national number: ${parsed['national_number']}
          """;
        } else {
          platformVersion += """
          
number not recognized: $number
          """;
        }
      });
    } on PlatformException catch (e) {
      platformVersion = 'Failed: ${e.message}';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: <Widget>[
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.list),
                tooltip: 'All Supported Regions',
                onPressed: () => _handleGetAll(context),
              );
            })
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Text(
              _platformVersion,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleGetAll(BuildContext context) async {
    final all = await _plugin.allSupportedRegions();
    all.sort((a, b) => a.countryCode.compareTo(b.countryCode));

    await showDialog(
      context: context,
      builder: (context) {
        final List<TableRow> rows = all.map((region) {
          return TableRow(children: [
            Text(region.countryCode),
            Text('${region.code}'),
          ]);
        }).toList();
        return AlertDialog(
          title: Text('All Supported Regions'),
          content: SingleChildScrollView(
            child: Table(children: rows),
          ),
        );
      },
    );
  }
}
