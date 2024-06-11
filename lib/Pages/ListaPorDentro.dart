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
                headingRowColor: MaterialStateProperty.all(Colors.purple[100]), // Color del encabezado
                dataRowColor: MaterialStateProperty.all(Colors.purple[50]), // Color de las filas
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Producto',
                      style: TextStyle(
                        fontSize: 18, // Tamaño de letra
                        fontWeight: FontWeight.bold, // Negrita
                        color: Colors.purple, // Color del texto del encabezado
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Sitio',
                      style: TextStyle(
                        fontSize: 18, // Tamaño de letra
                        fontWeight: FontWeight.bold, // Negrita
                        color: Colors.purple, // Color del texto del encabezado
                      ),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        'Arroz',
                        style: TextStyle(
                          fontSize: 16, // Tamaño de letra
                          fontWeight: FontWeight.normal, // Peso normal
                          color: Colors.purple[900], // Color del texto de la celda
                        ),
                      )),
                      DataCell(Text(
                        'ARA',
                        style: TextStyle(
                          fontSize: 16, // Tamaño de letra
                          fontWeight: FontWeight.normal, // Peso normal
                          color: Colors.purple[900], // Color del texto de la celda
                        ),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        'Jabón',
                        style: TextStyle(
                          fontSize: 16, // Tamaño de letra
                          fontWeight: FontWeight.normal, // Peso normal
                          color: Colors.purple[900], // Color del texto de la celda
                        ),
                      )),
                      DataCell(Text(
                        'D1',
                        style: TextStyle(
                          fontSize: 16, // Tamaño de letra
                          fontWeight: FontWeight.normal, // Peso normal
                          color: Colors.purple[900], // Color del texto de la celda
                        ),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        'Tomate',
                        style: TextStyle(
                          fontSize: 16, // Tamaño de letra
                          fontWeight: FontWeight.normal, // Peso normal
                          color: Colors.purple[900], // Color del texto de la celda
                        ),
                      )),
                      DataCell(Text(
                        'Placita campesina',
                        style: TextStyle(
                          fontSize: 16, // Tamaño de letra
                          fontWeight: FontWeight.normal, // Peso normal
                          color: Colors.purple[900], // Color del texto de la celda
                        ),
                      )),
                    ],
                  ),
                ],
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
