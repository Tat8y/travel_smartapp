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
