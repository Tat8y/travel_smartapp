import 'package:travel_smartapp/domain/cloud/cloud_constatnts.dart';
import 'package:travel_smartapp/domain/cloud/cloud_provider.dart';
import 'package:travel_smartapp/domain/cloud/firebase_service.dart';
import 'package:travel_smartapp/domain/models/booking_schedule_model.dart';

class BookingScheduleService
    implements CloudProvider<BookingSchedule, List<BookingSchedule>> {
  final CloudProvider provider;
  BookingScheduleService(this.provider);

  factory BookingScheduleService.firebase() => BookingScheduleService(
        FirebaseCloudProvider(bookingScheduleCollection),
      );

  @override
  Future<BookingSchedule> create(Map<String, dynamic> map) async {
    return BookingSchedule.fromMap(await provider.create(map));
  }

  @override
  Future<bool> createWithId(
      {required String id, required Map<String, dynamic> map}) async {
    return provider.createWithId(id: id, map: map);
  }

  @override
  Future<bool> delete({required String id}) {
    return provider.delete(id: id);
  }

  @override
  Stream<List<BookingSchedule>> readCollection() {
    final snapshots = provider.readCollection() as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<BookingSchedule> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(BookingSchedule.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<BookingSchedule>> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots = provider.readCollectionByFilter(
        field: field, isEqualTo: isEqualTo) as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<BookingSchedule> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(BookingSchedule.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<BookingSchedule>> readCollectionByOrder(String field) {
    final snapshots =
        provider.readCollectionByOrder(field) as Stream<CollectionRef>;
    return snapshots.map((snapshot) {
      List<BookingSchedule> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(BookingSchedule.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<BookingSchedule> readDoc(String id) {
    final ref = provider.readDoc(id) as Stream<DocumentRef>;
    return ref.map((value) => BookingSchedule.fromMap(value));
  }

  @override
  Future<BookingSchedule> readDocFuture(String id) async {
    return BookingSchedule.fromMap(await provider.readDocFuture(id));
  }

  @override
  Future<bool> update(
      {required String id, required Map<String, dynamic> json}) {
    return provider.update(id: id, json: json);
  }
}
