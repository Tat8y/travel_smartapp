import 'package:travel_smartapp/domain/models/seat_model.dart';

String generateSeatNumber(Seat seat) {
  return "${seat.column}${seat.row}";
}

String generateSeatNumberFromList(List<Seat> seats) {
  return seats.map((e) => generateSeatNumber(e)).join(" / ");
}
