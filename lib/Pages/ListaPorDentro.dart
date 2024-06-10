import 'package:flutter/material.dart';

import 'AñadirProducto.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Arroz')),
                      DataCell(Text('ARA')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Jabón')),
                      DataCell(Text('D1')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Tomate')),
                      DataCell(Text('Placita campesina')),
                    ],
                  ),
                  // Agrega más filas aquí si es necesario
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context)=>
              Scaffold(
                appBar: AppBar(title: Text('Nuevo Producto')),
                body: NewProductForm(),
              )
          );
        },
        tooltip: 'Añadir',
        child: const Icon(Icons.add),
      ),
    );
  }
}

