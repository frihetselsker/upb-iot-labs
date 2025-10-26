import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
    );
  }

  print('Firebase initialized: ${Firebase.apps.map((a) => a.name).toList()}');

  runApp(const MaterialApp(home: Products()));
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}
class _ProductsState extends State<Products> {
  User? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? u) {
      setState(() {
        user = u;
      });
    });
  }

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
            if (user == null) ...[
              const SizedBox(height: 10),
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
              ],)]
              else ...[
                const SizedBox(height: 10),
                Column (children: [Text("Hello, ${user!.displayName}!")],),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                }, child: const Text('Log out'))
              ],
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  ElevatedButton(style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 255, 255),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProposalsPage(),
                     ),
                    );
                  },
                  child: const Text('Show proposals'),),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim(),);
      Navigator.pop(context);
    }
    catch(e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed : $e"))
    );
  }
  }

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
                          controller: emailController,
                          decoration: InputDecoration(hintText: 'Email address'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(hintText: 'Password'), 
                          obscureText: true,
                        ),
                      )
                    ],
                 )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
class _RegistrationPageState extends State<RegistrationPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _register() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
      await credential.user!.updateDisplayName(
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}'
      );
      await credential.user!.reload();
      Navigator.pop(context);
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration failed: $e")));
    }
  }


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
                          controller: firstNameController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Last Name'), 
                          obscureText: true,
                          controller: lastNameController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Email address'),
                          controller: emailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Password'), 
                          controller: passwordController,
                          obscureText: true,
                        ),
                      )
                    ],
                 )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProposalsPage extends StatefulWidget {
  const ProposalsPage({super.key});

  @override
  _ProposalsPageState createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
  late Stream<QuerySnapshot> _proposalsStream;

  @override
  void initState() {
    super.initState();
    _proposalsStream = FirebaseFirestore.instance.collection('proposals').snapshots();
    _testFetch();
  }
   Future<void> _testFetch() async {
    try {
      final snap = await FirebaseFirestore.instance.collection('proposals').get();
      print('testFetch: got ${snap.docs.length} docs');
      for (var d in snap.docs) print('doc ${d.id}: ${d.data()}');
    } catch (e, st) {
      print('Error fetching proposals: $e\n$st');
      if (e is FirebaseException) print('code=${e.code}, message=${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Proposals Page', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.indigo[100],
        child: StreamBuilder<QuerySnapshot>(
                stream: _proposalsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) return const Center(child: Text('No proposals found'));
                  return ListView(
                    children: docs.map((d) {
                      final data = d.data()! as Map<String, dynamic>;
                      final title = data['title'] as String? ?? 'No title';
                      final desc = data['description'] as String? ?? '';
                      //final image = (data['image'] ?? data['imageUrl']) as String?;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.image, size: 40, color: Colors.indigo),
                                  ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(title,
                                          style: const TextStyle(
                                              fontSize: 18)),
                                      const SizedBox(height: 6),
                                      Text(desc, maxLines: 3, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ));
                    }).toList(),
                  );
                },
              ),
      ),
    );
  }
}