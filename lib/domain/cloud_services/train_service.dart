import 'package:travel_smartapp/domain/cloud/cloud_constatnts.dart';
import 'package:travel_smartapp/domain/cloud/cloud_provider.dart';
import 'package:travel_smartapp/domain/cloud/firebase_service.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';

class TrainService implements CloudProvider<Train, List<Train>> {
  final CloudProvider provider;
  TrainService(this.provider);

  factory TrainService.firebase() => TrainService(
        FirebaseCloudProvider(trainsCollection),
      );

  @override
  Future<Train> create(Map<String, dynamic> map) async {
    return Train.fromMap(await provider.create(map));
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
  Stream<List<Train>> readCollection() {
    final snapshots = provider.readCollection() as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<Train> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(Train.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<Train>> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots = provider.readCollectionByFilter(
        field: field, isEqualTo: isEqualTo) as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<Train> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(Train.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<Train>> readCollectionByOrder(String field) {
    final snapshots =
        provider.readCollectionByOrder(field) as Stream<CollectionRef>;
    return snapshots.map((snapshot) {
      List<Train> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(Train.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<Train> readDoc(String id) {
    final ref = provider.readDoc(id) as Stream<DocumentRef>;
    return ref.map((value) => Train.fromMap(value));
  }

  @override
  Future<Train> readDocFuture(String id) async {
    return Train.fromMap(await provider.readDocFuture(id));
  }

  @override
  Future<bool> update(
      {required String id, required Map<String, dynamic> json}) {
    return provider.update(id: id, json: json);
  }
}
