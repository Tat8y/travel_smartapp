import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_smartapp/app.dart';
import 'package:travel_smartapp/config/style/theme.dart';
import 'package:travel_smartapp/demo_data.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';
import 'package:travel_smartapp/domain/payment/payment_service.dart';
import 'package:travel_smartapp/domain/providers/prefernce_provider.dart';
import 'package:travel_smartapp/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PaymentService.init();

  await Firebase.initializeApp();

  // Create a SharedPreferences Instance
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Add Instance to MultiProvider
  runApp(MultiProvider(
      providers: [
        // Auth Service Provider
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),

        // Add Prefrence Provider
        ChangeNotifierProvider<PrefernceProvider>(
          create: (context) => PrefernceProvider(sharedPreferences),
        ),
      ],
      builder: (context, child) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // addTrainSchedules(
    //     delayBetweenTowStations: const Duration(minutes: 45),
    //     startDate: DateTime.now().add(const Duration(days: 1)));

    //addStations();
    //addTrains();
    // Getting PreferenceProvider from Build Context
    final provider = Provider.of<PrefernceProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TravelSmart',
      theme: provider.darkMode ? darkTheme : lightTheme,
      darkTheme: darkTheme,
      locale: provider.locale, // Set Locale from Shared Preference
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainApp(),
    );
  }
}
