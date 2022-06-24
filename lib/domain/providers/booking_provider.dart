import 'package:flutter/cupertino.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';

class BookingProvider extends ChangeNotifier {
  final List<Seat> _selectedSeats = [];
  List<Seat> get selectedSeats => _selectedSeats;

  void addSeat(Seat seat) {
    _selectedSeats.add(seat);
    notifyListeners();
  }

  void removeSeat(Seat seat) {
    _selectedSeats.remove(seat);
    notifyListeners();
  }
}
