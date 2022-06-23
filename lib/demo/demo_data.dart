// import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
// import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
// import 'package:travel_smartapp/domain/models/station_mode.dart';
// import 'package:travel_smartapp/domain/models/train_model.dart';

// final demoStations = [
//   TrainStation(name: "Galle"),
//   TrainStation(name: "Colombo"),
// ];

// final demoTrains = [
//   Train(
//     id: "8311",
//     name: "Night Mail",
//     type: "Mail Train",
//   ),
//   Train(
//     id: "8320",
//     name: "Samudra Devi",
//     type: "Express Train",
//   ),
//   Train(
//     id: "8327",
//     name: "Galu Kumari",
//     type: "Long Distance",
//   ),
// ];

// void addStations() {
//   for (TrainStation station in demoStations) {
//     StationService.firebase()
//         .create(station.toMap())
//         .then((model) => print(model.id));
//   }
// }

// void addTrains() {
//   for (Train train in demoTrains) {
//     TrainService.firebase()
//         .createWithId(id: train.id, map: train.toMap())
//         .then((value) => print(value));
//   }
// }
