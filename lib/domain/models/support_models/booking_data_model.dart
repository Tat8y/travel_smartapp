import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';

class BookingDataModel {
  final TravelRoute route;
  final List<String> seats;

  BookingDataModel({
    required this.route,
    required this.seats,
  });
}
