import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud/cloud_constatnts.dart';
import 'package:travel_smartapp/domain/cloud/firebase_service.dart';
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
    updateUser(user).then((value) => loggedInUser = value);
  }

  Future<UserModel> updateUser(User? user) async {
    return await FirebaseCloudProvider(usersCollection)
        .readDocFuture(user!.uid)
        .then((value) async {
      if (!value.exists) {
        UserModel _user = UserModel(
            uid: user.uid,
            email: user.email,
            firstName: user.displayName,
            secondName: '',
            bookings: []);
        await UserService.firebase().createWithId(
          id: user.uid,
          map: _user.toMap(),
        );
        return _user;
      } else {
        return await UserService.firebase().readDocFuture(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BOTTOM NAVIGATION BAR
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.themes.bottomAppBarColor,
        iconSize: 24,
        // showSelectedLabels: false,
        fixedColor: kSecondaryColor,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.home),
            label: context.loc?.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.tickets),
            label: context.loc?.tickets,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.person_alt_circle),
            label: context.loc?.account,
          ),
        ],
      ),
    );
  }
}
