import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';
import 'package:travel_smartapp/domain/models/train_schedule_model.dart';

final demoTrains = [
  Train(
    id: "8311",
    name: "Night Mail",
    type: "Mail Train",
    seats: [],
  ),
  Train(
    id: "8320",
    name: "Samudra Devi",
    type: "Express Train",
    seats: [],
  ),
  Train(
    id: "8327",
    name: "Galu Kumari",
    type: "Long Distance",
    seats: [],
  ),
];

Future<List<String>> uploadSeats() async {
  int executive = 1;
  final columns = ['A', 'B', 'C', 'D'];
  final rows = List.generate(10, (index) => index + 1).toList();

  List<String> retVal = [];
  for (String column in columns) {
    for (int row in rows) {
      final seat = Seat(
        column: column,
        row: row,
        executive: executive,
      );
      await SeatService.firebase().create(seat.toMap()).then(
        (seat) {
          retVal.add(seat.id!);
          print(seat.id);
        },
      );
    }
  }
  return retVal;
}

void addTrains() async {
  for (Train train in demoTrains) {
    List<String> seats = await uploadSeats();
    await TrainService.firebase()
        .createWithId(id: train.id, map: train.copyWith(seats: seats).toMap())
        .then((value) => print(value));
  }
}

final demoStations = [
  TrainStation(name: "Colombo Fort"),
  TrainStation(name: 'Gampaha'),
  TrainStation(name: 'Ragama'),
  TrainStation(name: 'Veyangoda'),
];

void addStations() {
  for (TrainStation station in demoStations) {
    StationService.firebase()
        .create(station.toMap())
        .then((model) => print(model.id));
  }
}

final trains = [
  '8311', // Night Mail
  '8320', // Samudra Devi
  '8327', // Galu Kumari
];
final stations = [
  '1w0DTYj4CVC9rV7A1YZS', // Ragama
  '8Ydj2FHxbjCgkruhpE7p', // Veyangoda
  'DfwCh0YpDx7CCBAxmTcN', // Gampaha
  'elLn68z3gu8zThJSGnnZ' // Colombo Fort
];

DateTime now = DateTime.now();

final stops = [
  [stations[0], stations[1], stations[2], stations[3]],
  [stations[2], stations[3]],
  [stations[0], stations[1], stations[2]]
];

// Generate Train Stops for each train schedule. normal and reversed
List<Map<int, TrainScheduleStops>> generatebyTrainStops({
  required List<String> trainStops,
  required Duration delay,
  required DateTime date,
}) {
  List<Map<int, TrainScheduleStops>> retVal = [];
  retVal.add(_generateSchedule(
    stopList: trainStops,
    date: date,
    delay: delay,
  ));
  retVal.add(_generateSchedule(
    stopList: trainStops.reversed.toList(),
    date: date.add(const Duration(hours: 6)),
    delay: delay,
  ));

  return retVal;
}

// Generate Train Stops
Map<int, TrainScheduleStops> _generateSchedule({
  required DateTime date,
  required Duration delay,
  required List<String> stopList,
}) {
  Map<int, TrainScheduleStops> retVal = {};

  for (String station in stopList) {
    final time = date
        .add(Duration(minutes: delay.inMinutes * stopList.indexOf(station)));
    final stop = TrainScheduleStops(
      station: station,
      stopTimes: 1,
      arrivalTime: time,
      depature: time.add(const Duration(minutes: 1)),
      distanceFromStart: 50.0 * stopList.indexOf(station),
    );

    retVal[time.millisecondsSinceEpoch] = stop;
  }

  return retVal;
}

// Add Train Schedules to Firebase Firestore
void addTrainSchedules({
  required Duration delayBetweenTowStations,
  required DateTime startDate,
}) async {
  for (TrainSchedule schedule in generateDemoTrainSchedule(
      startDate: startDate, delay: delayBetweenTowStations)) {
    await TrainScheduleService.firebase().create(schedule.toMap()).then(
          (value) => print(value.id),
        );
  }
}

// Create Train Schedule for each Train
List<TrainSchedule> generateDemoTrainSchedule({
  required Duration delay,
  required DateTime startDate,
}) {
  List<TrainSchedule> retVal = [];
  for (String train in trains) {
    for (Map<int, TrainScheduleStops> stops in generatebyTrainStops(
        trainStops: stops[trains.indexOf(train)],
        delay: delay,
        date: startDate)) {
      retVal.add(TrainSchedule(
        stops: stops,
        startStation: stops.entries.first.value.station,
        endStation: stops.entries.last.value.station,
        train: train,
      ));
    }
  }

  return retVal;
}
