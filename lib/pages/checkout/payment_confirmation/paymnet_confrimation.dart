import 'package:flutter/material.dart';
import 'package:travel_smartapp/domain/payment/payment_exception.dart';
import 'package:travel_smartapp/domain/payment/payment_service.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code.dart';

class PaymentConfirmation extends StatelessWidget {
  const PaymentConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: const Text("Confirm Payment"),
            onPressed: () async {
              try {
                await PaymentService.instance
                    .makePayment(amount: '250')
                    .then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const BookingCode();
                  }));
                });
              } on PaymentCancelException {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Payment Canceled"),
                  duration: Duration(seconds: 1),
                ));
              } catch (e) {}
            }),
      ),
    );
  }
}
