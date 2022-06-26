import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_smartapp/domain/cloud_services/booking_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Your Bookings"),
      body: StreamBuilder<UserModel>(
          stream: UserService.firebase()
              .readDoc(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            List<String> bookings = snapshot.data!.bookings ?? [];
            return CustomScrollView(slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => buildBookingCard(bookings[index]),
                      childCount: bookings.length))
            ]);
          }),
    );
  }

  Widget buildBookingCard(String bookingID) {
    return StreamBuilder<TrainBooking>(
        stream: BookingService.firebase().readDoc(bookingID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          TrainBooking booking = snapshot.data!;
          return ListTile(
            title: Text(booking.id!),
            subtitle: Text(booking.arrivalTime.toIso8601String()),
          );
        });
  }
}
