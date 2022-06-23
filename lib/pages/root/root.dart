import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/pages/home/home.dart';
import 'package:travel_smartapp/pages/location/location_controller.dart';
import 'package:travel_smartapp/pages/location/train_location.dart';
import 'package:travel_smartapp/pages/user/profile/user_profile.dart';
import 'package:travel_smartapp/home/from_data.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final controllerCity = TextEditingController();

  int currentIndex = 2;
  final screens = [
    HomePage(),
    const MapScreen(),
    const UserProfilePage(),
  ];

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    UserService.firebase()
        .readDocFuture(user!.uid)
        .then((value) => loggedInUser = value);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return Scaffold(
// BOTTOM NAVIGATION BAR
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 228, 227, 227),
        iconSize: 28,
        // showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_location),
              label: 'Location',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'User Profile',
              backgroundColor: Colors.orange),
        ],
      ),
    );
  }

  Widget buildCity() => TypeAheadFormField<String?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controllerCity,
          decoration: const InputDecoration(
            labelText: 'From',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: FromData.getSuggestions,
        itemBuilder: (context, String? suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (String? suggestion) =>
            controllerCity.text = suggestion!,
      );
}
