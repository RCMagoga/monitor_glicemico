import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/widgets/tela_listagem/card_dados.dart';
/*
  Widget criado que irá criar um CardDados() com a função de slide do card onde, ao
  arrastar o card para a direita, irá aparecer botão de delete à esquerda e, ao
  arrastar o card para a esquerda, irá aparecer botão de editar à direita e o usuário
  será levado a tela de edição.
*/ 
class SlidableCard extends StatelessWidget {
  // Armazena as coletas recuperadas do Db
  final List<Map> coletas;
  // Formata os dados 'coleta.data' para DateTime
  final DateFormat stringToDate = DateFormat('yyyy-MM-dd');
  SlidableCard(this.coletas, {super.key});

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, left: 5),
        itemCount: coletas.length,
        itemBuilder: (context, index) {
          Coleta coleta = Coleta(
            stringToDate.parse(coletas[index]['data']),
            coletas[index]['jejum'],
            coletas[index]['almoco'],
            coletas[index]['jantar'],
            coletas[index]['obsJejum'],
            coletas[index]['obsAlmoco'],
            coletas[index]['obsJantar'],
            id: coletas[index]['id'],
          );
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
            child: CardDados(coleta),
          );
        },
      ),
    );
  }
}
