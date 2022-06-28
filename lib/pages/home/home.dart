import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/api/suggestion_api.dart';
import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/controllers.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';
import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/select_sheet.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/text_feild/auto_complete_text_feild.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TrainScheduleController trainScheduleController =
      Get.put(TrainScheduleController());
  final TextEditingController depatureController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  DateTime date = DateTime.now();

  String? startStation;
  String? endStation;

  @override
  void initState() {
    depatureController.addListener(getStartStation);
    destinationController.addListener(getEndtStation);
    super.initState();
  }

  void getStartStation() async {
    await StationService.firebase().readCollectionFuture().then((stations) {
      final _list = stations
          .where((element) => element.name == depatureController.text)
          .toList();
      if (_list.isNotEmpty) {
        setState(() {
          startStation = _list.first.id;
        });
      }
    });
  }

  void getEndtStation() async {
    await StationService.firebase().readCollectionFuture().then((stations) {
      final _list = stations
          .where((element) => element.name == destinationController.text)
          .toList();
      if (_list.isNotEmpty) {
        setState(() {
          endStation = _list.first.id;
        });
      }
    });
  }

  void navigate(TrainSchedule schedule) async {
    // Navigating to SelectSeatPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => SelectSeatPage(schedule: schedule),
      ),
    );
  }

  void pickDate() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Where Do You Want To Go?"),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(kPadding * 0.8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  color: Colors.grey.shade200),
              child: Column(
                children: [
                  // Autocomplete Text Feild
                  CustomAutoCompleteTextFeild(
                    suggestionsApi: SuggestionApi.trainSuggestion,
                    controller: depatureController,
                    hint: "From",
                  ),

                  const Divider(),

                  // Autocomplete Text Feild
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
                    onPressed: pickDate,
                    child: const Icon(Icons.date_range_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kPadding),
                    child: Text(DateFormat('yyyy - MM - dd').format(date)),
                  ),
                  // const Spacer(),
                  // CustomButton(
                  //   text: "Next",
                  //   onPressed: validate,
                  //   loading: buttonLoading,
                  // )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kPadding),
              child: Text(
                'Available Trains',
                style: TextStyle(
                  fontSize: kFontSize * 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: buildAvailabelTrains()),
          ],
        ),
      ),
    );
  }

  Widget buildAvailabelTrains() {
    return GetX<TrainScheduleController>(builder: (controller) {
      List<TrainSchedule> schedules = controller.items
          .where((p0) =>
              p0.startStation == startStation && p0.endStation == endStation)
          .toList();
      if (schedules.isEmpty) return const Center(child: Text("No Data"));
      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              TrainSchedule schedule = schedules[index];
              return _trainCard(schedule);
            },
            childCount: schedules.length,
          ))
        ],
      );
    });
  }

  Widget _trainCard(TrainSchedule schedule) {
    return FutureBuilder<Train>(
        future: TrainService.firebase().readDocFuture(schedule.train),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          Train _train = snapshot.data!;
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius / 2),
            ),
            child: InkWell(
              onTap: () => navigate(schedule),
              child: Padding(
                padding: const EdgeInsets.all(kPadding * .5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: const Icon(Icons.train_rounded,
                              color: kSecondaryColor),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kSecondaryColor.withOpacity(0.1),
                          ),
                        ),
                        const SizedBox(width: kPadding),
                        Text(
                          _train.name ?? '',
                          style: const TextStyle(
                            fontSize: kFontSize * .6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: kPadding / 2),
                        Text(
                          _train.type ?? '',
                          style: TextStyle(
                            fontSize: kFontSize * .6,
                            color: context.theme.textTheme.bodyText1?.color
                                ?.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FutureBuilder<TrainStation>(
                              future: StationService.firebase()
                                  .readDocFuture(schedule.startStation),
                              builder: (context, snapshot) {
                                return Container(
                                  // alignment: Alignment.center,
                                  padding: const EdgeInsets.all(kPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "From",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: kFontSize * .5,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data?.name ?? "",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: kFontSize,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Container(
                          width: 1,
                          color: Colors.black12,
                          height: 30,
                        ),
                        Expanded(
                          child: FutureBuilder<TrainStation>(
                              future: StationService.firebase()
                                  .readDocFuture(schedule.endStation),
                              builder: (context, snapshot) {
                                return Container(
                                  padding: const EdgeInsets.all(kPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "To",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: kFontSize * .5,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data?.name ?? "",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: kFontSize,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
