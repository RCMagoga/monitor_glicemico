import 'package:flutter/material.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/views/tela_edicao.dart';

/*
  Widget criado para apresentar um Card formatado dentro do SlidableCard()
*/
class CardDados extends StatefulWidget {
  // Armazena cada entidade de Coleta para apresentar ao usuário
  final Coleta coleta;
  const CardDados(this.coleta, {super.key});

  @override
  State<CardDados> createState() => _CardDadosState();
}

class _CardDadosState extends State<CardDados> {
  late String dataFormatada;

  @override
  Widget build(BuildContext context) {
    dataFormatada =
        '${widget.coleta.data.day.toString().padLeft(2, '0')}/${widget.coleta.data.month.toString().padLeft(2, '0')}/${widget.coleta.data.year}';
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: 100,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              dataFormatada,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Jejum"),
                Text(widget.coleta.jejum.toString()),
                getInfoButton(context, widget.coleta.obsJejum, "Jejum"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Almoço"),
                Text(widget.coleta.almoco.toString()),
                getInfoButton(context, widget.coleta.obsAlmoco, "Almoço"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Jantar"),
                Text(widget.coleta.jantar.toString()),
                getInfoButton(context, widget.coleta.obsJantar, "Jantar"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getInfoButton(
      BuildContext context, String obs, String periodoSelecionado) {
    return SizedBox(
      height: 20,
      width: 20,
      child: IconButton(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        constraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
        onPressed: () {
          openAlertInfo(context, widget.coleta, periodoSelecionado, obs);
        },
        icon: Icon(
          Icons.segment,
          color: obs == "" ? Colors.black : Colors.blue,
        ),
      ),
    );
  }

  void openAlertInfo(BuildContext context, Coleta coleta,
      String periodoSelecionado, String obsSelecionada) {
    TextEditingController obs = TextEditingController(text: obsSelecionada);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(10),
        title: Text(dataFormatada),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Observações de $periodoSelecionado:"),
            TextField(
              controller: obs,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaEdicao(coleta),
                ),
              );
            },
            child: Text("Editar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Sair"),
          ),
        ],
      ),
    );
  }
}
