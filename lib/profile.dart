import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:travel_smartapp/home.dart';
import 'package:travel_smartapp/location/location_controller.dart';
import 'package:travel_smartapp/models/user_model.dart';
import 'package:travel_smartapp/login.dart';
import 'package:travel_smartapp/location/train_location.dart';
import 'package:travel_smartapp/user_profile.dart';
import 'package:travel_smartapp/home/from_data.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key,}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  final controllerCity = TextEditingController();

  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const MapScreen(),
    const UserProfilePage(),
  ];

 User? user = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();

@override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
    .collection("users")
    .doc(user!.uid)
    .get()
    .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Welcome Screen"),
      //   centerTitle: false,
      // ),


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
            backgroundColor: Colors.orange
      ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location),
            label: 'Location',
            backgroundColor: Colors.orange
      ),
      BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Profile',
            backgroundColor: Colors.orange
      ),
    ],
  ),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget> [
      //         SizedBox(
      //           height: 150,
      //           child: Image.asset(
      //             "assets/images/login_logo.png", 
      //             fit: BoxFit.contain),
      //         ),
      //         const Text (
      //           "Welcome",
      //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //         const SizedBox(
      //           height: 10,),
      //           Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
      //           style: const TextStyle(
      //             color: Colors.black, 
      //             fontWeight: FontWeight.normal)),
      //         const SizedBox(
      //           height: 15,
      //         ),
      //         ActionChip(label: const Text("Logout"), onPressed: () {
      //           logout(context);
      
      //         }),   
      //       ],
      //     ),
      //     ),
      //   ),


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



  // Widget buildSubmit(BuildContext context) => ButtonWidget(
  //      text: 'Submit',
  //      onClicked: ()  {},
  // );
  }

  Future <void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()));


  }

  

