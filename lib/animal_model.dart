// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Animal {
  final String name;
  String? imageUrl;
  String? apiname;
  String? infoAnimal;
  int rating = 10; // Calificación por defecto del animal.

  Animal(this.name);
  Future getDataAPI() async { // Método que obtiene datos del animal desde la API.    
    if (imageUrl != null) {
      return;
    }
    HttpClient http = HttpClient(); // Cliente HTTP para realizar solicitudes.
    try {
      apiname = name.toLowerCase();
      var uri = Uri.https('api.animality.xyz', '/all/$apiname'); // Construye la URI para realizar la solicitud a la API.      
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join(); 
      var data = json.decode(responseBody);  
      imageUrl = data["image"]; // Asigna la URL de la imagen desde el JSON.
      infoAnimal = data["fact"]; // Asigna un hecho adicional sobre el animal desde el JSON.
    } catch (exception) {
      //print(exception);
    }
  }
}
