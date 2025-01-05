import 'package:flutter/material.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/widgets/tela_listagem/slidable_card.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: FutureBuilder(
        future: Db().buscarColetas(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return SlidableCard(snapshot.data!);
          } else if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasData) {
            return Center(
              child: Text(
                "Nenhum dado encontrado!",
                style: TextStyle(fontSize: 22),
              ),
            );
          } else if (!snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text(
                "Erro ao buscar dados!",
                style: TextStyle(fontSize: 22),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
