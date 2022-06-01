import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
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
                        return MaterialApp(
                          title: "Shopping App",
                          home: pls,
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
                    IconButton(
                        focusColor: Colors.blue,
                        onPressed: () {
                          print("ssss");
                        },
                        icon: const Icon(Icons.add)),
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
              ],
            )
          ],
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
        backgroundImage: AssetImage('images/pic.jpg'),
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
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        const Text('41', style: TextStyle(fontSize: 20)),
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
