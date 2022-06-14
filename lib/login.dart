
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_smartapp/profile.dart';
import 'package:travel_smartapp/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

//FORM KEY
   final _formKey = GlobalKey<FormState>();


// EDITING CONTROLLER
   final TextEditingController emailController = new TextEditingController();
   final TextEditingController passwordController = new TextEditingController();


//FIREBASE
final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
//EMAIL FIELDS
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        //Reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      //VALIDATOR: () {},
      onSaved: (value)
      {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.mail, color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
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
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty)
        {
          return ("Please enter password to login");
        }
        if (!regex.hasMatch(value))
        {
          return ("Please Enter Valid Password(Min. 8 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.vpn_key, color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


//LOGIN BUTTON
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.orange,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 180.0,
        height: 50.0,
     //   minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
          // Navigator.pushReplacement(
          //   context,MaterialPageRoute(builder: (context) =>
          //    const ProfilePage()));

        },
        child: const Text(
         "Login",
         textAlign: TextAlign.center,
         style: TextStyle(
          fontSize: 17,color: Colors.black, fontWeight: FontWeight.bold),
         )
        ),
      );

    return Scaffold(
    backgroundColor: const Color.fromARGB(246, 246, 246, 246),
    body: Center(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                 SizedBox(
                   height: 125,
                   child: Image.asset(
                     "assets/images/login_logo.png",
                   fit: BoxFit.contain,
                 )),
                 const SizedBox(height: 30),
                 emailField,
                 const SizedBox(height: 25),
                 passwordField,
                 const SizedBox(height: 45),
                 loginButton,
                 const SizedBox(height: 15),
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
                       fontSize: 14
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

// login function
    void signIn(String email, String password) async {
      if(_formKey.currentState!.validate()){
        await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
            Fluttertoast.showToast(msg: "Login Successful"),
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfilePage()))
        
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
  }
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
