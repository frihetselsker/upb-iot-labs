import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Products()));
}

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('CyberMarket', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                "Welcome to Anonymous Store!",
                style: TextStyle(color: Colors.red),
              ),
            ),
            Expanded(
              child: GridView.extent(
                primary: false,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 25,
                mainAxisSpacing: 50,
                maxCrossAxisExtent: 450.0,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                      'https://m.media-amazon.com/images/I/81+HS23yFvL._UY1000_.jpg',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                      ),
                      Text("The Circle")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                      'https://m.media-amazon.com/images/I/81wdgapPaPL._AC_SL1500_.jpg',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                      ),
                      Text("The Square")
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 255, 255),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text('Log in'),),
                ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 255, 255),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text('Register'),),
                
            ],),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Screen'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(hintText: 'TextField'),
                ),
              ),
              Image.network(
                'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Stack(
                children: [
                  Container(
                    width: 300,
                    height: 200,
                    color: Colors.yellow,
                    child: Center(child: Text('Top Widget')),
                  ),
                  Positioned(
                    top: 10,
                    left: 50,
                    child: Container(
                      width: 80,
                      height: 40,
                      color: Colors.blue,
                      child: Center(child: Text('Left Widget')),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: Container(
                      width: 80,
                      height: 40,
                      color: Colors.red,
                      child: Center(child: Text('Right Widget')),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.brown,
                    child: Center(child: Text('Row1')),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.brown,
                    child: Center(child: Text('Row2')),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.brown,
                    child: Center(child: Text('Row3')),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}