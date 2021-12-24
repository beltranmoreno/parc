import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/customer_home.dart';
import 'package:parc/theme/custom_theme.dart';

class CarOnWay extends StatelessWidget {
  const CarOnWay({Key? key, required this.buildContext}) : super(key: key);

  final BuildContext buildContext;

  Widget actionButton({required Color fore, required Color back}) {
    return Container(
      width: MediaQuery.of(buildContext).size.width / 1.15,
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
            Navigator.push(
                buildContext,
                MaterialPageRoute(
                    builder: (context) => UserHome(
                          buildContext: context,
                        )));
          },
          child: Text(
            "return home",
            style: CustomTheme().mainFont,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your car is on the way.",
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Nunito",
                      color: Color(0xff294B56)),
                ),
              ],
            ),
            actionButton(fore: Color(0xffE8C0B5), back: Color(0xff294B56))
          ],
        ),
      ),
    );
  }
}
