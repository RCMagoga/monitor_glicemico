import 'package:flutter/material.dart';

class CardDados extends StatelessWidget {
  CardDados({super.key});

  TextStyle dadosStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("DATA", style: dadosStyle,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jejum"),
                Text("96", style: dadosStyle,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Almoço"),
                Text("96", style: dadosStyle,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jantar"),
                Text("96", style: dadosStyle,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
