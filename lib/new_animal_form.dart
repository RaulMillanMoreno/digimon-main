import 'package:flutter/material.dart';
import 'package:digimon/animal_model.dart';

class AddAnimalFormPage extends StatefulWidget {
  const AddAnimalFormPage({super.key});

  @override
  _AddAnimalFormPageState createState() => _AddAnimalFormPageState();
}

class _AddAnimalFormPageState extends State<AddAnimalFormPage> {
  TextEditingController nameController = TextEditingController();

  /// Función para validar si un animal existe usando `Animal.getImageUrl`
  Future<bool> isValidAnimal(String name) async {
    final animal = Animal(name);
    try {
      await animal.getImageUrl(); // Llama al método para obtener los datos del animal
      return animal.imageUrl != null; // Si `imageUrl` no es nulo, el animal existe
    } catch (e) {
      return false; // Si ocurre un error, asumimos que el animal no existe
    }
  }

  /// Función para enviar el formulario
  void submitPup(BuildContext context) async {
    final name = nameController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the Animal name'),
      ));
      return;
    }

    try {
      final isValid = await isValidAnimal(name);

      if (isValid) {
        var newAnimal = Animal(name);
        await newAnimal.getImageUrl(); // Llama a getImageUrl para cargar los datos del animal
        Navigator.of(context).pop(newAnimal); // Devuelve el objeto completo
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Animal not recognized in the system'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Error checking the animal: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new animal'),
        backgroundColor: const Color(0xFF0B479E),
      ),
      body: Container(
        color: const Color(0xFFABCAED),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(
                      decoration: TextDecoration.none, color: Colors.black), // le he cambiado el color para que al escribir se ponga de color negro
                  decoration: const InputDecoration(
                    labelText: 'Animal Name',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => submitPup(context),
                      child: const Text('Submit Animal'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
