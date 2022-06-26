import 'package:flutter/cupertino.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';

class BookingProvider extends ChangeNotifier {
  final List<Seat> _selectedSeats = [];
  List<Seat> get selectedSeats => _selectedSeats;

  TravelRoute? _travelRoute;
  TravelRoute? get travelRoute => _travelRoute;

  void addSeat(Seat seat) {
    _selectedSeats.add(seat);
    notifyListeners();
  }

  void removeSeat(Seat seat) {
    _selectedSeats.removeWhere((item) => item.id == seat.id);
    notifyListeners();
  }

  void setTravelRoute(TravelRoute route) {
    _travelRoute = route;
    notifyListeners();
  }
}
