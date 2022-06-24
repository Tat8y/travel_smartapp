import 'package:get/get.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';

class SeatController extends GetxController {
  final items = <Seat>[].obs;

  @override
  void onInit() {
    items.bindStream(SeatService.firebase().readCollection());
    super.onInit();
  }
}
