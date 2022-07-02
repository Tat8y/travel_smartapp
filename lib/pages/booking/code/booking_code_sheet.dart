import 'package:flutter/material.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code.dart';

void showBookingCode(BuildContext context, {required TrainBooking booking}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => BookingCode(booking: booking),
    isScrollControlled: true,
  );
}
