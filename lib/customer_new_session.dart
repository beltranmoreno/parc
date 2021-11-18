import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewSessionPage extends StatefulWidget {
  const NewSessionPage({Key? key, required this.buildContext})
      : super(key: key);

  final BuildContext buildContext;

  // UserSession userSession = UserSession(name: name, sessionID: sessionID)

  @override
  _NewSessionPageState createState() => _NewSessionPageState();
}

class _NewSessionPageState extends State<NewSessionPage> {
  Widget checkOutButton() {
    return Container(
      height: 64,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff294B56)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              //side: BorderSide(color: Colors.red)
            ))),
        child: Text(
          "begin",
          style: TextStyle(
            color: Color(0xffE8C0B5),
            fontSize: 24,
          ),
        ),
        onPressed: () {
          /*showiOSMessageAlert(
              title: "Proceed to checkout?",
              message: "Tap confirm to proceed.",
              cancel: "Cancel",
              action: "Confirm");*/
        },
      ),
    );
  }

  Widget popUpMessage() {
    return AlertDialog(
      title: Text("Where to find location number?"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffF7F4E9),
        foregroundColor: Color(0xff294B56),
        elevation: 0.0,
        title: Text("New Session"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Done",
              style: TextStyle(color: Color(0xff294B56), fontSize: 16),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(20),
        child: ListView(children: [
          ListTile(
            title: Text("Enter location number:"),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 5,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Location",
                suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => popUpMessage());
                    },
                    icon: Icon(CupertinoIcons.info))),
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Please enter only numbers.";
              return null;
            },
          ),
          ListTile(
            title: Text("Choose a car:"),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          checkOutButton(),
        ]),
      )),
    );
  }
}
