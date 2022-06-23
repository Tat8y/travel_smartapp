import 'package:travel_smartapp/domain/cloud/cloud_constatnts.dart';
import 'package:travel_smartapp/domain/cloud/cloud_provider.dart';
import 'package:travel_smartapp/domain/cloud/firebase_service.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';

class SeatService implements CloudProvider<Seat, List<Seat>> {
  final CloudProvider provider;
  SeatService(this.provider);

  factory SeatService.firebase() => SeatService(
        FirebaseCloudProvider(seatsCollection),
      );

  @override
  Future<Seat> create(Map<String, dynamic> map) async {
    return Seat.fromMap(await provider.create(map));
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
  Stream<List<Seat>> readCollection() {
    final snapshots = provider.readCollection() as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<Seat> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(Seat.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<Seat>> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots = provider.readCollectionByFilter(
        field: field, isEqualTo: isEqualTo) as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<Seat> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(Seat.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<Seat>> readCollectionByOrder(String field) {
    final snapshots =
        provider.readCollectionByOrder(field) as Stream<CollectionRef>;
    return snapshots.map((snapshot) {
      List<Seat> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(Seat.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<Seat> readDoc(String id) {
    final ref = provider.readDoc(id) as Stream<DocumentRef>;
    return ref.map((value) => Seat.fromMap(value));
  }

  @override
  Future<Seat> readDocFuture(String id) async {
    return Seat.fromMap(await provider.readDocFuture(id));
  }

  @override
  Future<bool> update(
      {required String id, required Map<String, dynamic> json}) {
    return provider.update(id: id, json: json);
  }
}
