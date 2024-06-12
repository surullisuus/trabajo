import 'package:flutter/material.dart';
import 'firebase_services.dart'; // Cambiar el import según tu estructura de archivos

class NewSitioForm extends StatefulWidget {
  final Function(String) onSiteAdded;

  NewSitioForm({required this.onSiteAdded});

  @override
  _NewSitioFormState createState() => _NewSitioFormState();
}

class _NewSitioFormState extends State<NewSitioForm> {
  final siteNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: siteNameController,
            decoration: InputDecoration(
              labelText: 'Aquí el nombre del sitio',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  String newSiteName = siteNameController.text;
                  saveData(newSiteName);
                  widget.onSiteAdded(newSiteName);
                  Navigator.pop(context);
                  siteNameController.clear();
                },
                child: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  siteNameController.clear();
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
