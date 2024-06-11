import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_services.dart';

class NewSitioForm extends StatefulWidget {
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
                  saveData(siteNameController.text);
                  Navigator.pop(context);
                  siteNameController.clear();
                },
                child: Text('Guardar'),
              ),
              ElevatedButton(
                onPressed: () {
                  siteNameController.clear();
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}