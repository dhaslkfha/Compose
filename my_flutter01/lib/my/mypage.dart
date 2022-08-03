import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter01/my/aboutus.dart';
import 'package:my_flutter01/my/profile.dart';
import 'package:my_flutter01/my/setting.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<String> selects = List.generate(18, (index) => "0");
  late SharedPreferences sp;

  Future<void> getSelects() async {
    sp = await SharedPreferences.getInstance();
    setState(() {
      selects = sp.getStringList("select") ?? List.generate(18, (index) => "0");
      print("select: ${selects.toString()}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sp.setStringList("select", selects);
    print("setselect: ${selects.toString()}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("My Name is Tom"),
              background: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: Image.asset(
                  "images/img.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return myTopWidget(context);
              } else if (index < 18 && index > 0) {
                return SwitchListTile(
                  value: selects[index] == "1",
                  onChanged: (value) {
                    var cur = "";
                    if (value) {
                      cur = "1";
                    } else {
                      cur = "0";
                    }
                    setState(() {
                      selects[index] = cur;
                      sp.setStringList("select", selects);
                    });
                  },
                  title: Text("Setting $index"),
                );
              } else if (index == 18) {
                return ListTile(
                  title: Text("About us"),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AboutUsWidget();
                    }));
                  },
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Help you with our service",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "our service time 7*24",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Divider(
                          height: 30,
                          thickness: 2,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                launchUrl(Uri.parse("tel:955559"));
                              },
                              child: Text(
                                "955559",
                                style: TextStyle(fontSize: 16),
                              )),
                          Icon(
                            Icons.phone,
                            color: Colors.black,
                            size: 30.0,
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}

Widget myTopWidget(BuildContext context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Setting();
                }));
              },
              child: Icon(
                Icons.settings,
                color: Colors.black,
                size: 20,
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
            child: ClipOval(
                child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(
                      "https://img.uni.changan.com.cn/base/2022/06/17/1655432716860androidios1920_864.jpeg",
                      fit: BoxFit.cover,
                    ))),
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Text(
            "My Nick Name ",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[200]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.currency_bitcoin,
                  color: Colors.red,
                  size: 20,
                ),
                Text(
                  "My bitcoin is 192",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(
                  Icons.arrow_right,
                  size: 18,
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Text(
                  "34",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "49",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "1174",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "81",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ]),
              TableRow(children: [
                Text(
                  "fans",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "follow",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "posts",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "favourite",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ]),
            ],
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "daily sign",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    7,
                    (index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                              color: Colors.red[100],
                              shape: BeveledRectangleBorder(
                                  side:
                                      BorderSide(width: 0.5, color: Colors.red),
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "+1",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "${DateTime.now().add(Duration(days: 1 * index)).month}.${DateTime.now().add(Duration(days: 1 * index)).day}")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
