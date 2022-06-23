import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/sheet_sheet.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';
import 'package:travel_smartapp/widgets/text_feild/material_text_feild.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController depatureController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
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
                      CustomTextFeild(
                          controller: depatureController, hint: "From"),
                      const Divider(),
                      CustomTextFeild(
                          controller: destinationController, hint: "To"),
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
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050));
                        },
                        child: const Icon(Icons.date_range_outlined),
                      ),
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
