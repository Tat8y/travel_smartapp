import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: customAppBar(title: "User Profile", actions: [
        IconButton(
            onPressed: authService.logout, icon: const Icon(Icons.logout))
      ]),
    );
  }
}
