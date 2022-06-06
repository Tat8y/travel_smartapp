
import 'package:flutter/material.dart';
import 'package:travel_smartapp/home.dart';
import 'package:travel_smartapp/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   //FORM KEY
   final _formKey = GlobalKey<FormState>();


   // EDITING CONTROLLER
   final TextEditingController emailController = new TextEditingController();
   final TextEditingController passwordController = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    //EMAIL FIELDS
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //VALIDATOR: () {},
      onSaved: (value)
      {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail, color: Colors.blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //PASSWORD FIELDS
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,

      //VALIDATOR: () {},
      onSaved: (value)
      {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.orange,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) =>
             const MyHomePage()));
          // Navigator.push(context, MaterialPageRoute(builder: (context) => 
          // const MyHomePage()));
        },
        child: const Text("Login", textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),
         )
        ),
      );


    return Scaffold(
    backgroundColor: const Color.fromARGB(246, 246, 246, 246),
    body: Center(
      child: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(246, 246, 246, 246),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                 SizedBox(
                   height: 200,
                   child: Image.asset("assets/images/login_logo.png",
                   fit: BoxFit.contain,
                 )),
                 const SizedBox(height: 20),
                 emailField,
                 const SizedBox(height: 30),
                 passwordField,
                 const SizedBox(height: 45),
                 loginButton,
                 const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  const Text("Don't have an account yet?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>
                       const RegistrationPage()));
                    },
                    child: const Text(
                      "  Sign up now",
                     style: TextStyle(
                       color: Colors.orange,
                       fontWeight: FontWeight.bold,
                       fontSize: 15
                       ),
                      )
                    ),
                ],
              )   
                ],
            ),
        ),
          ),
       ),
      ),
     ),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {

//       _counter++;
//     });
//   }

// //Login Page same code in splash.dart
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

// //END of LoginPage

//   }
// }
