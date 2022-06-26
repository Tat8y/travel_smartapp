import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';
import 'package:travel_smartapp/enums/train/seat.dart';

void uploadSeats() async {
  int executive = 1;
  final columns = ['A', 'B', 'C', 'D'];
  final rows = List.generate(10, (index) => index + 1).toList();

  for (String column in columns) {
    for (int row in rows) {
      final seat = Seat(
        column: column,
        row: row,
        executive: executive,
        seatType: SeatType.available,
      );
      await SeatService.firebase().create(seat.toMap()).then(
            (seat) => print(seat.id),
          );
    }
  }
}

Future<void> addTrainScheduls() async {
  final trains = ['8311', '8320', '8327'];
  final stations = ['zDwwK2Fbz9x1CW9mX3kF', '15vrvQB2eKQaMp8jmCgT'];

  for (String train in trains) {
    for (String station in stations) {
      for (String estation in stations) {
        if (station != estation) {
          final _schedule = TrainSchedule(
            train: train,
            startStation: station,
            endStation: estation,
            arrivalTime: DateTime.now(),
          );

          await TrainScheduleService.firebase()
              .create(_schedule.toMap())
              .then((value) => print(value.id));
        }
      }
    }
  }
}
