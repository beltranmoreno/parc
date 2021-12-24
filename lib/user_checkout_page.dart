import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/car_on_way.dart';

class UserCheckoutPage extends StatefulWidget {
  UserCheckoutPage({Key? key, required this.sessionID}) : super(key: key);

  final String sessionID;
  @override
  _UserCheckoutPageState createState() => _UserCheckoutPageState();
}

class _UserCheckoutPageState extends State<UserCheckoutPage> {
  double tip = 0;
  double rate1 = 0;
  double rate2 = 0;
  double taxFees = 0;
  double total = 0;

  void incrementTip() {
    setState(() {
      tip = tip + 0.50;
    });
  }

  void decrementTip() {
    if (tip <= 0) {
      setState(() {
        tip == 0.0;
      });
    } else {
      setState(() {
        tip = tip - 0.50;
      });
    }
  }

  Widget sessionTime({required String sessionTime}) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xff66867B),
      ),
      alignment: Alignment.center,
      child: Text(
        sessionTime,
        style: TextStyle(fontSize: 48, color: Color(0xffE8C0B5)),
      ),
    );
  }

  Widget receiptContainer({required String receiptID}) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text("Receipt #$receiptID"),
    );
  }

  Widget orderSummaryContainer({required String rate1, required String rate2}) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),
                Text("Rate")
              ],
            ),
            Row(
              children: [
                Text("Time"),
                Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),
                Text("Price"),
                Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),
              ],
            )
          ]),
          Padding(padding: EdgeInsets.all(5)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ratesList(),
            ],
          )
        ],
      ),
    );
  }

  Widget individualRate(
      {required String rateDescription,
      required String time,
      required String price}) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rateDescription),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(time),
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),
              Text(price)
            ],
          )
        ],
      ),
    );
  }

  Widget ratesList() {
    total = rate1 + rate2 + taxFees + tip;
    return Container(
      //margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffffffff)),
      child: Column(
        children: [
          individualRate(
              rateDescription: "0 - 2 hours",
              time: "2:00",
              price: rate1.toStringAsFixed(2)),
          individualRate(
              rateDescription: "2 - 4 hours",
              time: "0:45",
              price: rate2.toStringAsFixed(2)),
          individualRate(
              rateDescription: "Tax and Fees",
              time: "",
              price: taxFees.toStringAsFixed(2)),
          individualRate(
              rateDescription: "Tip", time: "", price: tip.toStringAsFixed(2)),
          individualRate(
              rateDescription: "Total",
              time: "",
              price: total.toStringAsFixed(2))
        ],
      ),
    );
  }

  Widget addTipContainer(double tip) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Add Tip?"),
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          addTip(),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "*Full tip goes to our valets.",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showiOSMessageAlert(
      {required String title,
      required String message,
      required String cancel,
      required String action}) {
    showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title), // 'Have any questions?'
              content: Text(message), // 'Message $name'
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: Text(cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(action),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarOnWay(
                                  buildContext: context,
                                )));
                  },
                )
              ],
            ));
  }

  Widget checkOutButton() {
    return Container(
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
      width: 360,
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
          "pay",
          style: TextStyle(
            color: Color(0xffE8C0B5),
            fontSize: 24,
          ),
        ),
        onPressed: () {
          showiOSMessageAlert(
              title: "Are you sure?",
              message: "Tap confirm to request car.",
              cancel: "Cancel",
              action: "Confirm");
        },
      ),
    );
  }

  Widget addTip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffE8C0B5)),
                foregroundColor: MaterialStateProperty.all(Color(0xff294B56))),
            onPressed: () {
              decrementTip();
            },
            child: Icon(CupertinoIcons.minus)),
        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color(0xffFFFDF4),
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            "\$${tip.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 32, color: Color(0xff66867B)),
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffE8C0B5)),
                foregroundColor: MaterialStateProperty.all(Color(0xff294B56))),
            onPressed: () {
              incrementTip();
            },
            child: Icon(CupertinoIcons.add)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F4E9),
      appBar: AppBar(
        title: Text("Session #${widget.sessionID}"),
        backgroundColor: Color(0xffF7F4E9),
        foregroundColor: Color(0xff294B56),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sessionTime(sessionTime: "2:07"),
                ],
              ),
              receiptContainer(receiptID: "322231"),
              orderSummaryContainer(rate1: "he", rate2: "he"),
              addTipContainer(3),
              checkOutButton(),
              Padding(padding: EdgeInsets.all(40))
            ],
          ),
        ]),
      ),
    );
  }
}
