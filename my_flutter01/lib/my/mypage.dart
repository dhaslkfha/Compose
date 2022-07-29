import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter01/my/aboutus.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
              if (index < 18) {
                return SwitchListTile(
                  value: false,
                  onChanged: (value) {},
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
