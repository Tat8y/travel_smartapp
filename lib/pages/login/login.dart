import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/domain/authentication/auth_service.dart';
import 'package:travel_smartapp/extension/context/localization.dart';
import 'package:travel_smartapp/pages/root/root.dart';
import 'package:travel_smartapp/pages/register/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//FORM KEY
  final _formKey = GlobalKey<FormState>();

  // EDITING CONTROLLER
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //EMAIL FIELDS
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return (context.loc
              ?.please_enter_valid_feild(context.loc!.email_label));
        }
        //Reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return (context.loc
              ?.please_enter_valid_feild(context.loc!.email_label));
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon:
            const Icon(Icons.mail, color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        hintText: context.loc!.email_label,
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
        if (value!.isEmpty) {
          return (context.loc
              ?.feild_requried(context.loc!.password, context.loc!.login));
        }
        if (!regex.hasMatch(value)) {
          return (context.loc?.please_enter_valid_feild(context.loc!.password));
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
        prefixIcon: const Icon(Icons.vpn_key,
            color: Color.fromARGB(255, 155, 157, 158)),
        contentPadding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        hintText: context.loc!.password,
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
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            context.loc!.login,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
          )),
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
                      children: <Widget>[
                        Text(context.loc!.dont_have_an_account),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationPage()));
                            },
                            child: Text(
                              context.loc!.sign_up,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )),
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
    final authService = Provider.of<AuthService>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      await authService
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: context.loc!.login_successful),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const RootPage()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
