import 'package:flutter/material.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/widgets/tela_listagem/slidable_card.dart';
import 'package:provider/provider.dart';

/*
  Tela criada para o usuário ver a lista de dados cadastradas
*/
class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Db>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Lista"),
        ),
        body: FutureBuilder(
          future: Db().buscarColetas(),
          builder: (context, snapshot) {
            // Carrega os dados na tela quando forem recuperados do banco de dados
            if (snapshot.hasData && snapshot.data!.isNotEmpty &&
                snapshot.connectionState == ConnectionState.done) {
              return SlidableCard(snapshot.data!);
              // Apresneta msg para o caso de não ter dados no banco de dados
            }
            if (snapshot.data!.isEmpty &&
                snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Text(
                  "Nenhum dado encontrado!",
                  style: TextStyle(fontSize: 22),
                ),
              );
              // Apresenta msg de erro caso ocorra um erro na conexão com o banco de dados
            }
            if (!snapshot.hasError &&
                snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Text(
                  "Erro ao buscar dados!",
                  style: TextStyle(fontSize: 22),
                ),
              );
              // Apresenta um circulo de carregamento durante a busco por dados no banco de dados
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
