// import 'package:flutter/material.dart';
// import 'package:travel_smartapp/main.dart';

// import 'login.dart';

// class Splash extends StatefulWidget {
//   const Splash ({ Key? key}):super(key: key);

//   @override
//   State <Splash> createState() => _SplashState();
// }

// class _SplashState extends State <Splash> {
// @override
// void initState() {
//   super.initState();
//   _navigatetohome();
// }

// _navigatetohome()async{
//   await Future.delayed(const Duration(milliseconds: 4000), () {});
//   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(title: 'Login Page',)));
// }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/logo_lounchscr.png',
//               width: 200,
//               height: 150),
              
//               // ignore: avoid_unnecessary_containers
           
//         ],
//        ),
//       ),
//     );
//   }
// }