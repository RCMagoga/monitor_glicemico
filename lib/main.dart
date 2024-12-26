import 'package:flutter/material.dart';
import 'package:monitor_glicemico/views/telaCadastro.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final ThemeData _tema = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      titleTextStyle: TextStyle(
        fontSize: 26,
        color: Colors.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Monitor Glicêmico",
      // Tema definido pela variavel "_tema" acima.
      theme: _tema,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Monitor Glicêmico"),
          centerTitle: true,
        ),
        body: Telacadastro(),
      ),
    );
  }
}
