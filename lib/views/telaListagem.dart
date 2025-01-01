import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/views/telaEdicao.dart';
import 'package:monitor_glicemico/widgets/cardDados.dart';
import 'package:provider/provider.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  Db db = Db();

  @override
  Widget build(BuildContext context) {
    return Consumer<Db>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Monitor Glicemico",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: FutureBuilder(
            future: db.buscarColetas(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SlidableAutoCloseBehavior(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, left: 5),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return Slidable(
                          startActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const ScrollMotion(),
                            children: [
                              CustomSlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Deletar Dados'),
                                        content: Text(
                                            'Deseja deletar os dados do dia ${snapshot.data![index]['data']}?'),
                                        icon: Icon(
                                          Icons.warning_amber_rounded,
                                          size: 32,
                                        ),
                                        iconColor: Colors.red,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Não"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              int resposta =
                                                  await db.deletarColeta(
                                                      snapshot.data![index]
                                                          ['data']);
                                              Navigator.of(context).pop();
                                              if (resposta == 1) {
                                                setState(
                                                  () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Dados deletado com sucesso!"),
                                                        backgroundColor:
                                                            Colors.green,
                                                        duration: Duration(
                                                            seconds: 2),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Erro ao deletar dados!"),
                                                    backgroundColor: Colors.red,
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text('Sim'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.all(5),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                                autoClose: true,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    Text("Deletar"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const ScrollMotion(),
                            children: [
                              CustomSlidableAction(
                                onPressed: (context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TelaEdicao(
                                          Coleta(
                                            DateFormat('dd/MM/yyyy').parse(
                                                snapshot.data![index]['data']),
                                            snapshot.data![index]['jejum'],
                                            snapshot.data![index]['almoco'],
                                            snapshot.data![index]['jantar'],
                                            id: snapshot.data![index]['id'],
                                            snapshot.data![index]['obsJejum'],
                                            snapshot.data![index]['obsAlmoco'],
                                            snapshot.data![index]['obsJantar'],
                                          ),
                                          this.context,
                                        );
                                      },
                                    ),
                                  );
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                                autoClose: true,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    Text("Editar"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          child: CardDados(
                            Coleta(
                              DateFormat('dd/MM/yyyy')
                                  .parse(snapshot.data![index]['data']),
                              snapshot.data![index]['jejum'],
                              snapshot.data![index]['almoco'],
                              snapshot.data![index]['jantar'],
                              id: snapshot.data![index]['id'],
                              snapshot.data![index]['obsJejum'],
                              snapshot.data![index]['obsAlmoco'],
                              snapshot.data![index]['obsJantar'],
                            ),
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
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
