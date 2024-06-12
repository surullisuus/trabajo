import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DuplicarListaForm extends StatefulWidget {
  final String listaActual;
  final String? idListaSeleccionada; // Nuevo campo para el ID de la lista seleccionada

  DuplicarListaForm({required this.listaActual, this.idListaSeleccionada});

  @override
  _DuplicarListaFormState createState() => _DuplicarListaFormState();
}

class _DuplicarListaFormState extends State<DuplicarListaForm> {
  String nuevoNombreLista = '';
  String? listaSeleccionada;
  List<String> listasFromDatabase = [];
  bool isButtonEnabled = false; // Variable para habilitar/deshabilitar el botón de duplicar

  @override
  void initState() {
    super.initState();
    cargarListasDesdeBaseDeDatos();
  }

  void cargarListasDesdeBaseDeDatos() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Listas').get(); // Cambiar a 'Listas'
      List<String> nombresListas = [];
      querySnapshot.docs.forEach((doc) {
        nombresListas.add(doc['nombre']);
      });
      setState(() {
        listasFromDatabase = nombresListas;
      });
    } catch (e) {
      print('Error al cargar las listas desde la base de datos: $e');
      // Manejar el error según sea necesario
    }
  }

  void duplicarLista(String? listaSeleccionada, String nuevoNombreLista) async {
    try {
      if (listaSeleccionada != null) {
        // Generar un ID único para la nueva lista
        String nuevaListaId = FirebaseFirestore.instance.collection('Listas').doc().id; // Cambiar a 'Listas'

        // Obtener la fecha y hora actual del sistema
        Timestamp fechaRegistro = Timestamp.now();

        // Crear un nuevo documento para la nueva lista con el ID generado y la fecha de registro
        await FirebaseFirestore.instance.collection('Listas').doc(nuevaListaId).set({ // Cambiar a 'Listas'
          'id': nuevaListaId,
          'nombre': nuevoNombreLista,
          'fechaRegistro': fechaRegistro, // Agregar el campo FechaRegistro
          // Otros campos necesarios para tu aplicación
        });

        // Opcional: Puedes imprimir un mensaje de éxito
        print('Nueva lista creada en Firestore: $nuevoNombreLista con ID: $nuevaListaId');

        // Opcional: Puedes cerrar el diálogo y pasar el nombre de la lista creada
        Navigator.pop(context, nuevoNombreLista);
      } else {
        // Si listaSeleccionada es null, significa que se está creando una lista completamente nueva
        // Aquí puedes implementar la lógica para crear una lista nueva sin duplicar
      }
    } catch (e) {
      print('Error al crear la nueva lista: $e');
      // Manejar el error según sea necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Duplicar Lista'),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Ajustar el ancho del contenido
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: listaSeleccionada,
                onChanged: (String? newValue) {
                  setState(() {
                    listaSeleccionada = newValue;
                    // Verificar si la selección es válida para habilitar el botón de duplicar
                    isButtonEnabled = true; // Siempre habilitar el botón de duplicar cuando hay un cambio en el dropdown
                  });
                },
                items: [...listasFromDatabase, null].map((String? lista) {
                  return DropdownMenuItem<String>(
                    value: lista,
                    child: Text(lista ?? 'Crear nueva lista'),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Selecciona la lista a duplicar o deja vacío para crear nueva',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    nuevoNombreLista = value;
                    // Verificar si la entrada del nombre de lista es válida para habilitar el botón de duplicar
                    isButtonEnabled = listaSeleccionada != null || nuevoNombreLista.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nombre de la nueva lista *',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: isButtonEnabled
              ? () {
                  duplicarLista(widget.idListaSeleccionada, nuevoNombreLista); // Pasa el ID de la lista seleccionada
                }
              : null, // Deshabilitar el botón si no se cumple la condición
          child: Text('Duplicar'),
        ),
      ],
    );
  }
}
