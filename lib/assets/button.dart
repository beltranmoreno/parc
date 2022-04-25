import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/theme/custom_theme.dart';

import '../car_on_way.dart';

void showiOSMessageAlert(
    {required String title,
    required String message,
    required String cancel,
    required String action,
    required BuildContext context}) {
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
                  if (title == 'pay') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarOnWay(
                                  buildContext: context,
                                )));
                  } else if (title == 'checkout') {}
                },
              )
            ],
          ));
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.buildContext,
      required this.title,
      required this.fore,
      required this.back})
      : super(key: key);

  final BuildContext buildContext;
  final String title;
  final Color fore;
  final Color back;

  action({required String title}) {
    if (title == "pay") {
      showiOSMessageAlert(
          title: "Are you sure?",
          message: "Tap confirm to request car.",
          cancel: "Cancel",
          action: "Confirm",
          context: buildContext);
    } else if (title == 'checkout') {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ElevatedButton(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (states) => TextStyle(fontSize: 24, fontFamily: 'Montserrat')),
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (states) => EdgeInsets.fromLTRB(10, 20, 10, 20)),
            foregroundColor:
                MaterialStateProperty.resolveWith<Color>((states) => fore),
            backgroundColor:
                MaterialStateProperty.resolveWith<Color>((states) => back),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20));
            }),
          ),
          onPressed: () async {
            action(title: title);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: CustomTheme().mainFont,
              ),
            ],
          )),
    );
  }
}
