import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/extension/context/localization.dart';
import 'package:travel_smartapp/extension/context/themes.dart';
import 'package:travel_smartapp/pages/home/home.dart';
import 'package:travel_smartapp/pages/tickets/tickets.dart';
import 'package:travel_smartapp/pages/user/profile/user_profile.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final controllerCity = TextEditingController();

  int currentIndex = 0;
  final screens = [
    const HomePage(),
    TicketsPage(),
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
    return Scaffold(
      // BOTTOM NAVIGATION BAR
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.themes.bottomAppBarColor,
        iconSize: 28,
        // showSelectedLabels: false,
        fixedColor: kSecondaryColor,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: context.loc?.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.ticket),
            label: context.loc?.tickets,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outlined),
            label: context.loc?.account,
          ),
        ],
      ),
    );
  }
}
