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
        title: Center(child: const Text('NASA Display', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.indigo,
      ),
      body: Container(color: Colors.indigo[100],
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                "Welcome to the website!",
                style: TextStyle(color: Colors.red, fontSize: 32),
              ),
            ),
            Row(
                spacing: 100.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/e/e9/Apollo_6_launch.jpg',
                        width: 300,
                        height: 400,
                        fit: BoxFit.cover,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.indigo
                          ),
                          child: const Text("Apollo 6", style:TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/4/4a/SpaceX_Starship_ignition_during_IFT-5.jpg',
                        width: 300,
                        height: 400,
                        fit: BoxFit.cover,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.indigo
                          ),
                          child: const Text("Starship", style:TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                ],
              ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
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
                      builder: (context) => const RegistrationPage(),
                    ),
                  );
                },
                child: const Text('Register'),),
                
            ],),
          ],
        ),
      ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login Page', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.indigo[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all()
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Email address'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Password'), 
                          obscureText: true,
                        ),
                      )
                    ],
                 )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Register Page', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.indigo[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all()
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'First Name'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Last Name'), 
                          obscureText: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Email address'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Password'), 
                          obscureText: true,
                        ),
                      )
                    ],
                 )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}