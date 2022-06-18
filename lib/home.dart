
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: false,
    ),
     
     body: Padding(
       padding: const EdgeInsets.fromLTRB(90, 50, 80, 0),
       child: Container(
          child: Column (
           children: const [  
             Text (
             'Where do you want to go?',
             style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
            ),
            ),
           ],
          ),
       ),
     ),
     
    );
  }