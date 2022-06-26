import 'package:travel_smartapp/domain/cloud/cloud_constatnts.dart';
import 'package:travel_smartapp/domain/cloud/cloud_provider.dart';
import 'package:travel_smartapp/domain/cloud/firebase_service.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';

class StationService
    implements CloudProvider<TrainStation, List<TrainStation>> {
  final FirebaseCloudProvider provider;
  StationService(this.provider);

  factory StationService.firebase() => StationService(
        FirebaseCloudProvider(stationsCollection),
      );

  @override
  Future<TrainStation> create(Map<String, dynamic> map) async {
    return TrainStation.fromMap(await provider.create(map));
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
  Stream<List<TrainStation>> readCollection() {
    final snapshots = provider.readCollection();

    return snapshots.map((snapshot) {
      List<TrainStation> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainStation.fromMap(element));
      }

      return retVal;
    });
  }

  Future<List<TrainStation>> readCollectionFuture() {
    final snapshots = provider.readCollectionFuture();

    return snapshots.then((snapshot) {
      List<TrainStation> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainStation.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<TrainStation>> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots =
        provider.readCollectionByFilter(field: field, isEqualTo: isEqualTo);

    return snapshots.map((snapshot) {
      List<TrainStation> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainStation.fromMap(element));
      }

      return retVal;
    });
  }

  Future<List<TrainStation>> readCollectionByFilterFuture({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots = provider.readCollectionByFilterFuture(
        field: field, isEqualTo: isEqualTo);

    return snapshots.then((snapshot) {
      List<TrainStation> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainStation.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<TrainStation>> readCollectionByOrder(String field) {
    final snapshots = provider.readCollectionByOrder(field);
    return snapshots.map((snapshot) {
      List<TrainStation> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainStation.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<TrainStation> readDoc(String id) {
    final ref = provider.readDoc(id);
    return ref.map((value) => TrainStation.fromMap(value));
  }

  @override
  Future<TrainStation> readDocFuture(String id) async {
    return TrainStation.fromMap(await provider.readDocFuture(id));
  }

  @override
  Future<bool> update(
      {required String id, required Map<String, dynamic> json}) {
    return provider.update(id: id, json: json);
  }
}
