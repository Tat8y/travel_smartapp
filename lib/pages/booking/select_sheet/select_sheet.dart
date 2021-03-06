import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/models/support_models/booking_data_model.dart';
import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';
import 'package:travel_smartapp/domain/providers/booking_provider.dart';
import 'package:travel_smartapp/extension/context/localization.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/executive_container.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/select_seat_constants.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/sheet_confirmation.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class SelectSeatPage extends StatefulWidget {
  final TravelRoute route;
  const SelectSeatPage({Key? key, required this.route}) : super(key: key);

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  final PageController pageController = PageController();
  int totalExecutves = 2;
  int currentExecutive = 0;

  void currentExecutivePageChanged(int index) {
    setState(() {
      currentExecutive = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BookingProvider(),
        builder: (context, child) {
          // final bookingProvider = Provider.of<BookingProvider>(context);
          return Scaffold(
              appBar: customAppBar(
                context,
                title: context.loc!.select_seat,
                leading: IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildSheetMapMenu(),
                  buildExecutives(),
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: CustomButton(
                        text: context.loc!.continue_label,
                        constraints: const BoxConstraints.expand(height: 50),
                        onPressed: () {
                          final _seats = Provider.of<BookingProvider>(context,
                                  listen: false)
                              .selectedSeats;

                          if (_seats.isNotEmpty) {
                            openSheetConfirmation(
                              context,
                              bookingData: BookingDataModel(
                                route: widget.route,
                                seats:
                                    _seats.map<String>((e) => e.id!).toList(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: context.loc!.please_select_seat);
                          }
                        }),
                  )
                ],
              ));
        });
  }

  Widget buildExecutives() {
    return StreamBuilder<Train>(
        stream: TrainService.firebase().readDoc(widget.route.schedule.train),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ExectiveWidget(seats: snapshot.data!.seats),
            );
          } else {
            return const SizedBox();
          }
        });
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
              text: context.loc!.available,
              icon: availabelIcon,
            ),
          ),
          Expanded(
            child: _sheetMapMenuItem(
              text: context.loc!.selected,
              icon: selectedIcon,
            ),
          ),
          Expanded(
            child: _sheetMapMenuItem(
              text: context.loc!.unavailable,
              icon: unavailabelIcon,
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
