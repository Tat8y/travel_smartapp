//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/login.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TravelSmart',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.orange,
    
      ),
        
          home:const LoginPage(title:'LoginPage',),
          
     );
  }
}

      
      // home: AnimatedSplashScreen(
      //   splash: 
      // Container(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Image.asset('assets/images/logo_lounchscr.png',
      //         width: 200,
      //         height: 150),
      //         // ignore: avoid_unnecessary_containers
      //   ],
      //  ),
      // ), 
      // // nextScreen: const LoginPage(title: 'Login Page',)
      // nextScreen: const LoginPage(title: 'Home Page',)
      // ),
   







// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key, required this.title}) : super(key: key);


//   final String title;

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {

//   Color primaryColor = const Color.fromARGB(246, 246, 246, 246);
//   // Color secondaryColor = Color(value);
//   // Color logo = Color(value);


//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     }
//     );
//   }

// //Login Page code
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),

//       ),
//       body: Center(
//         child: Column(
          
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Im here',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );

// //END of LoginPage code

//   }
// }
