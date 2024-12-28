import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/models/coleta.dart';

class CardDados extends StatelessWidget {

  Coleta dados;

  CardDados(this.dados, {super.key});

  TextStyle dadosStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  DateFormat format = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(format.format(dados.date), style: dadosStyle,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jejum"),
                Text(dados.jejum.toString(), style: dadosStyle,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Almoço"),
                Text(dados.almoco.toString(), style: dadosStyle,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jantar"),
                Text(dados.jantar.toString(), style: dadosStyle,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
