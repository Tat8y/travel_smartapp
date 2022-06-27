// import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
// import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
// import 'package:travel_smartapp/domain/models/station_mode.dart';
// import 'package:travel_smartapp/domain/models/train_model.dart';

// final demoStations = [
//   TrainStation(name: "Galle"),
//   TrainStation(name: "Colombo"),
// ];

import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';
import 'package:travel_smartapp/enums/train/seat.dart';

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

// void addStations() {
//   for (TrainStation station in demoStations) {
//     StationService.firebase()
//         .create(station.toMap())
//         .then((model) => print(model.id));
//   }
// }

void addTrains() async {
  for (Train train in demoTrains) {
    print(train.name);
    List<String> seats = await uploadSeats();
    await TrainService.firebase()
        .createWithId(id: train.id, map: train.copyWith(seats: seats).toMap())
        .then((value) => print(value));
  }
}
