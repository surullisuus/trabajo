import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AgregarSitio.dart';
import 'firebase_services.dart';


class NewProductForm extends StatefulWidget {
  final String idLista;

  NewProductForm({required this.idLista});

  @override
  _NewProductFormState createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  final _productController = TextEditingController();
  String? _selectedSite;
  List<String> _sites = [];

  @override
  void initState() {
    super.initState();
    _loadSites();
  }

  void _loadSites() async {
    List<String> sitios = await readData();
    setState(() {
      _sites = sitios;
    });
  }

  void _addSiteToList(String newSiteName) {
    setState(() {
      _sites.add(newSiteName);
    });
  }

  void _saveProduct() async {
    if (_productController.text.isEmpty || _selectedSite == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Por favor, ingrese un nombre de producto y seleccione un sitio'),
      ));
      return;
    }

    String productName = _productController.text;
    String siteName = _selectedSite!;
    String idLista = widget.idLista;

    await FirebaseFirestore.instance.collection('Listas').doc(idLista).collection('Productos').add({
      'producto': productName,
      'sitio': siteName,
    });

    setState(() {
      _productController.clear();
      _selectedSite = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Producto guardado exitosamente'),
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _productController,
            decoration: const InputDecoration(
              labelText: 'Ingrese el nombre del producto',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
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
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: Text('Nuevo Sitio')),
                      body: NewSitioForm(
                        onSiteAdded: _addSiteToList,
                      ),
                    ),
                  );
                },
                child: Text('+'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
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
