import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'homelist.dart';

class homeTab extends StatefulWidget {
  const homeTab({Key? key}) : super(key: key);

  @override
  State<homeTab> createState() => _homeTabState();
}

class _homeTabState extends State<homeTab> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Text("Tab1"),
              ),
              Tab(
                child: Text("Tab2"),
              ),
              Tab(
                child: Text("Tab3"),
              ),
              Tab(
                child: Text("Tab4"),
              ),
            ],
            controller: _controller,
          ),
          TabBarView(controller: _controller, children: [
            Column(
              children: [
                homeTopWidget(),
                Expanded(child: MyHomeList()),
              ],
            ),
            Text("page2"),
            Text("page3"),
            Text("page4"),
          ]),
        ],
      ),
    );
  }
}
