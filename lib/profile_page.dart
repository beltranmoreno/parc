import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, required this.buildContext})
      : super(key: key);

  final BuildContext buildContext;

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Widget greetingContainer(
      {required String name,
      required String memberStatus,
      required String image}) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xff66867B),
      ),*/
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Hello, $name.",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Mate',
                        color: Color(0xff294B56)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    memberStatus,
                    style: TextStyle(fontSize: 12, color: Color(0xff294B56)),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.person,
                size: 40,
              ),
              SizedBox(width: 40)
            ],
          )
        ],
      ),
    );
  }

  Widget userCarsContainer() {
    return Container(
      margin: EdgeInsets.all(20),
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffFFFfdd),
      ),*/
      //height: 250,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "My Cars",
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(CupertinoIcons.add),
                  SizedBox(
                    width: 60,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          userCarCard(name: "Audi", license: "HSD 569", image: "0"),
          SizedBox(height: 10),
          userCarCard(name: "Ferrari", license: "GDF 889", image: "1")
        ],
      ),
    );
  }

  Widget userCarCard(
      {required String name, required String license, required String image}) {
    return Container(
      height: 80,
      //margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffFFFDF4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    children: [Icon(CupertinoIcons.car_detailed)],
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(license)
                    ],
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(CupertinoIcons.chevron_forward)],
          )
        ],
      ),
    );
  }

  Widget userAccountMenu() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Account",
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xffFFFDF4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Payment Methods"),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar(String? name) {
    return AppBar(
      backgroundColor: Color(0xffF7F4E9),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      //backgroundColor: myTheme!.getBGColor(),Text("Hello"),
      centerTitle: false,
      leadingWidth: 15,
      title: Text(
        "Hello, $name",
        style: const TextStyle(
          fontSize: 32,
          color: Color(0xff294B56),
          fontFamily: 'Mate',
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
              onTap: () {},
              child: Icon(CupertinoIcons.person,
                  size: 42, color: Color(0xff294B56))),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F4E9),
      appBar: appBar("John"),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 40,
          ),
          greetingContainer(
              name: "John", memberStatus: "Platinum Member", image: "jpg"),
          //userCarCard(name: "Audi", license: "HSD 569", image: "image"),
          userCarsContainer(),
          userAccountMenu(),
        ]),
      ),
    );
  }
}
