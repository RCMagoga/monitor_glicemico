import 'package:flutter/material.dart';

class CardDados extends StatelessWidget {
  const CardDados({super.key});

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
            Text('asd'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jejum"),
                Text('asd'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Almoço"),
                Text('asd'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jantar"),
                Text('asd'),
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
