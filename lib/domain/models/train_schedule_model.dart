import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';

class TrainSchedule {
  static const String trainFeild = 'train_id';
  static const String startStationFeild = 'start_station_id';
  static const String endStationFeild = 'end_station_id';
  // static const String arrivalTimeFeild = 'arrival_time';
  static const String stopsFeild = 'stops';

  String? id;
  final String train;
  final String startStation;
  final String endStation;
  final Map<int, TrainScheduleStops> stops;
  // final DateTime arrivalTime;

  TrainSchedule({
    this.id,
    required this.train,
    required this.startStation,
    required this.endStation,
    // required this.arrivalTime,
    required this.stops,
  });

  static TrainSchedule fromMap(DocumentSnapshot doc) => TrainSchedule(
        id: doc.id,
        train: doc[trainFeild] as String,
        startStation: doc[startStationFeild] as String,
        endStation: doc[endStationFeild] as String,
        // arrivalTime: DateTime.fromMillisecondsSinceEpoch(doc[arrivalTimeFeild]),
        stops: TrainScheduleStops.stopsFromMap(doc[stopsFeild]),
      );

  Map<String, dynamic> toMap() => {
        trainFeild: train,
        startStationFeild: startStation,
        endStationFeild: endStation,
        // arrivalTimeFeild: arrivalTime.millisecondsSinceEpoch,
        stopsFeild:
            stops.map((key, value) => MapEntry(key.toString(), value.toMap())),
      };

  // get the key of station in stops list
  int getStopsKey(String? stationId) {
    return stops.keys
        .firstWhere((k) => stops[k]?.station == stationId, orElse: () => -1);
  }

  // get length by full length for calculate ticket price
  double calculateLengthRatio(TravelRoute route) {
    int fromStationKey = getStopsKey(route.from);
    int toStationKey = getStopsKey(route.to);
    if (stops.entries.isNotEmpty &&
        fromStationKey != -1 &&
        toStationKey != -1) {
      double from = stops[fromStationKey]?.distanceFromStart ?? 0;
      double to = stops[toStationKey]?.distanceFromStart ?? 0;
      double full = stops.entries.last.value.distanceFromStart;
      return (to - from) / full;
    }
    return 0.0;
  }

  TrainScheduleStops getStopByStation(String? station) {
    int stationKey = getStopsKey(station);
    if (stationKey != -1) {
      return stops.entries.elementAt(stationKey).value;
    }
    return stops.entries.first.value;
  }
}

class TrainScheduleStops {
  static const String depatureFeild = 'depature';
  static const String arrivalTimeFeild = 'arrival_time';
  static const String distanceFromStartFeild = 'distance_from_start';
  static const String stationFeild = 'stations';
  static const String stopTimesFeild = 'stopTimes';

  final DateTime depature;
  final DateTime arrivalTime;
  final double distanceFromStart;
  final String station;
  final int stopTimes;

  const TrainScheduleStops({
    required this.depature,
    required this.arrivalTime,
    required this.distanceFromStart,
    required this.station,
    required this.stopTimes,
  });

  factory TrainScheduleStops.fromMap(Map<String, dynamic> map) =>
      TrainScheduleStops(
        depature: DateTime.fromMillisecondsSinceEpoch(map[depatureFeild]),
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(map[arrivalTimeFeild]),
        distanceFromStart: map[distanceFromStartFeild] as double,
        station: map[stationFeild] as String,
        stopTimes: map[stopTimesFeild] as int,
      );

  Map<String, dynamic> toMap() => {
        depatureFeild: depature.millisecondsSinceEpoch,
        arrivalTimeFeild: arrivalTime.millisecondsSinceEpoch,
        distanceFromStartFeild: distanceFromStart,
        stationFeild: station,
        stopTimesFeild: stopTimes,
      };

  // Sort Map by Key
  static Map<int, TrainScheduleStops> stopsFromMap(
      Map<dynamic, dynamic> stopData) {
    Map<int, TrainScheduleStops> retVal = stopData.map<int, TrainScheduleStops>(
        (key, value) =>
            MapEntry(int.parse(key), TrainScheduleStops.fromMap(value)));

    var sortedKeys = retVal.keys.toList(growable: false)
      ..sort((k1, k2) => k1.compareTo(k2));
    LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => retVal[k]);

    return sortedMap.map((key, value) => MapEntry(key, value));
  }
}
