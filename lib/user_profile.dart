

import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: false,
      ),
    );
  }