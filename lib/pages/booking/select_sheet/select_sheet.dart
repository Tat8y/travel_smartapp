import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/api/seat_generator.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';
import 'package:travel_smartapp/enums/train/seat.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/executive_container.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/sheet_confirmation.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class SelectSheetPage extends StatefulWidget {
  final TravelRoute travelRoute;
  const SelectSheetPage({Key? key, required this.travelRoute})
      : super(key: key);

  @override
  State<SelectSheetPage> createState() => _SelectSheetPageState();
}

class _SelectSheetPageState extends State<SelectSheetPage> {
  final PageController pageController = PageController();
  int totalExecutves = 2;
  int currentExecutive = 0;
  List<SeatBox> selectedSheets = [];
  final data = kGenerateSeats();

  void currentExecutivePageChanged(int index) {
    setState(() {
      currentExecutive = index;
    });
  }

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
        mainAxisSize: MainAxisSize.max,
        children: [
          buildSheetMapMenu(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, index) => ExectiveWidget(
                        data: data,
                        onTap: (seats) {
                          setState(() {
                            selectedSheets = seats
                                .where((seat) => seat.type == SeatType.selected)
                                .toList();
                          });
                        }),
                    itemCount: totalExecutves,
                    scrollDirection: Axis.vertical,
                    onPageChanged: currentExecutivePageChanged,
                  ),
                ),
                builExecutiveSwicher()
              ],
            ),
          ),
          Text("Seat : ${selectedSheets.length}"),
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: CustomButton(
                text: "Continue",
                constraints: const BoxConstraints.expand(height: 50),
                onPressed: () {
                  openSheetConfirmation(context);
                }),
          )
        ],
      ),
    );
  }

  Widget builExecutiveSwicher() {
    return Padding(
      padding: const EdgeInsets.only(right: kPadding),
      child: RotatedBox(
        quarterTurns: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: currentExecutive != 0
                    ? () {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    : null,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                )),
            ElevatedButton(
              onPressed: () {},
              child: Text("Executive ${currentExecutive + 1}"),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: kPrimaryColor,
              ),
            ),
            IconButton(
                onPressed: currentExecutive + 1 != totalExecutves
                    ? () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    : null,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                )),
          ],
        ),
      ),
    );
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
}
