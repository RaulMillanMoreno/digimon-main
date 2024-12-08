import 'package:flutter/material.dart';
import 'animal_model.dart';
import 'dart:async';


class AnimalDetailPage extends StatefulWidget {
  final Animal animal; // Representa el animal que se mostrará en la página de detalles.
  const AnimalDetailPage(this.animal, {super.key});

  @override
  _AnimalDetailPageState createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  final double animalAvarterSize = 150.0;
  double _sliderValue = 10.0; // Valor inicial del slider.

  Widget get addYourRating {// Sirve para mostrar el slider de calificación y el botón de envío.
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFF0B479E),
                  min: 0.0,
                  max: 10.0, // Rango del slider (0-10).
                  value: _sliderValue,
                  onChanged: (newRating) {// Actualiza el valor del slider al cambiar.
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  '${_sliderValue.toInt()}', // Muestra el valor actual del slider.
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                ),
              ),
            ],
          ),
        ),
        submitRatingButton, // Botón para enviar la calificación.
      ],
    );
  }

  void updateRating() {// Sirve para actualizar la calificación del animal.    
    if (_sliderValue < 4) {
      _ratingErrorDialog(); // Muestra un error si la calificación es menor a 4.
    } else {
      setState(() {
        widget.animal.rating = _sliderValue.toInt(); // Asigna el nuevo valor de calificación.
      });
    }
  }

  Future<void> _ratingErrorDialog() async { // Diálogo que se muestra si la calificación es demasiado baja.  
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!'),
          content: const Text("Come on! They're good!"),
          actions: <Widget>[
            TextButton(
              child: const Text('Try Again'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.animal.rating.toDouble(); // Inicializa el slider con la calificación actual del animal.
  }

  Widget get submitRatingButton {// Es el botón para enviar la calificación.    
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: const Text('Submit'),
    );
  }

  Widget get animalImage {// Muestra la imagen del animal en un contenedor con diseño circular.    
    return Hero(
      tag: widget.animal,
      child: Container(
        height: animalAvarterSize,
        width: animalAvarterSize,
        constraints: const BoxConstraints(),
        
        decoration: BoxDecoration(
          shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
              BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
              BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
            ],
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.animal.imageUrl ?? ""))
        ),  
      ),
    );
  }

  Widget get rating {// Muestra la calificación actual del animal.   
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Color.fromARGB(255, 255, 187, 0),
        ),
        Text('${widget.animal.rating}/10', style: const TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  Widget get animalProfile {// És el perfil del animal con nombre, imagen y calificación.    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 143, 157, 174),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          animalImage,
          Text(widget.animal.name, style: const TextStyle(color: Colors.black, fontSize: 32.0)),
          Text('${widget.animal.infoAnimal}', style: const TextStyle(color: Colors.black, fontSize: 20.0), textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.only(top: 20.0), 
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {// Genera la página de detalles del animal.    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 143, 157, 174),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(
          'Meet ${widget.animal.name}',
          style: const TextStyle(color: Colors.green),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context), // Acción para volver a la página anterior.
        ),
      ),
      body: ListView(
        children: <Widget>[
          animalProfile, // Perfil del animal.
          addYourRating, // Sección para calificar.
        ],
      ),
    );
  }
}
