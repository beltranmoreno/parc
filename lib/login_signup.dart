import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/customer_sessions_page.dart';
import 'package:parc/signup_page.dart';
import 'package:parc/theme/custom_theme.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CustomerSessionPage(
            context: context,
          ),
        ),
      );
    }
    return firebaseApp;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              textStyle:
                                  MaterialStateProperty.resolveWith<TextStyle>(
                                      (states) => TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Montserrat')),
                              padding: MaterialStateProperty.resolveWith<
                                      EdgeInsetsGeometry>(
                                  (states) => EdgeInsets.all(20)),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) => Color(0xffE8C0B5)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) => Color(0xff294B56)),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>((_) {
                                return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20));
                              }),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage(
                                            buildContext: context,
                                          )));
                            },
                            child: Text(
                              "sign up",
                              style: CustomTheme().mainFont,
                            )),
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
