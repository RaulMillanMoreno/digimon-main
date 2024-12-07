import 'package:digimon/animal_card.dart';
import 'package:flutter/material.dart';
import 'animal_model.dart';

class AnimalList extends StatelessWidget {
  final List<Animal> animals;
  const AnimalList(this.animals, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: animals.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return AnimalCard(animals[int]);
      },
    );
  }
}
