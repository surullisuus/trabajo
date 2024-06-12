import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_services.dart';

class EditProductForm extends StatefulWidget {
  final Map<String, dynamic> productToEdit;
  final String idLista; // Añadido el parámetro idLista

  const EditProductForm({Key? key, required this.productToEdit, required this.idLista}) : super(key: key);

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _productController = TextEditingController();
  String? _selectedSite;
  List<String> _sites = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _productController.text = widget.productToEdit['producto'];
    _selectedSite = widget.productToEdit['sitio'];
    _loadSites();
  }

  // Función para cargar los sitios desde Firebase
  void _loadSites() async {
    List<String> sitios = await readData();
    setState(() {
      _sites = sitios;
      _loading = false; // Indicar que se han cargado los datos
    });
  }

  void _saveProduct() async {
    // Verifica si el nombre del producto y el sitio están seleccionados
    if (_productController.text.isNotEmpty && _selectedSite != null) {
      // Actualiza los datos en Firestore
      await FirebaseFirestore.instance
          .collection('Listas')
          .doc(widget.idLista) // Usa idLista para especificar la lista
          .collection('Productos')
          .doc(widget.productToEdit['id'])
          .update({
        'producto': _productController.text,
        'sitio': _selectedSite,
      });

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Producto actualizado exitosamente'),
      ));

      // Cierra el modal de edición
      Navigator.pop(context);
    } else {
      // Si el nombre del producto o el sitio no están seleccionados, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, ingrese un nombre de producto y seleccione un sitio'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _loading
          ? CircularProgressIndicator() // Mostrar indicador de carga mientras se cargan los sitios
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _productController,
                  decoration: InputDecoration(
                    labelText: 'Ingrese el nombre del producto',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  menuMaxHeight: 150,
                  value: _selectedSite,
                  hint: Text('Seleccionar sitio...'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSite = newValue;
                    });
                  },
                  items: _sites.map((String site) {
                    return DropdownMenuItem<String>(
                      value: site,
                      child: Text(site),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _saveProduct,
                      child: Text('Guardar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
