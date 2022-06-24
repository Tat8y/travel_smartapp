import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';

typedef StationCallBack = Function(TrainStation);

class CustomAutoCompleteTextFeild extends StatefulWidget {
  final Future<List<TrainStation>> Function(String) suggestionsApi;
  final TextEditingController controller;
  final String hint;

  const CustomAutoCompleteTextFeild({
    Key? key,
    required this.suggestionsApi,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  State<CustomAutoCompleteTextFeild> createState() =>
      _CustomAutoCompleteTextFeildState();
}

class _CustomAutoCompleteTextFeildState
    extends State<CustomAutoCompleteTextFeild> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<TrainStation>(
      getImmediateSuggestions: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(kPadding * 0.5),
          isDense: true,
          hintText: widget.hint,
          border: InputBorder.none,
          label: Text(widget.hint),
        ),
      ),
      suggestionsCallback: widget.suggestionsApi,
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.name ?? ""),
          subtitle: const Text('Railway Station'),
        );
      },
      onSuggestionSelected: (station) async {
        widget.controller.text = station.name!;
      },
    );
  }
}
