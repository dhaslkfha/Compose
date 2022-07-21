import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

///首页
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<Widget> widgetList = [
    const WebView(
      initialUrl: "https://flutter.dev",
      javascriptMode: JavascriptMode.unrestricted,
    ),
    const Center(child: Text("第二个界面")),
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "我的"),
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
