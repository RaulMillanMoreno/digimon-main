import 'package:digimon/animal_model.dart';
import 'animal_detail_page.dart';
import 'package:flutter/material.dart';


class AnimalCard extends StatefulWidget {
  final Animal animal;

  const AnimalCard(this.animal, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AnimalCardState createState() => _AnimalCardState(animal);
}

class _AnimalCardState extends State<AnimalCard> {
  Animal animal;
  String? renderUrl;

  _AnimalCardState(this.animal);

  @override
  void initState() {
    super.initState();
    renderAnimalPic();
  }

  Widget get animalImage {
    var animalAvatar = Hero(
      tag: animal,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration:
            BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.black54, Colors.black, Color.fromARGB(255, 84, 110, 122)])),
      alignment: Alignment.center,
      child: const Text(
        'ANIM',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: animalAvatar,
      // ignore: unnecessary_null_comparison
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderAnimalPic() async {
    await animal.getDataUrl();
    if (mounted) {
      setState(() {
        renderUrl = animal.imageUrl;
      });
    }
  }

  // Ya que 'rating' es parte de 'Animal', cuando cambia, la vista debe actualizarse. Esto ya se maneja mediante 'setState' en el estado de 'AnimalCard'.
  Widget get animalCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 290,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: const Color(0xFFF8F8F8),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  widget.animal.name,
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 27.0),
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Color.fromARGB(255, 255, 187, 0)),
                    Text(': ${widget.animal.rating}/10', style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

    void showAnimalDetailPage() {//esto se canvio para lo del push(para que se vea el numerito de las estrellas de forma correcta)
    Navigator.of(context)
        .push(
            MaterialPageRoute(builder: (context) => AnimalDetailPage(animal)))
        .then((_) {
      setState(() {
        // Esto asegura que la tarjeta se reconstruya con los nuevos valores.
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showAnimalDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              animalCard,
              Positioned(top: 7.5, child: animalImage),
            ],
          ),
        ),
      ),
    );
  }
}
