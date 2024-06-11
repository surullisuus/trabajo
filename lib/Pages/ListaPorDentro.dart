import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AñadirProducto.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Función para cargar los productos desde Firebase
  void _loadProducts() async {
    FirebaseFirestore.instance.collection('Listas').snapshots().listen((snapshot) {
      setState(() {
        _products = snapshot.docs.map((doc) => doc.data()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Producto',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Sitio',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: _products.map((product) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(product['producto'] ?? '')),
                      DataCell(Text(product['sitio'] ?? '')),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text('Nuevo Producto')),
              body: NewProductForm(),
            ),
          );
        },
        tooltip: 'Añadir',
        child: const Icon(Icons.add),
      ),
    );
  }
}