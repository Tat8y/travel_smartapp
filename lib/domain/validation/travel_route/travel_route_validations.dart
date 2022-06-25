import 'package:travel_smartapp/domain/api/suggestion_api.dart';
import 'package:travel_smartapp/domain/validation/travel_route/travel_route_exceptions.dart';

class ValidateTravelRoute {
  // Creating Intance for ValidateTravelRoute
  static final ValidateTravelRoute instance = ValidateTravelRoute._();
  ValidateTravelRoute._();

  SuggestionApi suggestionApi = SuggestionApi.instance;

  Future<void> validateData({
    required String depature,
    required String destination,
  }) async {
    // Check Station is exists in Database
    bool depValidate = await SuggestionApi.trainSuggestion(depature).then(
      (value) => value.isNotEmpty,
    );

    // Check Station is exists in Database
    bool destValidate = await SuggestionApi.trainSuggestion(destination).then(
      (value) => value.isNotEmpty,
    );

    // Check Similar Stations
    bool checkSimilarData = depature != destination;

    // Throw Exception for each Validations
    if (!depValidate) throw TravelRouteNotFoundExceptions();
    if (!destValidate) throw TravelRouteNotFoundExceptions();
    if (!checkSimilarData) throw TravelRouteSimilarExceptions();
  }
}
