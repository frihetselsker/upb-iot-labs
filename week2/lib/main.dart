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

  // print('Firebase initialized: ${Firebase.apps.map((a) => a.name).toList()}');

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
  }

  Future<void> _deleteDoc(String docId) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm delete'),
        content: const Text('Are you sure you want to delete this proposal?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await FirebaseFirestore.instance.collection('proposals').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  void _openEditPage({String? docId, Map<String, dynamic>? data}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProposalEditPage(docId: docId, data: data),
      ),
    );
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
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _proposalsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) return const Center(child: Text('No proposals found'));
                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    children: docs.map((d) {
                      final data = d.data()! as Map<String, dynamic>;
                      final title = data['title'] as String? ?? 'No title';
                      final desc = data['description'] as String? ?? '';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Text(title, style: const TextStyle(fontSize: 18)),
                                      const SizedBox(height: 6),
                                      Text(desc, maxLines: 3, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () => _openEditPage(docId: d.id, data: data),
                                      icon: const Icon(Icons.edit, color: Colors.indigo),
                                      tooltip: 'Edit',
                                    ),
                                    IconButton(
                                      onPressed: () => _deleteDoc(d.id),
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      tooltip: 'Delete',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Proposal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 255, 255),
                ),
                onPressed: () => _openEditPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProposalEditPage extends StatefulWidget {
  final String? docId;
  final Map<String, dynamic>? data;

  const ProposalEditPage({super.key, this.docId, this.data});

  @override
  State<ProposalEditPage> createState() => _ProposalEditPageState();
}

class _ProposalEditPageState extends State<ProposalEditPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.data?['title'] as String? ?? '');
    _descController = TextEditingController(text: widget.data?['description'] as String? ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title is required')));
      return;
    }
    setState(() => _saving = true);
    try {
      final col = FirebaseFirestore.instance.collection('proposals');
      if (widget.docId == null) {
        await col.add({'title': title, 'description': desc, 'createdAt': FieldValue.serverTimestamp()});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added')));
      } else {
        await col.doc(widget.docId).update({'title': title, 'description': desc, 'updatedAt': FieldValue.serverTimestamp()});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated')));
      }
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save failed: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _deleteIfEditing() async {
    if (widget.docId == null) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm delete'),
        content: const Text('Delete this proposal?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await FirebaseFirestore.instance.collection('proposals').doc(widget.docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.docId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Proposal' : 'New Proposal'),
        backgroundColor: Colors.indigo,
        actions: [
          if (isEditing)
            IconButton(
              onPressed: _deleteIfEditing,
              icon: const Icon(Icons.delete),
            )
        ],
      ),
      body: Container(
        color: Colors.indigo[100],
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _descController,
                      decoration: const InputDecoration(labelText: 'Description'),
                      maxLines: 6,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _saving ? null : () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _saving ? null : _save,
                          child: _saving ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}