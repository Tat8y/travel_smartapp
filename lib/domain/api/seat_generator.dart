import 'package:travel_smartapp/domain/models/seat_model.dart';

// Map<String, Map<int, SeatType>> generateSheets() {
//   Map<String, Map<int, SeatType>> retVal = {};
//   final row = List.generate(10, (index) => index + 1);
//   final columns = ['A', 'B', 'C', 'D'];
//   for (String seatColumn in columns) {
//     final rowIDs = <int, SeatType>{};
//     for (int seatID in row) {
//       rowIDs[seatID] = SeatType.available;
//     }
//     retVal[seatColumn] = rowIDs;
//   }
//   return retVal;
// }

// List<SeatBox> kGenerateSeats() {
//   List<SeatBox> retVal = [];
//   final rowItems = List.generate(10, (index) => index + 1);
//   final columnItems = ['A', 'B', 'C', 'D'];
//   for (String column in columnItems) {
//     for (int row in rowItems) {
//       retVal.add(
//         SeatBox(
//             column: column, row: row, type: SeatType.available, executive: 1),
//       );
//     }
//   }
//   return retVal;
// }

// List<Seat> kGenerateSeats() {
//   List<Seat> retVal = [];
//   SeatService.firebase().readCollection().map((seats) => retVal = seats);
//   return retVal;
// }

List<String> getColumns(List<Seat> seats) {
  return seats.map<String>((seat) => seat.column).toSet().toList();
}

List<Seat> getSeatsByColumn(List<Seat> seats, String key) {
  final list = seats.where((seat) => seat.column == key).toList();
  list.sort((a, b) => a.row.compareTo(b.row));
  return list;
}

// Future<List<Seat>> getColumnsFromSeats(List<String> seats, String key) async {
//   List<Seat> retVal = [];
//   for (String seat in seats) {
//     await SeatService.firebase()
//         .readDocFuture(seat)
//         .then((value) => retVal.add(value));
//   }

//   final list = seats.where((seat) => seat == key).toList();
//   list.sort((a, b) => a.compareTo(b));
//   return list;
// }


