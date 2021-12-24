import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/customer_home.dart';
import 'package:parc/data/car.dart';
import 'package:parc/theme/custom_theme.dart';

import 'firebase/firestore.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key, required this.buildContext}) : super(key: key);

  final BuildContext buildContext;
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final _formKey = GlobalKey<FormState>();
  final _carNameController = TextEditingController();
  final _licenseController = TextEditingController();
  final _modelController = TextEditingController();

  final Car car = Car(carName: "Hello", license: "123HKJ");

  Widget actionButton(
      {required String type,
      required Color fore,
      required Color back,
      required String previous}) {
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
            car.carName = _carNameController.text;
            car.license = _licenseController.text;
            car.model = _modelController.text;
            await FireStore(uid: FirebaseAuth.instance.currentUser!.uid)
                .addCar(car: car);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserHome(
                          buildContext: context,
                        )));
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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        foregroundColor: Color(0xff294B56),
        backgroundColor: Color(0xffF7F4E9),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Padding(padding: EdgeInsets.only(bottom: 40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add a car.",
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Nunito",
                    color: Color(0xff294B56)),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 40)),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _carNameController,
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Car Name"),
            validator: (value) {
              //email = value!;
              if (value == null || value.isEmpty) {
                return "Please enter a name for the car.";
              }

              return null;
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _licenseController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "License",
            ),
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Please enter license.";
              return null;
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _modelController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Model",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return "Please enter model.";
              return null;
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              actionButton(
                  type: 'add',
                  fore: Color(0xffE8C0B5),
                  back: Color(0xff294B56),
                  previous: 'profile')
            ],
          ),
        ],
      )),
    );
  }
}
