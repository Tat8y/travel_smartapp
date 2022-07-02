import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';

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

// Future<void> addTrainScheduls() async {
//   final trains = ['8311', '8320', '8327'];
//   final stations = ['zDwwK2Fbz9x1CW9mX3kF', '15vrvQB2eKQaMp8jmCgT'];

//   for (String train in trains) {
//     for (String station in stations) {
//       for (String estation in stations) {
//         if (station != estation) {
//           final _schedule = TrainSchedule(
//             train: train,
//             startStation: station,
//             endStation: estation,
//             arrivalTime: DateTime.now(),
//           );

//           await TrainScheduleService.firebase()
//               .create(_schedule.toMap())
//               .then((value) => print(value.id));
//         }
//       }
//     }
//   }
// }

final trains = ['8311', '8320', '8327'];
final stations = [
  '1w0DTYj4CVC9rV7A1YZS', // Ragama
  '8Ydj2FHxbjCgkruhpE7p', // Veyangoda
  'DfwCh0YpDx7CCBAxmTcN', // Gampaha
  'elLn68z3gu8zThJSGnnZ' // Colombo Fort
];

DateTime now = DateTime.now();

final demoTrainSchedules = [
  TrainSchedule(
    train: trains[0],
    startStation: stations[0],
    endStation: stations[3],
    stops: {
      now.millisecondsSinceEpoch.toString(): TrainScheduleStops(
        depature: now.add(const Duration(minutes: 2)),
        arrivalTime: now,
        station: stations[0],
        stopTimes: 1,
        distanceFromStart: 0,
      ),
      now.add(const Duration(minutes: 30)).millisecondsSinceEpoch.toString():
          TrainScheduleStops(
        depature: now.add(const Duration(minutes: 33)),
        arrivalTime: now.add(const Duration(minutes: 30)),
        station: stations[1],
        distanceFromStart: 27.5,
        stopTimes: 1,
      ),
      now.add(const Duration(minutes: 45)).millisecondsSinceEpoch.toString():
          TrainScheduleStops(
        depature: now.add(const Duration(minutes: 48)),
        arrivalTime: now.add(const Duration(minutes: 45)),
        station: stations[2],
        distanceFromStart: 48,
        stopTimes: 1,
      ),
      now.add(const Duration(hours: 1)).millisecondsSinceEpoch.toString():
          TrainScheduleStops(
        depature: now.add(const Duration(hours: 1, minutes: 10)),
        arrivalTime: now.add(const Duration(hours: 1)),
        station: stations[3],
        distanceFromStart: 86,
        stopTimes: 1,
      ),
    },
  ),
  TrainSchedule(
    train: trains[1],
    startStation: stations[3],
    endStation: stations[0],
    stops: {
      now.millisecondsSinceEpoch.toString(): TrainScheduleStops(
        depature: now.add(const Duration(minutes: 2, hours: 2)),
        arrivalTime: now.add(const Duration(hours: 2)),
        station: stations[3],
        stopTimes: 1,
        distanceFromStart: 0,
      ),
      now
          .add(const Duration(minutes: 30, hours: 2))
          .millisecondsSinceEpoch
          .toString(): TrainScheduleStops(
        depature: now.add(const Duration(minutes: 33, hours: 2)),
        arrivalTime: now.add(const Duration(minutes: 30, hours: 2)),
        station: stations[2],
        distanceFromStart: 27.5,
        stopTimes: 1,
      ),
      now
          .add(const Duration(minutes: 45, hours: 2))
          .millisecondsSinceEpoch
          .toString(): TrainScheduleStops(
        depature: now.add(const Duration(minutes: 48, hours: 2)),
        arrivalTime: now.add(const Duration(minutes: 45, hours: 2)),
        station: stations[1],
        distanceFromStart: 48,
        stopTimes: 1,
      ),
      now.add(const Duration(hours: 3)).millisecondsSinceEpoch.toString():
          TrainScheduleStops(
        depature: now.add(const Duration(hours: 3, minutes: 10)),
        arrivalTime: now.add(const Duration(hours: 3)),
        station: stations[0],
        distanceFromStart: 86,
        stopTimes: 1,
      ),
    },
  ),
  TrainSchedule(
    train: trains[2],
    startStation: stations[2],
    endStation: stations[0],
    stops: {
      now
          .add(const Duration(minutes: 30, hours: 2, days: 1))
          .millisecondsSinceEpoch
          .toString(): TrainScheduleStops(
        depature: now.add(const Duration(minutes: 33, hours: 2, days: 1)),
        arrivalTime: now.add(const Duration(minutes: 30, hours: 2, days: 1)),
        station: stations[2],
        distanceFromStart: 0,
        stopTimes: 1,
      ),
      now
          .add(const Duration(hours: 3, days: 1))
          .millisecondsSinceEpoch
          .toString(): TrainScheduleStops(
        depature: now.add(const Duration(hours: 3, days: 1, minutes: 10)),
        arrivalTime: now.add(const Duration(hours: 3, days: 1)),
        station: stations[0],
        distanceFromStart: 60,
        stopTimes: 1,
      ),
    },
  ),
];

void addTrainSchedules() async {
  for (TrainSchedule schedule in demoTrainSchedules) {
    await TrainScheduleService.firebase().create(schedule.toMap()).then(
          (value) => print(value.id),
        );
  }
}
