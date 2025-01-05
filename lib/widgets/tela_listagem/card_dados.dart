import 'package:flutter/material.dart';
import 'package:monitor_glicemico/models/coleta.dart';

class CardDados extends StatelessWidget {
  final Coleta coleta;
  const CardDados(this.coleta, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: 80,
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('${coleta.data.day.toString().padLeft(2, '0')}/${coleta.data.month.toString().padLeft(2, '0')}/${coleta.data.year}'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jejum"),
                Text(coleta.jejum.toString()),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Almoço"),
                Text(coleta.almoco.toString()),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jantar"),
                Text(coleta.jantar.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
