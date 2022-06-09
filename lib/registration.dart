
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_smartapp/home.dart';
import 'package:travel_smartapp/models/user_model.dart';

// import 'package:travel_smartapp/main.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //FORM KEY
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  
  //EDITING CONTROLLER
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

//FIRST NAME FIELDS
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
//VALIDATOR: () {},
      validator: (value) {
              RegExp regex = RegExp(r'^.{3,}$');
              if (value!.isEmpty)
              {
                return ("First Name cannot be empty");
              }
              if (!regex.hasMatch(value))
              {
                return ("Please Enter Valid name(Min. 8 Characters");
              }
              return null;
      },
      onSaved: (value)
      {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.account_circle, color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          
        ),
      ),
    );


//SECOND NAME FIELDS
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty)
        {
          return ("Second Name cannot be empty");
        }
        return null;
        
},
      onSaved: (value)
      {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.account_circle, color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


//EMAIL FIELDS
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.name,
//VALIDATOR: () {},
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
      onSaved: (value)
      {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.mail, color: Color.fromARGB(255, 155, 157, 158)),
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
      controller: passwordEditingController,
      obscureText: true,
//VALIDATOR: () {},
      validator: (value) {
              RegExp regex = RegExp(r'^.{8,}$');
              if (value!.isEmpty)
              {
                return ("Password is required for login");
              }
              if (!regex.hasMatch(value))
              {
                return ("Please Enter Valid password(Min. 8 Characters)");
              }
              return null;
      },
      onSaved: (value)
      {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.vpn_key, color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


// CONFORM PASSWORD FIELDS
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if(passwordEditingController.text.length > 8 && passwordEditingController.text != value) {
          return "Password don't match";
        }
        return null;
      },

      onSaved: (value)
      {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.vpn_key, color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

//signup button
final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.orange,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 180.0,
        height: 50.0,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);

        },
        child: const Text(
          "Sign up", 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,color: Colors.black, fontWeight: FontWeight.bold),
         )
        ),
      );



   return Scaffold(
    backgroundColor: const Color.fromARGB(246, 246, 246, 246),
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.orange),
        onPressed: () {
        // PASSING THIS TO ROOT
          Navigator.of(context).pop();
       },
      ),
    ),
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
                 const SizedBox(height: 0),
                 firstNameField,
                 const SizedBox(height: 15),
                 secondNameField,
                 const SizedBox(height: 15),
                 emailField,
                 const SizedBox(height: 15),
                 passwordField,
                 const SizedBox(height: 15),
                 confirmPasswordField,
                 const SizedBox(height: 30),
                 signUpButton,
                 const SizedBox(height: 100),

                 
           ],
          ),
         ),
        ),
       ),
      ),
     ),
    );
  }


  void signUp(String email, String password) async {
    if(_formKey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore()
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }


  postDetailsToFirestore() async {
    // calling firestore
    // calling user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // VALUES
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;


    await firebaseFirestore
     .collection("users")
     .doc(user.uid)
     .set(userModel.toMap());
     Fluttertoast.showToast(msg: "Your account has been created successfully!" );


     Navigator.pushAndRemoveUntil (
     (context),
     MaterialPageRoute(builder: (context) => const MyHomePage()),
     (route) => false);
  }
}
