import 'package:digimon/digimon_model.dart';
import 'package:flutter/material.dart';


class AddAnimalFormPage extends StatefulWidget {
  const AddAnimalFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddAnimalFormPageState createState() => _AddAnimalFormPageState();
}

class _AddAnimalFormPageState extends State<AddAnimalFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the Animal name'),
      ));
    } else {
      var newAnimal = Animal(nameController.text);
      Navigator.of(context).pop(newAnimal);
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
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(decoration: TextDecoration.none, color: Colors.black),// le he cambiado el color para que al escribir se ponga de color negro
                onChanged: (v) => nameController.text = v,
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
          ]),
        ),
      ),
    );
  }
}
