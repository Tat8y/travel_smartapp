// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// // ignore: implementation_imports
// import 'package:google_maps_webservice/src/places.dart' show Prediction;
// import 'package:travel_smartapp/pages/location/location_service.dart';

// //         // import 'package:travel_smartapp/location_search.dart';
// //         // import 'package:google_maps_flutter/google_maps_flutter.dart';
// //         // import 'package:travel_smartapp/train_location.dart';
// //         // import 'package:geolocator/geolocator.dart';
// //         // import 'dart:io';

// class LocationController extends GetxController {
//   final Placemark _pickPlaceMark = Placemark();
//   Placemark get pickPlaceMark => _pickPlaceMark;

//   List<Prediction> _predictionList = [];

//   Future<List<Prediction>> searchLocation(
//       BuildContext context, String text) async {
//     if (text.isNotEmpty) {
//       http.Response response = await getLocationData(text);
//       var data = jsonDecode(response.body.toString());
//       print("my status is " + data["status"]);
//       if (data['status'] == 'OK') {
//         _predictionList = [];
//         data['predictions'].forEach((prediction) =>
//             _predictionList.add(Prediction.fromJson(prediction)));
//       } else {
//         // ApiChecker.checkApi(response);
//       }
//     }
//     return _predictionList;
//   }

//   void setMapController(GoogleMapController mapController) {}

// // class TrainLocationPage extends StatelessWidget {
// //   const TrainLocationPage({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(
// //         title: const Text("Train Location"),
// //         centerTitle: false,
// //       ),
// //     );
// //   }
// }
