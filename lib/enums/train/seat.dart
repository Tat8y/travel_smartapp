enum SeatType { available, selected, unavailable }

const seatTypeToStr = {
  SeatType.available: 'available',
  SeatType.unavailable: 'unavailable',
  SeatType.selected: 'selected',
};

const seatTypeFromStr = {
  'available': SeatType.available,
  'unavailable': SeatType.unavailable,
  'selected': SeatType.selected,
};
