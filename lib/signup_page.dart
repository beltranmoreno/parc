import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parc/customer_sessions_page.dart';
import 'package:parc/theme/custom_theme.dart';

import 'firebase/fire_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.buildContext}) : super(key: key);

  final BuildContext buildContext;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _chosenType = "Customer";
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  late String email;
  late bool isValid = EmailValidator.validate(email);
  bool _passwordVisible = false;
  bool _lights = false;

  //   Color(0xff66867B) - semi dark
  //   Color(0xff294B56) - dark
  //   Color(0xffE8C0B5) - pink

  Widget tabSelect({required String option1, required String option2}) {
    return TabBar(tabs: [Text(option1), Text(option2)]);
  }

  Widget dropDownChoice() {
    return Container(
      alignment: Alignment.centerLeft,
      //margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Color(0xffE8C0B5)),
      child: DropdownButton<String>(
        value: _chosenType,
        icon: const Icon(CupertinoIcons.chevron_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Color(0xff294B56)),
        /*underline: Container(
                height: 2,
                color: Color(0xff294B56),
              ),*/
        onChanged: (String? newValue) {
          setState(() {
            _chosenType = newValue!;
          });
        },
        items: <String>['Customer', 'Valet']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  formField(TextEditingController controller, {required String type}) {
    if (type == "Password") {
      TextFormField(
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Password",
            suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                })),
        validator: (value) {
          if (value == null || value.isEmpty) return "Please enter text.";
          if (value.length < 8) return "Password too short.";
          return null;
        },
      );
    } else {
      return TextFormField(
        controller: controller,
        decoration:
            InputDecoration(border: OutlineInputBorder(), hintText: type),
        validator: (value) {
          //email = value!;
          if (value == null || value.isEmpty) return "Please enter email.";
          if (!EmailValidator.validate(emailController.text)) {
            return "Please enter email correctly.";
          }
          return null;
        },
      );
    }
  }

  bool passwordMatch({required String pass1, required String pass2}) {
    if (pass1 == pass2) {
      return true;
    } else {
      return false;
    }
  }

  Widget signUpForm() {
    return Container(
      //margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: firstNameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "First Name"),
              validator: (value) {
                if (value == null || value.isEmpty) return "Please enter text.";
                return null;
              },
            ),
            Padding(padding: EdgeInsets.all(12)),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: lastNameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Last Name"),
              validator: (value) {
                if (value == null || value.isEmpty) return "Please enter text.";
                return null;
              },
            ),
            Padding(padding: EdgeInsets.all(12)),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Email"),
              validator: (value) {
                //email = value!;
                if (value == null || value.isEmpty) {
                  return "Please enter email.";
                }
                if (!EmailValidator.validate(emailController.text)) {
                  return "Please enter email correctly.";
                }
                return null;
              },
            ),
            Padding(padding: EdgeInsets.all(12)),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Phone Number"),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please enter only numbers.";
                return null;
              },
            ),
            Padding(padding: EdgeInsets.all(12)),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: pass1Controller,
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
                if (value == null || value.isEmpty) return "Please enter text.";
                if (value.length < 8) return "Password too short.";
                return null;
              },
            ),
            Padding(padding: EdgeInsets.all(12)),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: pass2Controller,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Confirm Password",
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
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Enter password again.";
                }
                if (passwordMatch(
                        pass1: pass1Controller.text,
                        pass2: pass2Controller.text) ==
                    false) {
                  return "Passwords have to match";
                }
                return null;
              },
            ),
            //dropDownChoice(),
            ListTile(
              title: Text("Valet?"),
              trailing: CupertinoSwitch(
                  value: _lights,
                  onChanged: (value) {
                    setState(() {
                      _lights = !_lights;
                    });
                  }),
              onTap: () {
                setState(() {
                  _lights = !_lights;
                });
              },
            ), //tabSelect(option1: "Customer", option2: "Valet")
          ],
        ),
      ),
    );
  }

  partnerKey() {
    return Container();
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    pass1Controller.dispose();
    pass2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Color(0xff294B56),
        backgroundColor: Color(0xffF7F4E9),
      ),
      backgroundColor: Color(0xffF7F4E9),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    //decoration: BoxDecoration(color: Color(0xff66867B)),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Welcome.",
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: "Nunito",
                          color: Color(0xff294B56)),
                    )),
              ],
            ),
            signUpForm(),
            ElevatedButton(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                      (states) =>
                          TextStyle(fontSize: 24, fontFamily: 'Montserrat')),
                  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                          (states) => EdgeInsets.all(20)),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Color(0xffE8C0B5)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Color(0xff294B56)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                    return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20));
                  }),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    User? user = await FireAuth.registerUsingEmailPassword(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      password: pass2Controller.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Processing")));
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerSessionPage(
                                    context: context,
                                  )));
                    }
                  }
                },
                child: Text(
                  "sign up",
                  style: CustomTheme().mainFont,
                )),
          ],
        ),
      ),
    );
  }
}

/*String _validatePassword(String pass1) {
    // 1
    RegExp hasUpper = RegExp(r'[A-Z]');
    RegExp hasLower = RegExp(r'[a-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasPunct = RegExp(r'[!@#\$&*~-]');
    // 2
    if (!RegExp(r'.{8,}').hasMatch(pass1))
      return 'Passwords must have at least 8 characters';
    // 3
    if (!hasUpper.hasMatch(pass1))
      return 'Passwords must have at least one uppercase character';
    // 4
    if (!hasLower.hasMatch(pass1))
      return 'Passwords must have at least one lowercase character';
    // 5
    if (!hasDigit.hasMatch(pass1))
      return 'Passwords must have at least one number';
    // 6
    if (!hasPunct.hasMatch(pass1))
      return 'Passwords need at least one special character like !@#\$&*~-';
    // 7
    return null;
  }*/
