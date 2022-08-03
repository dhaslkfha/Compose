import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter01/home/hometab.dart';

import '../my/mypage.dart';

///首页
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late ConnectivityResult connectivity;
  late StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lisentenConnet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  void lisentenConnet() {
    print("lisentenConnet");
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      print("onConnectivityChanged : $event");
      getconnect();
    });
  }

  Future<void> getconnect() async {
    connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.mobile) {
      // setState(() {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text("mobile connect"),behavior: SnackBarBehavior.fixed,
      //   ));
      //  });
    } else if (connectivity == ConnectivityResult.none) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("fail connect"),
            behavior: SnackBarBehavior.floating));
      });
    }
  }

  List<Widget> widgetList = [
    Column(
      children: [
        homeTopWidget(),
        // Expanded(child: MyHomeList()),
        Expanded(
          child: homeTab(),
        ),
      ],
    ),
    MyPage(),
  ];
  int _selected = 0;

  void _onTapNav(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(index: _selected, children: widgetList),
          ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "My"),
            ],
            selectedItemColor: Colors.amber[500],
            type: BottomNavigationBarType.fixed,
            onTap: _onTapNav,
            currentIndex: _selected,
          ),
        ],
      ),
    );
  }
}

class homeTopWidget extends StatefulWidget {
  const homeTopWidget({Key? key}) : super(key: key);

  @override
  State<homeTopWidget> createState() => _homeTopWidgetState();
}

class _homeTopWidgetState extends State<homeTopWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 0, color: Colors.grey)),
                      hintText: "Input the key words",
                      prefixIcon: Icon(Icons.search_rounded),
                      isCollapsed: false,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    onSubmitted: (input) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Tips"),
                              content: Text("you typed $input"),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                )),
            Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10.0),
                child: Stack(children: [
                  OutlinedButton(
                    onPressed: () {
                      print("click the button");
                    },
                    child: Container(),
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(30, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        side: BorderSide(color: Colors.black, width: 2)),
                  ),
                  Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
