
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //FORM KEY
  final _formKey = GlobalKey<FormState>();
 
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
      onSaved: (value)
      {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle, color: Colors.blue),
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

//VALIDATOR: () {},
      onSaved: (value)
      {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle, color: Colors.blue),
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
      onSaved: (value)
      {
        emailEditingController.text = value!;
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
      controller: passwordEditingController,
      obscureText: true,

//VALIDATOR: () {},
      onSaved: (value)
      {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.blue),
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

//VALIDATOR: () {},
      onSaved: (value)
      {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.orange,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "SignUp", 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),
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
                   height: 150,
                   child: Image.asset("assets/images/login_logo.png",
                   fit: BoxFit.contain,
                 )),
                 const SizedBox(height: 20),
                 firstNameField,
                 const SizedBox(height: 20),
                 secondNameField,
                 const SizedBox(height: 20),
                 emailField,
                 const SizedBox(height: 20),
                 passwordField,
                 const SizedBox(height: 20),
                 confirmPasswordField,
                 const SizedBox(height: 20),
                 signUpButton,
                 const SizedBox(height: 15),

                 
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
