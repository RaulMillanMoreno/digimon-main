// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Animal {
  final String name;
  String? imageUrl;
  String? apiname;
  String? levelAnimal;

  int rating = 10;

  Animal(this.name);

  Future getDataUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      apiname = name.toLowerCase();

      var uri = Uri.https('api.animality.xyz', '/all/$apiname');//se cambio esto
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      var data = json.decode(responseBody);// se ha quitado lo de la lista y el [0] que tenia el data, porque lo que tenemos son diversos jason no listas.
      imageUrl = data["image"];
      levelAnimal = data["fact"];
    } catch (exception) {
      //print(exception);
    }
  }
}
