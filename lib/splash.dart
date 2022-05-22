import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({ Key? key }) : super(key: key);


@override
void initState() {
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Container(
        child: const Text('Splash Page', style: TextStyle(
          fontSize: 24, 
          fontWeight: FontWeight.bold
          ),),
      

       )
      ), 
    );
  }
}