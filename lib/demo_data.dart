import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
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
