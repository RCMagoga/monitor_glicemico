import 'package:flutter/material.dart';
import 'package:monitor_glicemico/views/tela_cadastro.dart';
import 'package:monitor_glicemico/views/tela_listagem.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // Configura um tema padrão para o app
  final ThemeData temaPadrao = ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Monitor de Glicemia",
      theme: temaPadrao,
      home: Scaffold(
        body: Center(
          child: TelaCadastro(),
        ),
      ),
    );
  }
}
