import 'package:flutter/material.dart';
import 'dart:async';
import 'animal_model.dart';
import 'animal_list.dart'; 
import 'new_animal_form.dart';

void main() => runApp(const MyApp()); 

class MyApp extends StatelessWidget { // Pantalla principal.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The animals',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage( 
        title: 'The animals',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget { 
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Animal> initialAnimals = [Animal('cat'), Animal('dog'), Animal('bird')]; // Lista inicial de animales a mostrar.
  Future _showNewAnimalForm() async {// Abre el formulario para añadir un nuevo animal y actualizar la lista.    
    Animal? newAnimal = await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return const AddAnimalFormPage(); // Navega a la pantalla donde se agregar nuevos animales.
      },
    ));
    if (newAnimal != null) { // Verifica que el nuevo animal no sea nulo y lo agrega la lista a la lista.
      initialAnimals.add(newAnimal);
      setState(() {}); // Actualiza la interfaz.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.green)), 
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: <Widget>[ 
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton( // Botón para agregar un nuevo animal.
              icon: const Icon(Icons.add),
              color: Colors.green,
              onPressed: _showNewAnimalForm,// Muestra el formulario al presionarlo.
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 143, 157, 174),
        child: Center(
          child: AnimalList(initialAnimals), // Muestra la lista de los animales iniciales.
        ),
      ),
    );
  }
}
