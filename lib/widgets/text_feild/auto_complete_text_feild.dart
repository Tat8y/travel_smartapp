import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';

class CustomAutoCompleteTextFeild<T> extends StatelessWidget {
  final Future<List<TrainStation>> Function(String) suggestionsApi;
  final TextEditingController controller;
  final String hint;
  const CustomAutoCompleteTextFeild(
      {Key? key,
      required this.suggestionsApi,
      required this.controller,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<TrainStation>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(kPadding * 0.5),
          isDense: true,
          hintText: hint,
          border: InputBorder.none,
          label: Text(hint),
        ),
      ),
      suggestionsCallback: suggestionsApi,
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.name ?? ""),
          subtitle: const Text('Railway Station'),
        );
      },
      onSuggestionSelected: (station) {
        controller.text = station.name!;
      },
    );
  }
}
