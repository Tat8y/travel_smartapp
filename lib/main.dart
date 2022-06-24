//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/app.dart';
import 'package:travel_smartapp/config/style/theme.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (context) => AuthService()),
        //Provider<BookingNotifire>(create: (context) => BookingNotifire())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TravelSmart',
        theme: lightTheme,
        home: const MainApp(),
      ),
    );
  }
}
