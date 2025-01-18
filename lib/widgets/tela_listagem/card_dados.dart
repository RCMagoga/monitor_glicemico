import 'package:flutter/material.dart';
import 'package:monitor_glicemico/models/coleta.dart';

/*
  Widget criado para apresentar um Card formatado dentro do SlidableCard()
*/
class CardDados extends StatelessWidget {
  // Armazena cada entidade de Coleta para apresentar ao usuário
  final Coleta coleta;
  CardDados(this.coleta, {super.key});

  late String dataFormatada;

  @override
  Widget build(BuildContext context) {
    dataFormatada =
        '${coleta.data.day.toString().padLeft(2, '0')}/${coleta.data.month.toString().padLeft(2, '0')}/${coleta.data.year}';
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
                Text(coleta.jejum.toString()),
                getInfoButton(context, coleta.obsJejum, "Jejum"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Almoço"),
                Text(coleta.almoco.toString()),
                getInfoButton(context, coleta.obsAlmoco, "Almoço"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Jantar"),
                Text(coleta.jantar.toString()),
                getInfoButton(context, coleta.obsJantar, "Jantar"),
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
          openAlertInfo(context, coleta, periodoSelecionado, obs);
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
