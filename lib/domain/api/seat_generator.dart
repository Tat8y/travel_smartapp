import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/enums/train/seat.dart';

/// { 'A':{1:SeatType, 2:SeatType} } TODO:
Map<String, Map<int, SeatType>> generateSheets() {
  Map<String, Map<int, SeatType>> retVal = {};
  final row = List.generate(10, (index) => index + 1);
  final columns = ['A', 'B', 'C', 'D'];
  for (String seatColumn in columns) {
    final rowIDs = <int, SeatType>{};
    for (int seatID in row) {
      rowIDs[seatID] = SeatType.available;
    }
    retVal[seatColumn] = rowIDs;
  }
  return retVal;
}

List<SeatBox> kGenerateSeats() {
  List<SeatBox> retVal = [];
  final rowItems = List.generate(10, (index) => index + 1);
  final columnItems = ['A', 'B', 'C', 'D'];
  for (String column in columnItems) {
    for (int row in rowItems) {
      retVal.add(
        SeatBox(
            column: column, row: row, type: SeatType.unavailable, executive: 1),
      );
    }
  }
  return retVal;
}

List<String> getColumns(List<SeatBox> seats) {
  return seats.map<String>((seat) => seat.column).toSet().toList();
}

List<SeatBox> getSeatsByColumn(List<SeatBox> seats, String key) {
  return seats.where((seat) => seat.column == key).toList();
}
