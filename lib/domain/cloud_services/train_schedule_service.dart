import 'package:travel_smartapp/domain/cloud/cloud_constatnts.dart';
import 'package:travel_smartapp/domain/cloud/cloud_provider.dart';
import 'package:travel_smartapp/domain/cloud/firebase_service.dart';
import 'package:travel_smartapp/domain/models/train_schedule_model.dart';

class TrainScheduleService
    implements CloudProvider<TrainSchedule, List<TrainSchedule>> {
  final CloudProvider provider;
  TrainScheduleService(this.provider);

  factory TrainScheduleService.firebase() => TrainScheduleService(
        FirebaseCloudProvider(trainScheduleCollection),
      );

  @override
  Future<TrainSchedule> create(Map<String, dynamic> map) async {
    return TrainSchedule.fromMap(await provider.create(map));
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
  Stream<List<TrainSchedule>> readCollection() {
    final snapshots = provider.readCollection() as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<TrainSchedule> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainSchedule.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<TrainSchedule>> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots = provider.readCollectionByFilter(
        field: field, isEqualTo: isEqualTo) as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<TrainSchedule> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainSchedule.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<TrainSchedule>> readCollectionByOrder(String field) {
    final snapshots =
        provider.readCollectionByOrder(field) as Stream<CollectionRef>;
    return snapshots.map((snapshot) {
      List<TrainSchedule> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(TrainSchedule.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<TrainSchedule> readDoc(String id) {
    final ref = provider.readDoc(id) as Stream<DocumentRef>;
    return ref.map((value) => TrainSchedule.fromMap(value));
  }

  @override
  Future<TrainSchedule> readDocFuture(String id) async {
    return TrainSchedule.fromMap(await provider.readDocFuture(id));
  }

  @override
  Future<bool> update(
      {required String id, required Map<String, dynamic> json}) {
    return provider.update(id: id, json: json);
  }
}
