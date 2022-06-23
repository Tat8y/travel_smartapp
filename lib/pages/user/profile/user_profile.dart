import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserModel? user;

  @override
  void initState() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    UserService.firebase().readDocFuture(uid).then((value) {
      setState(() {
        user = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          title: const Text("User Profile"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
          actions: [
            IconButton(
                onPressed: authService.logout, icon: const Icon(Icons.logout))
          ]),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform.translate(
            offset: const Offset(0.0, 100),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(kBorderRadius * 1.5),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Transform.translate(
              offset: const Offset(0.0, 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      foregroundImage:
                          CachedNetworkImageProvider(kDefaultAvatar),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: kPadding * .5),
                    child: Text(
                        "${user?.firstName ?? ""} ${user?.secondName ?? ""}",
                        style: const TextStyle(
                          fontSize: kFontSize * .9,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Text(user?.email ?? "Wating ...",
                      style: const TextStyle(
                        fontSize: kFontSize * .7,
                      )),
                  const SizedBox(height: kPadding),
                  CustomButton(
                    text: "Edit Profile",
                    onPressed: () {},
                    constraints: BoxConstraints(
                      minWidth:
                          MediaQuery.of(context).size.width - kPadding * 2,
                      minHeight: 50,
                    ),
                  ),
                  const SizedBox(height: kPadding * .5),
                  CustomButton(
                    text: "Points",
                    onPressed: () {},
                    constraints: BoxConstraints(
                      minWidth:
                          MediaQuery.of(context).size.width - kPadding * 2,
                      minHeight: 50,
                    ),
                  ),
                  const SizedBox(height: kPadding * .5),
                  CustomButton(
                    text: "Past Travels",
                    onPressed: () {},
                    constraints: BoxConstraints(
                      minWidth:
                          MediaQuery.of(context).size.width - kPadding * 2,
                      minHeight: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
