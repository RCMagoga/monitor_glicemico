import 'package:flutter/material.dart';
import 'package:monitor_glicemico/views/telaCadastro.dart';
import 'package:monitor_glicemico/views/telaListagem.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ThemeData _tema = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      titleTextStyle: TextStyle(
        fontSize: 26,
        color: Colors.black,
      ),
    ),
  );

  // Controla a Tela selecionada
  int _telaSelecionada = 0;

  // Altera a tela selecionada
  void _onTap(index) {
    setState(() {
      _telaSelecionada = index;
    });
  }

  // Lista para navegar nas telas
  final List<Widget> _telas = [
    Telacadastro(),
    TelaListagem(),
  ];

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
        body: _telas[_telaSelecionada],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Cadastrar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bloodtype),
              label: 'Listagem',
            )
          ],
          currentIndex: _telaSelecionada,
          selectedItemColor: Colors.blue,
          iconSize: 40,
          onTap: _onTap,
          selectedFontSize: 22,
          unselectedFontSize: 18,
        ),
      ),
    );
  }
}
