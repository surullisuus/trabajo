import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabajo/Pages/AgregarSitio.dart';

import 'firebase_services.dart';

class NewProductForm extends StatefulWidget {
  @override
  _NewProductFormState createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  final selectedProductoController= TextEditingController();
  final _textController = TextEditingController();
  String? _selectedValue;
  List<String> _sites = [];
  @override
  void initState() {
    super.initState();
    _loadSites(); // Llama a la función para cargar los sitios al iniciar el estado
  }

  // Función para cargar los sitios desde Firebase
  void _loadSites() async {
    List<String> sitios = await readData();
    setState(() {
      _sites = sitios;
    });
  }

  void _saveSelectedValue() async {
    if (_selectedValue == null || _textController.text.isEmpty) {
      // Opcional: Muestra un mensaje de error si faltan valores
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select an item and enter text'),
      ));
      return;
    }

    String textFieldValue = _textController.text;

    await FirebaseFirestore.instance.collection('Listas').add({
      'producto': _selectedValue,
      'sitio': textFieldValue,
    });

    // Opcional: Limpia los campos después de guardar
    setState(() {
      _selectedValue = null;
      _textController.clear();
    });

    // Opcional: Muestra un mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Values saved successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _textController ,
            decoration: InputDecoration(
              labelText: 'Ingrese el nombre del producto',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  menuMaxHeight: 150,
                  value: _selectedValue,
                  hint: Text('Seleccionar sitio...'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
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
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: Text('Nuevo Sitio')),
                      body: NewSitioForm(),
                    ),
                  );
                },
                child: Text('+'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _saveSelectedValue,
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
