import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  final List<DHUCountry> countries = DHUCountry.generate();
  List<DHUCountry> filteredCountries = [];
  String searchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    filteredCountries = countries;
  }

  // Debounce search to optimize performance
  void updateSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      performSearch(query);
    });
  }

  void performSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase().trim();
      filteredCountries = CountrySearchService(countries).search(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search widget
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Search Countries',
              border: OutlineInputBorder(),
            ),
            onChanged: updateSearch,
          ),
        ),
        if (filteredCountries.isEmpty)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'No countries found for "$searchQuery".',
              style: const TextStyle(fontSize: 18),
            ),
          )
        else
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, i) {
                final country = filteredCountries[i];
                final nativeCommonName = country.nativeNames.isNotEmpty
                    ? '(${country.nativeNames.first.common})'
                    : '';

                return ListTile(
                  leading: Text(
                    country.flagEmoji,
                    style: const TextStyle(fontSize: 50),
                  ),
                  title: buildHighlightedText(
                      '${country.commonName} $nativeCommonName', searchQuery),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Official: ${country.officialName}'),
                      Text('Region: ${country.region}, ${country.subregion}'),
                      Text('Capital: ${country.capital ?? 'N/A'}'),
                      Text('ISO: ${country.iso2} / ${country.iso3}'),
                      Text('Phone Code: ${country.phoneCode}'),
                      Text('Area: ${country.area.toStringAsFixed(0)} km²'),
                      if (country.currencies.isNotEmpty)
                        Text(
                            'Currency: ${country.currencies.map((c) => c.name).join(', ')}'),
                      if (country.languages.isNotEmpty)
                        Text(
                            'Languages: ${country.languages.map((l) => l.name).join(', ')}'),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // Highlight matching text
  Widget buildHighlightedText(String text, String query) {
    final queryRegex = RegExp(RegExp.escape(query), caseSensitive: false);
    final matches = queryRegex.allMatches(text);
    if (matches.isEmpty) return Text(text);

    final spans = <TextSpan>[];
    var lastIndex = 0;
    for (final match in matches) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: const TextStyle(backgroundColor: Colors.yellow),
      ));
      lastIndex = match.end;
    }
    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return RichText(
      text:
          TextSpan(children: spans, style: DefaultTextStyle.of(context).style),
    );
  }
}
