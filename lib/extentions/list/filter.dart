import 'package:travel_smartapp/domain/models/seat_model.dart';
// extension Filter<T> on List<T> {
//   List<T> sort(int Function(T, T) sortFunction) => map((items) {
//         items.sort(sortFunction);
//         return items;
//       });
// }

extension Contains on List<Seat> {
  bool seatContains(Seat seat) => map((e) => e.id).contains(seat.id);
}
