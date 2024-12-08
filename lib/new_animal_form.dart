import 'package:flutter/material.dart';
import 'package:digimon/animal_model.dart';

class AddAnimalFormPage extends StatefulWidget {
  const AddAnimalFormPage({super.key});

  @override
  _AddAnimalFormPageState createState() => _AddAnimalFormPageState();
}

class _AddAnimalFormPageState extends State<AddAnimalFormPage> {
  TextEditingController nameController = TextEditingController();
  
  Future<bool> isValidAnimal(String name) async {// Sirve para validar si un animal existe usando Animal.getImageUrl
    final animal = Animal(name);
    try {
      await animal.getDataAPI();  // Llama al método para obtener los datos del animal
      return animal.imageUrl != null;  // Si imageUrl no es nulo, el animal existe
    } catch (e) {
      return false;  // Si ocurre un error, asumimos que el animal no existe
    }
  }

  void submitPup(BuildContext context) async {// Sirve para enviar el formulario
    final name = nameController.text;
    if (name.isEmpty) {  // Si el campo está vacío
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the Animal name'),
      ));
      return;
    }

    try {
      final isValid = await isValidAnimal(name);  // Verifica si el animal es válido

      if (isValid) {
        var newAnimal = Animal(name);  // Crea un nuevo objeto Animal
        await newAnimal.getDataAPI();
        Navigator.of(context).pop(newAnimal);// Devuelve el objeto Animal al anterior nivel de la navegación
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Animal not recognized in the system'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(// Muestra un mensaje de error si ocurre una excepción
        backgroundColor: Colors.redAccent,
        content: Text('Error checking the animal: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  // Barra de navegación superior
        title: const Text('Add a new animal', style: const TextStyle(color: Colors.green)),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton( // Botón para retroceder a la pantalla anterior
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 143, 157, 174),
        child: Padding( 
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(  // Es un campo de texto que sirve para ingresar el nombre del animal
                  controller: nameController,
                  style: const TextStyle(
                      decoration: TextDecoration.none, color: Colors.black),
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
                    return ElevatedButton(  // Es un botón que sirve para enviar el formulario
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
