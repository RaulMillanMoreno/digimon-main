import 'package:digimon/animal_model.dart';
import 'animal_detail_page.dart';
import 'package:flutter/material.dart';


class AnimalCard extends StatefulWidget {
  final Animal animal;

  const AnimalCard(this.animal, {super.key});

  @override
  _AnimalCardState createState() => _AnimalCardState(animal);
}

class _AnimalCardState extends State<AnimalCard> {
  Animal animal;
  String? renderUrl;

  _AnimalCardState(this.animal);

  @override
  void initState() {
    super.initState();
    renderAnimalPic(); // Carga la imagen del animal al iniciar.
  }

  Widget get animalImage { // Imagen del animal o un marcador de posición si la imagen aún no está disponible.
    var animalAvatar = Hero(
      tag: animal, // Animación de transición entre vistas.
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: 
          LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.black54, Colors.black, Color.fromARGB(255, 84, 110, 122)])
      ),
      alignment: Alignment.center,
      child: const Text(
        'ANIM', // Texto placeholder mientras se carga la imagen.
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: animalAvatar,
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000), // Duración de la transición.
    );

    return crossFade;
  }

  void renderAnimalPic() async {// Obtiene la imagen del animal desde la API.
    await animal.getDataAPI();
    if (mounted) { // Comprueba si el widget sigue en pantalla antes de actualizar.
      setState(() {
        renderUrl = animal.imageUrl;
      });
    }
  }

  Widget get animalCard {// Es la tarjeta que muestra el nombre y la calificación del animal.
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

  void showAnimalDetailPage() {// Sirve para navegar a la página de detalles del animal y actualiza la vista al regresar.
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AnimalDetailPage(animal)))
        .then((_) {
      setState(() {
        // Asegura que la tarjeta se reconstruya con los valores actualizados.
      });
    });
  }

  @override
  Widget build(BuildContext context) {// Es la construcción principal de la tarjeta.
    return InkWell(
      onTap: () => showAnimalDetailPage(), // Navega a la página de detalles al hacer clic.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              animalCard, // Contenido de la tarjeta.
              Positioned(top: 7.5, child: animalImage), // Imagen del animal.
            ],
          ),
        ),
      ),
    );
  }
}
