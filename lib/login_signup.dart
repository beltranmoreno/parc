import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/firebase/fire_auth.dart';
import 'package:parc/signup_page.dart';
import 'package:parc/theme/custom_theme.dart';

import 'customer_home.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _passwordVisible = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserHome(
            buildContext: context,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  Widget actionButton(
      {required String type, required Color fore, required Color back}) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.15,
      child: ElevatedButton(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (states) => TextStyle(fontSize: 24, fontFamily: 'Montserrat')),
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (states) => EdgeInsets.all(20)),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => fore), // Color(0xffE8C0B5)
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => back), // Color(0xff294B56)
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20));
            }),
          ),
          onPressed: () async {
            if (type == 'sign up') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpPage(
                            buildContext: context,
                          )));
            } else if (type == 'log in') {
              User? user = await FireAuth.signInUsingEmailPassword(
                  email: _emailController.text, password: _passController.text);
              if (user != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserHome(
                              buildContext: context,
                            )));
              }
            }
          },
          child: Text(
            type,
            style: CustomTheme().mainFont,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "parc",
                          style: TextStyle(
                              fontSize: 64,
                              fontFamily: "Nunito",
                              color: Color(0xff294B56)),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Valet made easy.",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Nunito",
                              color: Color(0xff294B56)),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 70)),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Email"),
                      validator: (value) {
                        //email = value!;
                        if (value == null || value.isEmpty) {
                          return "Please enter email.";
                        }
                        if (!EmailValidator.validate(_emailController.text)) {
                          return "Please enter email correctly.";
                        }

                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              })),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Please enter password.";
                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 50)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        actionButton(
                            type: 'log in',
                            fore: Color(0xffE8C0B5),
                            back: Color(0xff294B56))
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 70)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Nunito",
                              color: Color(0xff294B56)),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        actionButton(
                            type: 'sign up',
                            fore: Color(0xff294B56),
                            back: Color(0xffE8C0B5))
                      ],
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
