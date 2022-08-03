import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../detail/detailinfo.dart';
import 'homelist.dart';
import 'mybanner.dart';

class homeTab extends StatefulWidget {
  const homeTab({Key? key}) : super(key: key);

  @override
  State<homeTab> createState() => _homeTabState();
}

class _homeTabState extends State<homeTab> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    _controller.index = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.abc,
                  color: Colors.black,
                ),
                child: Text(
                  "Tab1",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.abc,
                  color: Colors.black,
                ),
                child: Text(
                  "Tab2",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.abc,
                  color: Colors.black,
                ),
                child: Text(
                  "Tab3",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.abc,
                  color: Colors.black,
                ),
                child: Text(
                  "Tab4",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
            controller: _controller,
          ),
          Expanded(
            child: TabBarView(controller: _controller, children: [
              Column(
                children: [
                  // homeTopWidget(),
                  Expanded(child: MyHomeList()),
                ],
              ),
              Column(
                children: [
                  Center(
                    child: ListTile(title: Text("Try click use HeroWidget")),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return detailinfoWidget();
                        }));
                      },
                      child: Hero(
                        tag: "item",
                        child: MyBannerImage(
                            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto"),
                      )),
                  bottomItem(),
                ],
              ),
              ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Center(
                        child: AnimatedTextKit(
                          key: Key("0"),
                          animatedTexts: [
                            TyperAnimatedText("Try scroll the ListTile",
                                speed: Duration(milliseconds: 50),
                                textStyle: TextStyle(
                                  fontSize: 20,
                                ))
                          ],
                          repeatForever: false,
                          totalRepeatCount: 1,
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      );
                    } else {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                showModalBottomSheet<GridView>(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 200,
                                        child: GridView(
                                          padding: EdgeInsets.only(top: 20),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4),
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.web),
                                                Text("Web"),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.photo),
                                                Text("Save"),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.facebook),
                                                Text("FaceBook"),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.tiktok),
                                                Text("Tittok"),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.block),
                                                Text("Block"),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.wechat),
                                                Text("Wechat"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              label: "Share",
                              icon: Icons.share,
                            ),
                            SlidableAction(
                              onPressed: (context) {},
                              label: "Edit",
                              icon: Icons.edit,
                            ),
                          ],
                        ),
                        child: ListTile(title: Text("I'm the $index")),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      color: Colors.cyan,
                    );
                  },
                  itemCount: 20),
              Text("page4"),
            ]),
          ),
        ],
      ),
    );
  }
}
