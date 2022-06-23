import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/api/suggestion_api.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/sheet_sheet.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';
import 'package:travel_smartapp/widgets/text_feild/auto_complete_text_feild.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController depatureController = TextEditingController();

  final TextEditingController destinationController = TextEditingController();

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: customAppBar(title: "Where Do You Want To Go?"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(kPadding * 0.8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      color: Colors.grey.shade200),
                  child: Column(
                    children: [
                      CustomAutoCompleteTextFeild(
                        suggestionsApi: SuggestionApi.trainSuggestion,
                        controller: depatureController,
                        hint: "From",
                      ),
                      const Divider(),
                      CustomAutoCompleteTextFeild(
                        suggestionsApi: SuggestionApi.trainSuggestion,
                        controller: destinationController,
                        hint: "To",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RawMaterialButton(
                        shape: const CircleBorder(),
                        fillColor: Colors.black12,
                        elevation: 0,
                        onPressed: () async {
                          await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050))
                              .then((_date) {
                            setState(() {
                              if (_date != null) date = _date;
                            });
                          });
                        },
                        child: const Icon(Icons.date_range_outlined),
                      ),
                      Text(DateFormat('yyyy-MM-dd').format(date)),
                      const Spacer(),
                      CustomButton(
                          text: "Next",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        const SelectSheetPage()));
                          })
                    ],
                  ),
                ),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(kBorderRadius)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
