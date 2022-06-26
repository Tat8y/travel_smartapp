import 'package:get/get.dart';
import 'package:travel_smartapp/domain/cloud_services/booking_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';

class TrainScheduleController extends GetxController {
  final items = <TrainSchedule>[].obs;

  @override
  void onInit() {
    items.bindStream(TrainScheduleService.firebase().readCollection());
    super.onInit();
  }
}

class BookingController extends GetxController {
  final items = <TrainBooking>[].obs;
  @override
  void onInit() {
    items.bindStream(BookingService.firebase().readCollection());
    super.onInit();
  }
}
