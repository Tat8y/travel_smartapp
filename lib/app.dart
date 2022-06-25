import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';
import 'package:travel_smartapp/domain/providers/prefernce_provider.dart';
import 'package:travel_smartapp/pages/languages/select_language.dart';
import 'package:travel_smartapp/pages/login/login.dart';
import 'package:travel_smartapp/pages/root/root.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get AuthService Provider from Build Context
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.authStateChange,
      builder: (context, snapshot) {
        // Check App is Running First Time
        if (context.read<PrefernceProvider>().firstTime) {
          return const LanguageSelectPage();
        }

        if (snapshot.connectionState == ConnectionState.active) {
          // Get Current Firebase User? from Snapshot
          final User? user = snapshot.data;

          // If User is Not Empty navigate to RootPage and User is Empty Navigate to LoginPage
          return user != null ? const RootPage() : const LoginPage();
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
