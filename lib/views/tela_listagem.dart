import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:monitor_glicemico/widgets/tela_listagem/card_dados.dart';

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
        future: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SlidableAutoCloseBehavior(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, left: 5),
                itemCount: 3,
                itemBuilder: (context, index) {
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
                                return Container();
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
                          onPressed: (context) {},
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
                    child: CardDados(),
                  );
                },
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "Nenhum dado encontrado!",
                style: TextStyle(fontSize: 22),
              ),
            );
          }
          if (!snapshot.hasError) {
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
