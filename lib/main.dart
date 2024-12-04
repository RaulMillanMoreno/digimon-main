import 'package:flutter/material.dart';
import 'dart:async';
import 'digimon_model.dart';
import 'digimon_list.dart';
import 'new_digimon_form.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The animals',//canbias el nombre
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(//canbias el nombre
        title: 'The animals',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Animal> initialDigimons = [Animal('cat'), Animal('dog'), Animal('bird')];
  Future _showNewDigimonForm() async {//para que no pete al crear uno nuevo, ponemos el ? en el digimon y ponemos la inicializacion en un if para asegurar que siempre iniciara un animal real. si no peta
    Animal? newDigimon = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddAnimalFormPage();
    }));
    //print(newDigimon);
    if (newDigimon != null){
      initialDigimons.add(newDigimon);
      setState(() {});
    }    
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0B479E),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewDigimonForm,
          ),
        ],
      ),
      body: Container(
          color: const Color.fromARGB(255, 0, 42, 90),
          child: Center(
            child: DigimonList(initialDigimons),
          )),
    );
  }
}
