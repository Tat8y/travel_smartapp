import 'package:flutter/material.dart';
import 'package:travel_smartapp/main.dart';

class Splash extends StatefulWidget {
  const Splash ({ Key? key}):super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
@override
void initState() {
  super.initState();
  _navigatetohome();
}

_navigatetohome()async{
  await Future.delayed(const Duration(milliseconds: 1500), () {});
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'GFG',)));
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen', 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
        ),
        ),
      ),
    );
  }
}