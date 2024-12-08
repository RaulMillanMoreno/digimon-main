import 'package:digimon/animal_card.dart';
import 'package:flutter/material.dart'; 
import 'animal_model.dart';

class AnimalList extends StatelessWidget {
  final List<Animal> animals; // Lista de animales a mostrar.
  const AnimalList(this.animals, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context); 
  }

  ListView _buildList(context) { // Construye una lista con los animales que hemos teniamos en el main.   
    return ListView.builder(
      itemCount: animals.length, // Número de elementos en la lista.
      itemBuilder: (context, int) {
        return AnimalCard(animals[int]); // Para cada índice, crea una tarjeta con información del animal.        
      },
    );
  }
}
