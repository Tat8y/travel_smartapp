import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';

class SuggestionApi {
  static Future<List<TrainStation>> trainSuggestion(String query) async {
    final stations = await StationService.firebase().readCollectionFuture();

    return stations.where((train) {
      final nameLower = train.name?.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower?.contains(queryLower) ?? false;
    }).toList();
  }
}
