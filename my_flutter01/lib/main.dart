import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter01/home/HomePage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'adaptedemo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:camera/camera.dart';

import 'battery.dart';
import 'mylocation.dart';

///相机
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final camera = await availableCameras();
//   cameraDescription = camera[0];
//   runApp(MyApp());
// }
void main() => runApp(MyApp());

///照相
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final camera = await availableCameras();
//
//   final firtCamera = camera.first;
//   runApp(MaterialApp(
//     title: "Camera",
//     home: CameraTestWidget(camera: firtCamera),
//   ));
// }
// void main() => runApp(MyListApp);

var MyListApp = const MaterialApp(
  title: "Shopping App",
  home: ShoppingList(
    products: [
      Product(name: 'Eggs'),
      Product(name: 'Flour'),
      Product(name: 'Chocolate chips'),
    ],
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    VisualDensity densityAmt =
        const VisualDensity(horizontal: 1.0, vertical: 2.0);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.green,
        visualDensity: Theme.of(context).visualDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "homepage": (context) => HomePageWidget(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: const [
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    Expanded(
                      child: Text(
                        "标题",
                        style: TextStyle(color: Colors.white),
                      ),
                      flex: 3,
                    ),
                    Expanded(
                      child: Text(
                        "副标题",
                        style: TextStyle(color: Colors.white),
                      ),
                      flex: 6,
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      tooltip: "搜索",
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: const Text("手势输入"),
                onTap: () {
                  print('点击了');
                },
              ),
              Counter(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          var pls = const MaterialApp(
                            title: "Shopping App",
                            home: ShoppingList(
                              products: [
                                Product(name: 'Eggs'),
                                Product(name: 'Flour'),
                                Product(name: 'Chocolate chips'),
                              ],
                            ),
                          );
                          return Scaffold(
                            appBar: AppBar(title: Text("Shopping App")),
                            body: pls,
                          );
                        }));
                      },
                      child: Text("跳转列表")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          var pls =
                              MaterialApp(title: "GridView", home: gridPage);
                          return MaterialApp(
                            title: "Shopping App",
                            home: pls,
                          );
                        }));
                      },
                      child: const Text("跳转GridView")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          var pls =
                              MaterialApp(title: "GridView", home: listPage);
                          return MaterialApp(
                            title: "Shopping App",
                            home: pls,
                          );
                        }));
                      },
                      child: const Text("跳转ListView")),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("卧室第一个"),
                      GestureDetector(
                        onDoubleTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return HomePageWidget();
                          }));
                        },
                        child: IconButton(
                            focusColor: Colors.blue,
                            onPressed: () {
                              print("ssss");
                            },
                            icon: const Icon(Icons.add)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto",
                        height: 80,
                      ),
                      const Center(
                        child: Image(
                          image: AssetImage('images/myimg.png'),
                          height: 80,
                        ),
                      ),
                      _buildStack(),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.green[500],
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.green[500],
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.green[500],
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const Text(
                            "170 Reviews",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontSize: 16),
                          )
                        ],
                      ),
                      DefaultTextStyle.merge(
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontFamily: 'Roboto',
                              height: 2),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: const [
                                    Icon(Icons.kitchen),
                                    Text("PREP:"),
                                    Text("25min")
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Icon(Icons.timer),
                                    Text("COOK:"),
                                    Text("1h")
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Icon(Icons.restaurant),
                                    Text("FEEDS:"),
                                    Text("4-6")
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.abc),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return _buildCard();
                      }));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return _buildDemo1();
                      }));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.rocket,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return _buildAdapteWidget(context);
                      }));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return constraintWidg();
                      }));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.mobile_friendly,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ParentWidget();
                      }));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return FadeInDemo();
                      }));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.enhance_photo_translate,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const AnimatedContainerDemo();
                      }));
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.analytics,
                      color: Colors.pink,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const LogoApp();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "重复使用的Animate",
                    icon: const Icon(
                      Icons.animation_sharp,
                      color: Colors.pink,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LogoApp2();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "AnimatedBuilder",
                    icon: const Icon(
                      Icons.bubble_chart,
                      color: Colors.deepOrangeAccent,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LogoApp3();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "AnimatedBuilder",
                    icon: const Icon(
                      Icons.cabin,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return HeroAnimation();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "AnimatedBuilder",
                    icon: const Icon(
                      Icons.dangerous,
                      color: Colors.cyan,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return RadialExpansionDemo();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "StaggerAnimation",
                    icon: const Icon(
                      Icons.safety_check,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return StaggeredWidget();
                      }));
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "bottomNav",
                    icon: const Icon(
                      Icons.baby_changing_station,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MyBottomSelct();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "nofiter",
                    icon: const Icon(
                      Icons.notification_add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NoProviderTest();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "network",
                    icon: const Icon(
                      Icons.notification_add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NetworkTestWidget();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "isolate",
                    icon: const Icon(
                      Icons.notification_add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return IsolateWidget();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "post",
                    icon: const Icon(
                      Icons.notification_add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PostTextWidget();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "socket",
                    icon: const Icon(
                      Icons.social_distance,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SocketTestWidget();
                      }));
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "sqlite",
                    icon: const Icon(
                      Icons.data_object,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SqliteTestWidget(
                          fileTest: FileTest(),
                        );
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "video",
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return VideoPlayerTestWidget();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "camera",
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return CameraOuterWidget();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "battery",
                    icon: const Icon(
                      Icons.battery_0_bar,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MyBatteryWidget();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "原生view",
                    icon: const Icon(
                      Icons.view_agenda,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return WAndroidViewWidget();
                      }));
                    },
                  ),
                  IconButton(
                    tooltip: "url launcher",
                    icon: const Icon(
                      Icons.launch,
                      color: Colors.redAccent,
                    ),
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse("https://flutter.dev"))) {
                        throw 'Could not lunche';
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "location",
                    icon: const Icon(
                      Icons.location_city,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MyLocationWidget();
                      }));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// stateful 组件
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({Key? key, required this.count}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Text("数量：$count");
  }
}

class CounterIncrement extends StatelessWidget {
  final VoidCallback increase;

  const CounterIncrement({Key? key, required this.increase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: increase, child: const Text("增加"));
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increase() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CounterIncrement(increase: _increase),
        const SizedBox(
          width: 16,
        ),
        CounterDisplay(count: _count)
      ],
    );
  }
}

/// 购物应用
class Product {
  final String name;

  const Product({required this.name});
}

typedef CartChangedCallback = Function(Product product, bool isCart);

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool isCart;
  final CartChangedCallback callback;

  const ShoppingListItem(
      {Key? key,
      required this.product,
      required this.isCart,
      required this.callback})
      : super(key: key);

  Color _getColor(BuildContext context) {
    print('${rootBundle.loadString('assets/config.json')}');
    // _demopackageDemo();
    return isCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!isCart) return null;
    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        callback(product, isCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

class ShoppingList extends StatefulWidget {
  final List<Product> products;

  const ShoppingList({Key? key, required this.products}) : super(key: key);

  @override
  _ShoppingListState createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  final _shopingCart = <Product>{};

  void _handleCartChanged(Product product, bool isCart) {
    setState(() {
      if (!isCart) {
        _shopingCart.add(product);
      } else {
        _shopingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((product) {
          return ShoppingListItem(
            product: product,
            isCart: _shopingCart.contains(product),
            callback: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

var gridPage = Scaffold(
  appBar: AppBar(
    title: const Text("hello"),
  ),
  body: _buildGrid(),
);

Widget _buildGrid() => GridView.count(
    crossAxisCount: 2,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(30));

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) => List.generate(
    count,
    (i) => Container(
        child: Image.network(
            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto")));

var listPage = Scaffold(
  appBar: AppBar(
    title: const Text("hello"),
  ),
  body: _buildList(),
);

Widget _buildList() {
  return ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      const Divider(),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  );
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}

Widget _buildStack() {
  return Stack(
    alignment: const Alignment(0.5, 0.5),
    children: [
      const CircleAvatar(
        backgroundImage: AssetImage('images/img.png'),
        radius: 50,
      ),
      Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
        ),
        child: const Text(
          'Mia B',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

Widget _buildCard() {
  return SizedBox(
    height: 120,
    child: Card(
      elevation: 24,
      child: Column(
        children: [
          ListTile(
            title: const Text(
              '1625 Main Street',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('My City, CA 9984'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              '(408) 555-1212',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: const Text('costa@example.com'),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDemo1() {
  return Scaffold(
      appBar: AppBar(
        title: Text("Demo1"),
      ),
      body: ListView(
        children: [
          Image.asset(
            'images/img.png',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          _titleSection(),
          buttonSection,
          textSection,
        ],
      ));
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _toggleFavorite,
          icon: Icon(
            _isFavorited ? Icons.star : Icons.star_border,
            color: Colors.red[500],
          ),
        ),
        Text('$_favoriteCount', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}

Widget _titleSection() {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Oeschinen Lake Campground',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(color: Colors.grey[500], fontSize: 20),
            ),
          ],
        )),
        FavoriteWidget(),
        // Icon(
        //   Icons.star,
        //   color: Colors.red[500],
        // ),
        // const Text('41', style: TextStyle(fontSize: 20)),
      ],
    ),
  );
}

// Color color = Theme.of(context).primaryColor;
Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildButtonColumn(Colors.grey, Icons.call, "CALL"),
    _buildButtonColumn(Colors.grey, Icons.near_me, "ROUTE"),
    _buildButtonColumn(Colors.grey, Icons.share, "SHARE"),
  ],
);

Column _buildButtonColumn(Color color, IconData iconData, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        iconData,
        color: color,
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: color),
        ),
      )
    ],
  );
}

Widget textSection = const Padding(
  padding: EdgeInsets.all(32),
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
    'Alps. Situated 1,578 meters above sea level, it is one of the '
    'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
    'half-hour walk through pastures and pine forest, leads you to the '
    'lake, which warms to 20 degrees Celsius in the summer. Activities '
    'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);

///
///

Widget _buildAdapteWidget(BuildContext context) {
  bool isSmall = getSize(context) == ScreenSize.Small;
  return Scaffold(
    appBar: AppBar(
      actions: const [
        IconButton(onPressed: null, icon: Icon(Icons.access_alarm))
      ],
    ),
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('使用MediaQuery来控制Flex:'),
          Flex(
            direction: isSmall ? Axis.vertical : Axis.horizontal,
            children: const [
              SizedBox(child: Text("第一个")),
              SizedBox(child: Text("第二个")),
            ],
          ),
          const Text('旋转屏幕看下面的效果-使用LayoutBuilder:'),
          foo,
          const Text('Styling:'),
          Padding(
              padding: EdgeInsets.all(Insets.small),
              child: Text(
                '我用了Styling',
                style: TextStyles.body1,
              )),
          const Text('自定义ScrollListener:'),
          // scrollLis(),
          _focusGroup(),
          _keyboardListen(),
          _buildshortcut(context),
          tooltip,
          DragandDropWidgeextends(),
        ],
      ),
    ),
  );
}

///多设备
enum ScreenSize { Small, Normal, Large, ExtraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.ExtraLarge;
  return ScreenSize.Small;
}

Widget foo = LayoutBuilder(builder: (context, constraints) {
  bool useVerticalLayout = constraints.maxWidth < 400;
  return Flex(
      children: const [Text("hello"), Text("world")],
      direction: useVerticalLayout ? Axis.vertical : Axis.horizontal);
});

///多设备
bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

bool get isDesktopDevice =>
    !kIsWeb & (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

///全局样式
class Insets {
  static const double xsmall = 3;
  static const double small = 4;
  static const double medium = 5;
  static const double large = 10;
  static const double extraLarge = 20;
// etc
}

class Fonts {
  static const String raleway = 'Raleway';
// etc
}

class TextStyles {
  static const TextStyle raleway = const TextStyle(
    fontFamily: Fonts.raleway,
  );
  static const TextStyle buttonText1 =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
  static TextStyle buttonText2 =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 11);
  static TextStyle h1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  static TextStyle h2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static late TextStyle body1 = raleway.copyWith(color: Color(0xFF42A5F5));
// etc
}

///自定义ScrollListener
Widget scrollLis() => Listener(
      onPointerSignal: (evesnt) {
        if (evesnt is PointerScrollEvent) print(evesnt.scrollDelta.dy);
      },
      child: ListView(),
    );

///Tab traversal
///
/*

class _BasicActionDetectorState extends State<BasicActionDetector> {
  bool _hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onFocusChange: (value) => setState(() => _hasFocus = value),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(onInvoke: (intent) {
          print('Enter or Space was pressed!');
          return null;
        }),
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          FlutterLogo(size: 100),
          // Position focus in the negative margin for a cool effect
          if (_hasFocus)
            Positioned(
                left: -4,
                top: -4,
                bottom: -4,
                right: -4,
                child: _roundedBorder())
        ],
      ),
    );
  }
}
*/

///Tab
Widget _focusGroup() => Column(
      children: [
        FocusTraversalGroup(
            child: Column(
          children: const [
            Text("Groupchild1"),
            Text("Groupchild2"),
            Text("Groupchild3"),
          ],
        )),
      ],
    );

///KEYBOARD
Widget _keyboardListen() => Focus(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400, minHeight: 30),
      child: const TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(2)),
        )),
      ),
    ));

///shortcuts
// Define a class for each type of shortcut action you want
class CreateNewItemIntent extends Intent {
  const CreateNewItemIntent();
}

Widget _buildshortcut(BuildContext context) {
  return Shortcuts(
    // Bind intents to key combinations Control+N
    shortcuts: <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyN, control: true):
          CreateNewItemIntent(),
    },
    child: Actions(
      // Bind intents to an actual method in your code
      actions: <Type, Action<Intent>>{
        CreateNewItemIntent: CallbackAction<CreateNewItemIntent>(
            onInvoke: (intent) => debugPrint("快捷键啊")),
      },
      // Your sub-tree must be wrapped in a focusNode, so it can take focus.
      child: Focus(
        autofocus: true,
        child: Container(
          child: const Text("我可以监听快捷键control+N"),
        ),
      ),
    ),
  );
}

var globalLis = <ShortcutActivator, Intent>{
  const SingleActivator(LogicalKeyboardKey.keyA, control: true):
      const CreateNewItemIntent(),
};

///全局监听快捷键，不知如何使用
void initState() {
  RawKeyboard.instance.addListener((value) {
    globalLis;
  });
}

void dispose() {
  RawKeyboard.instance.removeListener((value) {
    globalLis;
  });
}

///监听是否按下
bool isKeyDown(Set<LogicalKeyboardKey> keys) {
  return keys.intersection(RawKeyboard.instance.keysPressed).isNotEmpty;
}

void _handleKey(event) {
  if (event is RawKeyDownEvent) {
    bool isShiftDown = isKeyDown({
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.shiftRight,
    });
    if (isShiftDown && event.logicalKey == LogicalKeyboardKey.keyN) {
      print("按钮被点击");
    }
  }
}

var tooltip = const Tooltip(
  message: 'Im a tooltip',
  child: Text('over over the text to show a tooltip.'),
);

///drag drop
class DragandDropWidgeextends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DragandDropWidgeextends();
  }
}

class _DragandDropWidgeextends extends State<DragandDropWidgeextends> {
  int acceptDate = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable(
            data: 10,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.lightGreenAccent,
              child: const Center(
                child: Text('Draggable'),
              ),
            ),
            feedback: Container(
              color: Colors.deepOrange,
              height: 100,
              width: 100,
              child: const Icon(Icons.directions_run),
            )),
        DragTarget(
          builder: (context, accepted, rejected) {
            return Container(
              height: 100.0,
              width: 100.0,
              color: Colors.cyan,
              child: Center(
                child: Text('Value is updated to: ${acceptDate}'),
              ),
            );
          },
          onAccept: (int data) {
            setState(() {
              acceptDate += data;
            });
          },
        ),
      ],
    );
  }
}

//Constraints

Widget constraintWidg() => const HomePage();

const red = Colors.red;
const green = Colors.green;
const blue = Colors.blue;
const big = TextStyle(fontSize: 30);

//////////////////////////////////////////////////

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlutterLayoutArticle([
      Example1(),
      Example2(),
      Example3(),
      Example4(),
      Example5(),
      Example6(),
      Example7(),
      Example8(),
      Example9(),
      Example10(),
      Example11(),
      Example12(),
      Example13(),
      Example14(),
      Example15(),
      Example16(),
      Example17(),
      Example18(),
      Example19(),
      Example20(),
      Example21(),
      Example22(),
      Example23(),
      Example24(),
      Example25(),
      Example26(),
      Example27(),
      Example28(),
      Example29(),
    ]);
  }
}

//////////////////////////////////////////////////

abstract class Example extends StatelessWidget {
  const Example({super.key});

  String get code;

  String get explanation;
}

//////////////////////////////////////////////////

class FlutterLayoutArticle extends StatefulWidget {
  const FlutterLayoutArticle(
    this.examples, {
    super.key,
  });

  final List<Example> examples;

  @override
  _FlutterLayoutArticleState createState() => _FlutterLayoutArticleState();
}

//////////////////////////////////////////////////

class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
  late int count;
  late Widget example;
  late String code;
  late String explanation;

  @override
  void initState() {
    count = 1;
    code = const Example1().code;
    explanation = const Example1().explanation;

    super.initState();
  }

  @override
  void didUpdateWidget(FlutterLayoutArticle oldWidget) {
    super.didUpdateWidget(oldWidget);
    var example = widget.examples[count - 1];
    code = example.code;
    explanation = example.explanation;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Article',
      home: SafeArea(
        child: Material(
          color: Colors.yellow,
          child: FittedBox(
            child: Container(
              width: 400,
              height: 670,
              color: const Color(0xFFCCCCCC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                              width: double.infinity, height: double.infinity),
                          child: widget.examples[count - 1])),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < widget.examples.length; i++)
                            Container(
                              width: 58,
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: button(i + 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        key: ValueKey(count),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Center(child: Text(code)),
                              const SizedBox(height: 15),
                              Text(
                                explanation,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    height: 273,
                    color: Colors.grey[500],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(int exampleNumber) {
    return Button(
      key: ValueKey('button$exampleNumber'),
      isSelected: count == exampleNumber,
      exampleNumber: exampleNumber,
      onPressed: () {
        showExample(
          exampleNumber,
          widget.examples[exampleNumber - 1].code,
          widget.examples[exampleNumber - 1].explanation,
        );
      },
    );
  }

  void showExample(int exampleNumber, String code, String explanation) {
    setState(() {
      count = exampleNumber;
      this.code = code;
      this.explanation = explanation;
    });
  }
}

//////////////////////////////////////////////////

class Button extends StatelessWidget {
  final bool isSelected;
  final int exampleNumber;
  final VoidCallback onPressed;

  const Button({
    required Key key,
    required this.isSelected,
    required this.exampleNumber,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: isSelected ? Colors.grey : Colors.grey[800],
      ),
      child: Text(exampleNumber.toString()),
      onPressed: () {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          alignment: 0.5,
        );
        onPressed();
      },
    );
  }
}
//////////////////////////////////////////////////

class Example1 extends Example {
  const Example1({super.key});

  @override
  final code = 'Container(color: red)';

  @override
  final explanation = 'The screen is the parent of the Container, '
      'and it forces the Container to be exactly the same size as the screen.'
      '\n\n'
      'So the Container fills the screen and paints it red.';

  @override
  Widget build(BuildContext context) {
    return Container(color: red);
  }
}

//////////////////////////////////////////////////

class Example2 extends Example {
  const Example2({super.key});

  @override
  final code = 'Container(width: 100, height: 100, color: red)';
  @override
  final String explanation =
      'The red Container wants to be 100x100, but it can\'t, '
      'because the screen forces it to be exactly the same size as the screen.'
      '\n\n'
      'So the Container fills the screen.';

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: red);
  }
}

//////////////////////////////////////////////////

class Example3 extends Example {
  const Example3({super.key});

  @override
  final code = 'Center(\n'
      '   child: Container(width: 100, height: 100, color: red))';
  @override
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen, '
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
      'Now the Container can indeed be 100x100.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width: 100, height: 100, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example4 extends Example {
  const Example4({super.key});

  @override
  final code = 'Align(\n'
      '   alignment: Alignment.bottomRight,\n'
      '   child: Container(width: 100, height: 100, color: red))';
  @override
  final String explanation =
      'This is different from the previous example in that it uses Align instead of Center.'
      '\n\n'
      'Align also tells the Container that it can be any size it wants, but if there is empty space it won\'t center the Container. '
      'Instead, it aligns the Container to the bottom-right of the available space.';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(width: 100, height: 100, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example5 extends Example {
  const Example5({super.key});

  @override
  final code = 'Center(\n'
      '   child: Container(\n'
      '              color: red,\n'
      '              width: double.infinity,\n'
      '              height: double.infinity))';
  @override
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen, '
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
      'The Container wants to be of infinite size, but since it can\'t be bigger than the screen, it just fills the screen.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity, height: double.infinity, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example6 extends Example {
  const Example6({super.key});

  @override
  final code = 'Center(child: Container(color: red))';
  @override
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen, '
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
      '\n\n'
      'Since the Container has no child and no fixed size, it decides it wants to be as big as possible, so it fills the whole screen.'
      '\n\n'
      'But why does the Container decide that? '
      'Simply because that\'s a design decision by those who created the Container widget. '
      'It could have been created differently, and you have to read the Container documentation to understand how it behaves, depending on the circumstances. ';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example7 extends Example {
  const Example7({super.key});

  @override
  final code = 'Center(\n'
      '   child: Container(color: red\n'
      '      child: Container(color: green, width: 30, height: 30)))';
  @override
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen, '
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the red Container that it can be any size it wants, but not bigger than the screen.'
      'Since the red Container has no size but has a child, it decides it wants to be the same size as its child.'
      '\n\n'
      'The red Container tells its child that it can be any size it wants, but not bigger than the screen.'
      '\n\n'
      'The child is a green Container that wants to be 30x30.'
      '\n\n'
      'Since the red `Container` has no size but has a child, it decides it wants to be the same size as its child. '
      'The red color isn\'t visible, since the green Container entirely covers all of the red Container.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example8 extends Example {
  const Example8({super.key});

  @override
  final code = 'Center(\n'
      '   child: Container(color: red\n'
      '      padding: const EdgeInsets.all(20.0),\n'
      '      child: Container(color: green, width: 30, height: 30)))';
  @override
  final String explanation =
      'The red Container sizes itself to its children size, but it takes its own padding into consideration. '
      'So it is also 30x30 plus padding. '
      'The red color is visible because of the padding, and the green Container has the same size as in the previous example.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example9 extends Example {
  const Example9({super.key});

  @override
  final code = 'ConstrainedBox(\n'
      '   constraints: BoxConstraints(\n'
      '              minWidth: 70, minHeight: 70,\n'
      '              maxWidth: 150, maxHeight: 150),\n'
      '      child: Container(color: red, width: 10, height: 10)))';
  @override
  final String explanation =
      'You might guess that the Container has to be between 70 and 150 pixels, but you would be wrong. '
      'The ConstrainedBox only imposes ADDITIONAL constraints from those it receives from its parent.'
      '\n\n'
      'Here, the screen forces the ConstrainedBox to be exactly the same size as the screen, '
      'so it tells its child Container to also assume the size of the screen, '
      'thus ignoring its \'constraints\' parameter.';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 70,
        minHeight: 70,
        maxWidth: 150,
        maxHeight: 150,
      ),
      child: Container(color: red, width: 10, height: 10),
    );
  }
}

//////////////////////////////////////////////////

class Example10 extends Example {
  const Example10({super.key});

  @override
  final code = 'Center(\n'
      '   child: ConstrainedBox(\n'
      '      constraints: BoxConstraints(\n'
      '                 minWidth: 70, minHeight: 70,\n'
      '                 maxWidth: 150, maxHeight: 150),\n'
      '        child: Container(color: red, width: 10, height: 10))))';
  @override
  final String explanation =
      'Now, Center allows ConstrainedBox to be any size up to the screen size.'
      '\n\n'
      'The ConstrainedBox imposes ADDITIONAL constraints from its \'constraints\' parameter onto its child.'
      '\n\n'
      'The Container must be between 70 and 150 pixels. It wants to have 10 pixels, so it will end up having 70 (the MINIMUM).';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 150,
          maxHeight: 150,
        ),
        child: Container(color: red, width: 10, height: 10),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example11 extends Example {
  const Example11({super.key});

  @override
  final code = 'Center(\n'
      '   child: ConstrainedBox(\n'
      '      constraints: BoxConstraints(\n'
      '                 minWidth: 70, minHeight: 70,\n'
      '                 maxWidth: 150, maxHeight: 150),\n'
      '        child: Container(color: red, width: 1000, height: 1000))))';
  @override
  final String explanation =
      'Center allows ConstrainedBox to be any size up to the screen size.'
      'The ConstrainedBox imposes ADDITIONAL constraints from its \'constraints\' parameter onto its child'
      '\n\n'
      'The Container must be between 70 and 150 pixels. It wants to have 1000 pixels, so it ends up having 150 (the MAXIMUM).';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 150,
          maxHeight: 150,
        ),
        child: Container(color: red, width: 1000, height: 1000),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example12 extends Example {
  const Example12({super.key});

  @override
  final code = 'Center(\n'
      '   child: ConstrainedBox(\n'
      '      constraints: BoxConstraints(\n'
      '                 minWidth: 70, minHeight: 70,\n'
      '                 maxWidth: 150, maxHeight: 150),\n'
      '        child: Container(color: red, width: 100, height: 100))))';
  @override
  final String explanation =
      'Center allows ConstrainedBox to be any size up to the screen size.'
      'ConstrainedBox imposes ADDITIONAL constraints from its \'constraints\' parameter onto its child.'
      '\n\n'
      'The Container must be between 70 and 150 pixels. It wants to have 100 pixels, and that\'s the size it has, since that\'s between 70 and 150.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 150,
          maxHeight: 150,
        ),
        child: Container(color: red, width: 100, height: 100),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example13 extends Example {
  const Example13({super.key});

  @override
  final code = 'UnconstrainedBox(\n'
      '   child: Container(color: red, width: 20, height: 50));';
  @override
  final String explanation =
      'The screen forces the UnconstrainedBox to be exactly the same size as the screen.'
      'However, the UnconstrainedBox lets its child Container be any size it wants.';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 20, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example14 extends Example {
  const Example14({super.key});

  @override
  final code = 'UnconstrainedBox(\n'
      '   child: Container(color: red, width: 4000, height: 50));';
  @override
  final String explanation =
      'The screen forces the UnconstrainedBox to be exactly the same size as the screen, '
      'and UnconstrainedBox lets its child Container be any size it wants.'
      '\n\n'
      'Unfortunately, in this case the Container has 4000 pixels of width and is too big to fit in the UnconstrainedBox, '
      'so the UnconstrainedBox displays the much dreaded "overflow warning".';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example15 extends Example {
  const Example15({super.key});

  @override
  final code = 'OverflowBox(\n'
      '   minWidth: 0.0,'
      '   minHeight: 0.0,'
      '   maxWidth: double.infinity,'
      '   maxHeight: double.infinity,'
      '   child: Container(color: red, width: 4000, height: 50));';
  @override
  final String explanation =
      'The screen forces the OverflowBox to be exactly the same size as the screen, '
      'and OverflowBox lets its child Container be any size it wants.'
      '\n\n'
      'OverflowBox is similar to UnconstrainedBox, and the difference is that it won\'t display any warnings if the child doesn\'t fit the space.'
      '\n\n'
      'In this case the Container is 4000 pixels wide, and is too big to fit in the OverflowBox, '
      'but the OverflowBox simply shows as much as it can, with no warnings given.';

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minWidth: 0.0,
      minHeight: 0.0,
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example16 extends Example {
  const Example16({super.key});

  @override
  final code = 'UnconstrainedBox(\n'
      '   child: Container(color: Colors.red, width: double.infinity, height: 100));';
  @override
  final String explanation =
      'This won\'t render anything, and you\'ll see an error in the console.'
      '\n\n'
      'The UnconstrainedBox lets its child be any size it wants, '
      'however its child is a Container with infinite size.'
      '\n\n'
      'Flutter can\'t render infinite sizes, so it throws an error with the following message: '
      '"BoxConstraints forces an infinite width."';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: Colors.red, width: double.infinity, height: 100),
    );
  }
}

//////////////////////////////////////////////////

class Example17 extends Example {
  const Example17({super.key});

  @override
  final code = 'UnconstrainedBox(\n'
      '   child: LimitedBox(maxWidth: 100,\n'
      '      child: Container(color: Colors.red,\n'
      '                       width: double.infinity, height: 100));';
  @override
  final String explanation = 'Here you won\'t get an error anymore, '
      'because when the LimitedBox is given an infinite size by the UnconstrainedBox, '
      'it passes a maximum width of 100 down to its child.'
      '\n\n'
      'If you swap the UnconstrainedBox for a Center widget, '
      'the LimitedBox won\'t apply its limit anymore (since its limit is only applied when it gets infinite constraints), '
      'and the width of the Container is allowed to grow past 100.'
      '\n\n'
      'This explains the difference between a LimitedBox and a ConstrainedBox.';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: LimitedBox(
        maxWidth: 100,
        child: Container(
          color: Colors.red,
          width: double.infinity,
          height: 100,
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example18 extends Example {
  const Example18({super.key});

  @override
  final code = 'FittedBox(\n'
      '   child: Text(\'Some Example Text.\'));';
  @override
  final String explanation =
      'The screen forces the FittedBox to be exactly the same size as the screen.'
      'The Text has some natural width (also called its intrinsic width) that depends on the amount of text, its font size, and so on.'
      '\n\n'
      'The FittedBox lets the Text be any size it wants, '
      'but after the Text tells its size to the FittedBox, '
      'the FittedBox scales the Text until it fills all of the available width.';

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: Text('Some Example Text.'),
    );
  }
}

//////////////////////////////////////////////////

class Example19 extends Example {
  const Example19({super.key});

  @override
  final code = 'Center(\n'
      '   child: FittedBox(\n'
      '      child: Text(\'Some Example Text.\')));';
  @override
  final String explanation =
      'But what happens if you put the FittedBox inside of a Center widget? '
      'The Center lets the FittedBox be any size it wants, up to the screen size.'
      '\n\n'
      'The FittedBox then sizes itself to the Text, and lets the Text be any size it wants.'
      '\n\n'
      'Since both FittedBox and the Text have the same size, no scaling happens.';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FittedBox(
        child: Text('Some Example Text.'),
      ),
    );
  }
}

////////////////////////////////////////////////////

class Example20 extends Example {
  const Example20({super.key});

  @override
  final code = 'Center(\n'
      '   child: FittedBox(\n'
      '      child: Text(\'…\')));';
  @override
  final String explanation =
      'However, what happens if FittedBox is inside of a Center widget, but the Text is too large to fit the screen?'
      '\n\n'
      'FittedBox tries to size itself to the Text, but it can\'t be bigger than the screen. '
      'It then assumes the screen size, and resizes Text so that it fits the screen, too.';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FittedBox(
        child: Text(
            'This is some very very very large text that is too big to fit a regular screen in a single line.'),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example21 extends Example {
  const Example21({super.key});

  @override
  final code = 'Center(\n'
      '   child: Text(\'…\'));';
  @override
  final String explanation = 'If, however, you remove the FittedBox, '
      'the Text gets its maximum width from the screen, '
      'and breaks the line so that it fits the screen.';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'This is some very very very large text that is too big to fit a regular screen in a single line.'),
    );
  }
}

//////////////////////////////////////////////////

class Example22 extends Example {
  const Example22({super.key});

  @override
  final code = 'FittedBox(\n'
      '   child: Container(\n'
      '      height: 20.0, width: double.infinity));';
  @override
  final String explanation =
      'FittedBox can only scale a widget that is BOUNDED (has non-infinite width and height).'
      'Otherwise, it won\'t render anything, and you\'ll see an error in the console.';

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 20.0,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example23 extends Example {
  const Example23({super.key});

  @override
  final code = 'Row(children:[\n'
      '   Container(color: red, child: Text(\'Hello!\'))\n'
      '   Container(color: green, child: Text(\'Goodbye!\'))]';
  @override
  final String explanation =
      'The screen forces the Row to be exactly the same size as the screen.'
      '\n\n'
      'Just like an UnconstrainedBox, the Row won\'t impose any constraints onto its children, '
      'and instead lets them be any size they want.'
      '\n\n'
      'The Row then puts them side-by-side, and any extra space remains empty.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(color: red, child: const Text('Hello!', style: big)),
        Container(color: green, child: const Text('Goodbye!', style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example24 extends Example {
  const Example24({super.key});

  @override
  final code = 'Row(children:[\n'
      '   Container(color: red, child: Text(\'…\'))\n'
      '   Container(color: green, child: Text(\'Goodbye!\'))]';
  @override
  final String explanation =
      'Since the Row won\'t impose any constraints onto its children, '
      'it\'s quite possible that the children might be too big to fit the available width of the Row.'
      'In this case, just like an UnconstrainedBox, the Row displays the "overflow warning".';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: red,
          child: const Text(
            'This is a very long text that '
            'won\'t fit the line.',
            style: big,
          ),
        ),
        Container(color: green, child: const Text('Goodbye!', style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example25 extends Example {
  const Example25({super.key});

  @override
  final code = 'Row(children:[\n'
      '   Expanded(\n'
      '       child: Container(color: red, child: Text(\'…\')))\n'
      '   Container(color: green, child: Text(\'Goodbye!\'))]';
  @override
  final String explanation =
      'When a Row\'s child is wrapped in an Expanded widget, the Row won\'t let this child define its own width anymore.'
      '\n\n'
      'Instead, it defines the Expanded width according to the other children, and only then the Expanded widget forces the original child to have the Expanded\'s width.'
      '\n\n'
      'In other words, once you use Expanded, the original child\'s width becomes irrelevant, and is ignored.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Container(
              color: red,
              child: const Text(
                'This is a very long text that won\'t fit the line.',
                style: big,
              ),
            ),
          ),
        ),
        Container(color: green, child: const Text('Goodbye!', style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example26 extends Example {
  const Example26({super.key});

  @override
  final code = 'Row(children:[\n'
      '   Expanded(\n'
      '       child: Container(color: red, child: Text(\'…\')))\n'
      '   Expanded(\n'
      '       child: Container(color: green, child: Text(\'Goodbye!\'))]';
  @override
  final String explanation =
      'If all of Row\'s children are wrapped in Expanded widgets, each Expanded has a size proportional to its flex parameter, '
      'and only then each Expanded widget forces its child to have the Expanded\'s width.'
      '\n\n'
      'In other words, Expanded ignores the preffered width of its children.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: red,
            child: const Text(
              'This is a very long text that won\'t fit the line.',
              style: big,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: green,
            child: const Text(
              'Goodbye!',
              style: big,
            ),
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example27 extends Example {
  const Example27({super.key});

  @override
  final code = 'Row(children:[\n'
      '   Flexible(\n'
      '       child: Container(color: red, child: Text(\'…\')))\n'
      '   Flexible(\n'
      '       child: Container(color: green, child: Text(\'Goodbye!\'))]';
  @override
  final String explanation =
      'The only difference if you use Flexible instead of Expanded, '
      'is that Flexible lets its child be SMALLER than the Flexible width, '
      'while Expanded forces its child to have the same width of the Expanded.'
      '\n\n'
      'But both Expanded and Flexible ignore their children\'s width when sizing themselves.'
      '\n\n'
      'This means that it\'s IMPOSSIBLE to expand Row children proportionally to their sizes. '
      'The Row either uses the exact child\'s width, or ignores it completely when you use Expanded or Flexible.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            color: red,
            child: const Text(
              'This is a very long text that won\'t fit the line.',
              style: big,
            ),
          ),
        ),
        Flexible(
          child: Container(
            color: green,
            child: const Text(
              'Goodbye!',
              style: big,
            ),
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example28 extends Example {
  const Example28({super.key});

  @override
  final code = 'Scaffold(\n'
      '   body: Container(color: blue,\n'
      '   child: Column(\n'
      '      children: [\n'
      '         Text(\'Hello!\'),\n'
      '         Text(\'Goodbye!\')])))';

  @override
  final String explanation =
      'The screen forces the Scaffold to be exactly the same size as the screen, '
      'so the Scaffold fills the screen.'
      '\n\n'
      'The Scaffold tells the Container that it can be any size it wants, but not bigger than the screen.'
      '\n\n'
      'When a widget tells its child that it can be smaller than a certain size, '
      'we say the widget supplies "loose" constraints to its child. More on that later.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: blue,
        child: Column(
          children: const [
            Text('Hello!'),
            Text('Goodbye!'),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example29 extends Example {
  const Example29({super.key});

  @override
  final code = 'Scaffold(\n'
      '   body: Container(color: blue,\n'
      '   child: SizedBox.expand(\n'
      '      child: Column(\n'
      '         children: [\n'
      '            Text(\'Hello!\'),\n'
      '            Text(\'Goodbye!\')]))))';

  @override
  final String explanation =
      'If you want the Scaffold\'s child to be exactly the same size as the Scaffold itself, '
      'you can wrap its child with SizedBox.expand.'
      '\n\n'
      'When a widget tells its child that it must be of a certain size, '
      'we say the widget supplies "tight" constraints to its child. More on that later.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: blue,
          child: Column(
            children: const [
              Text('Hello!'),
              Text('Goodbye!'),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////交互

//---------------------------- ParentWidget ----------------------------

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        child: TapboxC(
          active: _active,
          onChanged: _handleTapboxChanged,
        ),
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  const TapboxC({
    super.key,
    this.active = false,
    required this.onChanged,
  });

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return GestureDetector(
      onTapDown: _handleTapDown,
      // Handle the tap events in the order that
      onTapUp: _handleTapUp,
      // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(widget.active ? 'Active' : 'Inactive',
              style: const TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.teal[700]!,
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}

class FadeInDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FadeInDemoState();
  }
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network(
                'https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto'),
            TextButton(
                onPressed: () => setState(() {
                      opacity = 1;
                    }),
                child: const Text(
                  'show details',
                  style: TextStyle(color: Colors.blueAccent),
                )),
            AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: opacity,
                child: Column(
                  children: const [
                    Text('Type:Owl'),
                    Text('Age:39'),
                    Text('Employment:None'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

///Container 动画
double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({Key? key}) : super(key: key);

  @override
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  late Color color;
  late double borderRadius;
  late double margin;

  @override
  initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                curve: Curves.easeInOutBack,
              ),
            ),
            ElevatedButton(
              child: const Text('change'),
              onPressed: () => {
                setState(() {
                  color = randomColor();
                  borderRadius = randomBorderRadius();
                  margin = randomMargin();
                }),
              },
            ),
          ],
        ),
      ),
    );
  }
}

///Animation，使用addListener
class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          //
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

///Animation2 Animation重复使用,使用AnimatedWidget
class LogoApp2 extends StatefulWidget {
  const LogoApp2({super.key});

  @override
  _LogoAppState2 createState() => _LogoAppState2();
}

class _LogoAppState2 extends State<LogoApp2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // animation = Tween<double>(begin: 0, end: 300).animate(controller)
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((status) {
        print("$status");
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(
      animation: animation,
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

///addStatusListener()
///AnimatedBuilder
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class LogoApp3 extends StatefulWidget {
  const LogoApp3({super.key});

  @override
  State<StatefulWidget> createState() => _LogoApp3State();
}

class _LogoApp3State extends State<LogoApp3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GrowTransition(child: const LogoWidget(), animation: animation);
  }
}

///Hero Widget.
class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key? key,
      required this.photo,
      required this.callback,
      required this.width})
      : super(key: key);

  final String photo;
  final VoidCallback callback;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: callback,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PhotoHero(
          photo: 'images/img.png',
          width: 300.0,
          callback: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo: 'images/img.png',
                    width: 100.0,
                    callback: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

///Hero 2
class PhotoHero2 extends StatelessWidget {
  const PhotoHero2({Key? key, required this.photo, required this.callback})
      : super(key: key);

  final String photo;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: callback,
        child: Image.asset(
          photo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({
    super.key,
    required this.maxRadias,
    required this.child,
  }) : clipRectSize = 2.0 * (maxRadias / math.sqrt2);

  final double maxRadias;
  final double clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: child,
        ),
      ),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {
  static double kMinRadius = 32.0;
  static double kMaxRadius = 128.0;
  static Interval opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  const RadialExpansionDemo({Key? key}) : super(key: key);

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(
      BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadias: kMaxRadius,
                    child: PhotoHero2(
                      photo: imageName,
                      callback: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadias: kMaxRadius,
          child: PhotoHero2(
            photo: imageName,
            callback: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondrayAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        child: _buildPage(context, imageName, description),
                      );
                    });
              }));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 5.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'images/img.png', 'Chair'),
            _buildHero(context, 'images/myimg.png', 'Binoculars'),
          ],
        ),
      ),
    );
  }
}

///Staggered

class StaggerAniamtion extends StatelessWidget {
  StaggerAniamtion({super.key, required this.controller})
      : opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.100, curve: Curves.ease))),
        width = Tween(begin: 50.0, end: 150.0).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.125, 0.250, curve: Curves.ease))),
        height = Tween(begin: 50.0, end: 150.0).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.250, 0.375, curve: Curves.ease))),
        padding = EdgeInsetsTween(
                begin: const EdgeInsets.only(bottom: 16.0),
                end: const EdgeInsets.only(bottom: 75.0))
            .animate(CurvedAnimation(
                parent: controller,
                curve: const Interval(0.250, 0.375, curve: Curves.ease))),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(4.0),
          end: BorderRadius.circular(75.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.375,
              0.500,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(
          begin: Colors.indigo[100],
          end: Colors.orange[400],
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.500,
              0.750,
              curve: Curves.ease,
            ),
          ),
        );

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius?> borderRadius;
  final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
              color: color.value,
              border: Border.all(color: Colors.indigo[300]!, width: 3.0),
              borderRadius: borderRadius.value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}

class StaggeredWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StaggredwidgetState();
  }
}

class StaggredwidgetState extends State<StaggeredWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(color: Colors.black.withOpacity(0.5))),
            child: StaggerAniamtion(controller: controller.view),
          ),
        ),
      ),
    );
  }
}

///shortcut actions
// class ShortCutWidgetDemo extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Shortcuts(shortcuts: {
//       LogicalKeySet(LogicalKeyboardKey.control,LogicalKeyboardKey.keyA):
//           SelectAllIntent();
//     }, child: Actions(
//       dispatcher: LogginActionDispatcher(),
//         actions: {
//       SelectALlIntent:SelectAllAction(model),
//     }, child: Builder(
//       builder: (context)=>TextButton(onPressed: Actions.handler(context, SelectAllIntent()), child: Text("Select All")),
//     )));
//   }
//
// }

class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      print("handled $event in $context");
    }
    return result;
  }
}
// class SelectAllIntent extends Action<SelectAllIntent>{
//   late final Model model;
//   @override
//   void invoke(SelectAllIntent intent) {
//     model.selectAll();
//   }
//
// }
///focus

///状态底部
class MyBottomSelct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyBottomSelctState();
  }
}

class _MyBottomSelctState extends State<MyBottomSelct> {
  int _select = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "HOME"),
        BottomNavigationBarItem(icon: Icon(Icons.safety_check), label: "My"),
      ],
      onTap: (select) {
        setState(() {
          _select = select;
          print("select $select");
        });
      },
    );
  }
}

///ChangeNotifier
///
class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get toalPrice => _items.length * 42;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}

class Item {}

class NoProviderTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider(
          create: (context) => CartModel(),
          child: Consumer<CartModel>(
            builder: (context, cart, child) {
              return Column(
                children: [
                  Text("Total price: ${cart.toalPrice}"),
                  IconButton(
                      onPressed: () {
                        cart.add(Item());
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .removeAll();
                      },
                      icon: const Icon(Icons.remove))
                ],
              );
            },
          ),
        ));
  }
}

///network
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
}

Future<Album> fetchAlbums() async {
  final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/albums/1"),
      headers: {
        HttpHeaders.authorizationHeader: 'token',
      });
  if (response.statusCode == 200) {
    final ablum = Album.fromJson(jsonDecode(response.body));
    print(ablum.title);
    return ablum;
  } else {
    throw Exception("fail to load album");
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album(this.userId, this.id, this.title);

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(json['userId'], json['id'], json['title']);
  }
}

class NetworkTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NetworkTestState();
  }
}

class NetworkTestState extends State<NetworkTestWidget> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hello")),
      body: Column(
        children: [
          IconButton(
            icon: Icon(Icons.abc),
            onPressed: () {},
          ),
          FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}

Future<http.Response> fetchPhotos(http.Client client) {
  return client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(json['albumId'], json['id'], json['title'], json['url'],
        json['thumbnailUrl']);
  }
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos2(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  // return parsePhotos(response.body);
  return compute(parsePhotos, response.body);
}

class IsolateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("isolate demo"),
        ),
        body: FutureBuilder<List<Photo>>(
            future: fetchPhotos2(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("error:${snapshot.error}");
              } else if (snapshot.hasData) {
                var photos = snapshot.data;
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: photos?.length,
                    itemBuilder: (context, index) {
                      return Image.network(photos![index].thumbnailUrl);
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

///post
Future<Album> createAlbum(String title) async {
  final response =
      await http.post(Uri.parse("https://jsonplaceholder.typicode.com/albums"),
          headers: <String, String>{
            'Content-Type': "application/json;charset=UTF-8",
          },
          body: jsonEncode(<String, String>{
            'title': title,
          }));
  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("fail to create");
  }
}

class PostTextWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PostTestWidgetState();
  }
}

class PostTestWidgetState extends State<PostTextWidget> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("post")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter Title',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureAlbum = createAlbum(_controller.text);
                });
              },
              child: Text("Create Data")),
          FutureBuilder<Album>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
            future: _futureAlbum,
          )
        ],
      ),
    );
  }
}

///Socket StreamBuilder

final channel =
    WebSocketChannel.connect(Uri.parse("wss://echo.websocket.events"));

class SocketTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SocketTestState();
  }
}

class SocketTestState extends State<SocketTestWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("socket")),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "输入发送的内容："),
          ),
          ElevatedButton(
              onPressed: () {
                channel.sink.add(_controller.text);
              },
              child: Text("发送")),
          StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                //没次收到消息都rebuild
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}

///sqlite
///
class Dog {
  final int id;
  final String name;
  final int age;

  Dog(this.id, this.name, this.age);

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "age": age};
  }

  @override
  String toString() {
    return "Dog {id:$id,name:$name,age:$age}";
  }
}

void testsq() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT,age INTEGER)',
      );
    },
    version: 1,
  );

  ///insert
  Future<void> insertDog(Dog dog) async {
    final db = await database;
    await db.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  var fido = Dog(1, 'Fido', 2);
  await insertDog(fido);

  ///query
  Future<List<Dog>> dogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (index) {
      return Dog(maps[index]['id'], maps[index]['name'], maps[index]['age']);
    });
  }

  ///update
  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update('dogs', dog.toMap(), where: 'id=?', whereArgs: [dog.id]);
  }

  fido = Dog(fido.id, fido.name, fido.age + 7);
  await updateDog(fido);

  ///delete
  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete('dogs', where: "id = ?", whereArgs: [id]);
  }

  await deleteDog(fido.id);
}

///sqlite和文件读写、SP放一起
class SqliteTestWidget extends StatefulWidget {
  final FileTest fileTest;

  const SqliteTestWidget({super.key, required this.fileTest});

  @override
  State<StatefulWidget> createState() {
    return SqliteTestState();
  }
}

class SqliteTestState extends State<SqliteTestWidget> {
  int _counter = 0;
  int _countersp = 0;

  @override
  void initState() {
    super.initState();
    widget.fileTest.readCounter().then((value) => {_counter = value});
  }

  ///SharedPreference
  Future<int> spread() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt("counter") ?? 0;
    return counter;
  }

  Future<void> spwrite() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = await spread();
    counter++;
    prefs.setInt("counter", counter);
    setState(() {
      _countersp = counter;
    });
  }

  void spremove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据库的操作"),
      ),
      body: Column(
        children: [
          Text("sqlite tapped $_counter times"),
          ElevatedButton(
              onPressed: () {
                testsq();
              },
              child: Text("点击操作sqlite")),
          Text("File数据 tapped $_counter times"),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                  widget.fileTest.writeCounter(_counter);
                });
              },
              child: Text("点击操作文件")),
          Text("Sp数据 tapped $_countersp times"),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  spwrite();
                });
              },
              child: Text("点击操作SP")),
        ],
      ),
    );
  }
}

///文件访问
///
class FileTest {
  Future<String> get _localPath async {
    final dire = await getApplicationDocumentsDirectory();
    return dire.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/counter.txt");
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
}

///VideoPlayer
class VideoPlayerTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoPlayerTestState();
  }
}

class VideoPlayerTestState extends State<VideoPlayerTestWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://imgqa.uni.changan.com.cn/uni-stars-manager/apk/4.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videoplayer"),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}

///Camera
///
///
class CameraOuterWidget extends StatelessWidget {
  const CameraOuterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "照相测试", home: CameraTestWidget());
  }
}

class CameraTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CameraTestWidgetState();
  }
}

late CameraDescription cameraDescription;

class CameraTestWidgetState extends State<CameraTestWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<void> getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameraDescription, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照"),
      ),
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!mounted) {
              print("camera eerror");
              return;
            }
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("照片"),
                ),
                body: Image.file(File(image.path)),
              );
            }));
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
