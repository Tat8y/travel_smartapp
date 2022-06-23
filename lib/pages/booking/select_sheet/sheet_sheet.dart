import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/enums/train/seat.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class SelectSheetPage extends StatelessWidget {
  const SelectSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Select Sheet",
        leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Column(
        children: [
          buildSheetMapMenu(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kPadding),
            child: Center(child: buildExecutive()),
          ),
          CustomButton(
              text: "Next",
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(kBorderRadius)),
                    ),
                    builder: (context) => Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: kPadding * .5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Your Seat"),
                                  Text("Exec 3/ Seat 7A")
                                ],
                              ),
                              const SizedBox(height: kPadding * .5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Total Price"),
                                  Text("250 LKR")
                                ],
                              ),
                              const SizedBox(height: kPadding),
                              CustomButton(
                                text: "Checkout",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const BookingCode()));
                                },
                                constraints:
                                    const BoxConstraints.expand(height: 50),
                              )
                            ],
                          ),
                        ));
              })
        ],
      ),
    );
  }

  Widget buildExecutive() {
    final data = generateSheets();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      padding: const EdgeInsets.all(kPadding * 2),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildExecutiveRow(data, "A"),
            buildExecutiveRow(data, "B"),
            buildExecutiveRowLabel(),
            buildExecutiveRow(data, "C"),
            buildExecutiveRow(data, "D"),
          ]),
    );
  }

  Column buildExecutiveRow(Map<String, Map<int, SeatType>> data, String key) {
    return Column(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Center(child: Text(key)),
        ),
        ...data[key]
                ?.entries
                .map((e) => InkWell(
                      onTap: () {},
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.check_box,
                          color: kSecondaryColor,
                        ),
                      ),
                    ))
                .toList() ??
            []
      ],
    );
  }

  Column buildExecutiveRowLabel() {
    return Column(children: [
      const SizedBox(height: 30),
      ...List.generate(
          10,
          (index) => SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: Text(index.toString(), textAlign: TextAlign.center),
                ),
              ))
    ]);
  }

  Widget buildSheetMapMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding,
        vertical: kPadding * .5,
      ),
      child: Row(
        children: [
          Expanded(
            child: _sheetMapMenuItem(
              text: "Available",
              icon: Icons.check_box_outline_blank_outlined,
            ),
          ),
          Expanded(
            child: _sheetMapMenuItem(
              text: "Selected",
              icon: Icons.check_box_rounded,
            ),
          ),
          Expanded(
            child: _sheetMapMenuItem(
              text: "Unavailable",
              icon: Icons.disabled_by_default_rounded,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Row _sheetMapMenuItem(
      {required String text, required IconData icon, Color? color}) {
    return Row(
      children: [
        Icon(icon, color: color ?? kSecondaryColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding * .2),
          child: Text(text),
        )
      ],
    );
  }

  /// { 'A':{1:SeatType, 2:SeatType} }
  Map<String, Map<int, SeatType>> generateSheets() {
    Map<String, Map<int, SeatType>> retVal = {};
    final row = List.generate(10, (index) => index);
    final columns = ['A', 'B', 'C', 'D'];
    for (String seatColumn in columns) {
      final rowIDs = <int, SeatType>{};
      for (int seatID in row) {
        rowIDs[seatID] = SeatType.available;
      }
      retVal[seatColumn] = rowIDs;
    }
    return retVal;
  }
}
