import 'package:flutter/material.dart';
import 'package:monitor_glicemico/widgets/cardDados.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  final List<String> lista = [
    "Teste1",
    "Teste2",
    "Teste3",
    "Teste4",
    "Teste5",
    "Teste6",
  ];

  final Future<String> _espera =
      Future<String>.delayed(const Duration(seconds: 3), () => "Retorno");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _espera,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.white,
            ),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return CardDados();
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
