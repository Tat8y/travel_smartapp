import 'package:travel_smartapp/domain/models/seat_model.dart';

// Create Extention for seat contains
extension Contains on List<Seat> {
  bool seatContains(Seat seat) => map((e) => e.id).contains(seat.id);
}

extension Filter on List<Seat> {
  List<Seat> filter(List<String> seats) {
    return where((element) => seats.contains(element.id)).toList();
  }
}
