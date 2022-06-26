import 'package:flutter/material.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code.dart';

class PaymentConfirmation extends StatelessWidget {
  const PaymentConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: const Text("Confirm Payment"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const BookingCode();
              }));
            }),
      ),
    );
  }
}
