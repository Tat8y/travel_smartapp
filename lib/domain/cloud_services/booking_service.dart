import 'package:travel_smartapp/domain/cloud/cloud_constatnts.dart';
import 'package:travel_smartapp/domain/cloud/cloud_provider.dart';
import 'package:travel_smartapp/domain/cloud/firebase_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';

class BookingService
    implements CloudProvider<TrainBooking, List<TrainBooking>> {
  final CloudProvider provider;
  BookingService(this.provider);

  factory BookingService.firebase() => BookingService(
        FirebaseCloudProvider(bookingsCollection),
      );

  @override
  Future<TrainBooking> create(Map<String, dynamic> map) async {
    return TrainBooking.fromMap(await provider.create(map));
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
  Stream<List<TrainBooking>> readCollection() {
    final snapshots = provider.readCollection() as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<TrainBooking> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainBooking.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<TrainBooking>> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots = provider.readCollectionByFilter(
        field: field, isEqualTo: isEqualTo) as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<TrainBooking> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainBooking.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<TrainBooking>> readCollectionByOrder(String field) {
    final snapshots =
        provider.readCollectionByOrder(field) as Stream<CollectionRef>;
    return snapshots.map((snapshot) {
      List<TrainBooking> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainBooking.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<TrainBooking> readDoc(String id) {
    final ref = provider.readDoc(id) as Stream<DocumentRef>;
    return ref.map((value) => TrainBooking.fromMap(value));
  }

  @override
  Future<TrainBooking> readDocFuture(String id) async {
    return TrainBooking.fromMap(await provider.readDocFuture(id));
  }

  @override
  Future<bool> update(
      {required String id, required Map<String, dynamic> json}) {
    return provider.update(id: id, json: json);
  }
}
