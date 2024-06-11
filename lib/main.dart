import 'package:flutter/material.dart';

import 'Pages/ListaPorDentro.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaScreen(),
    );
  }
}

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  List<String> listas = ['Lista 1', 'Lista 2'];

  void duplicarLista() {
    setState(() {
      listas.addAll(listas);
    });
  }

  void navigateToList(BuildContext context, String listName) {
    if (listName == 'Lista 1') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Title')),
      );
    } else if (listName == 'Lista 2') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Title')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => navigateToList(context, listas[index]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        listas[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: duplicarLista,
              child: Text('duplicar lista'),
            ),
          ],
        ),
      ),
    );
  }
}
