import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/models/alertDialogObs.dart';
import 'package:monitor_glicemico/models/coleta.dart';

class CardDados extends StatefulWidget {
  final Coleta dados;

  const CardDados(this.dados, {super.key});

  @override
  State<CardDados> createState() => _CardDadosState();
}

class _CardDadosState extends State<CardDados> {
  final TextStyle dadosStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  final DateFormat format = DateFormat('dd/MM/yyyy');

  Db db = Db();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: 100,
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              format.format(widget.dados.date),
              style: dadosStyle,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jejum"),
                Text(widget.dados.jejum.toString(), style: dadosStyle),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    icon: Icon(Icons.info),
                    color: widget.dados.obsJejum == '-' ? Colors.black : Colors.blue,
                    padding: EdgeInsets.all(0),
                    iconSize: 30,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogObs(format.format(widget.dados.date), widget.dados.obsJejum, 'Jejum', refresh);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Almoço"),
                Text(
                  widget.dados.almoco.toString(),
                  style: dadosStyle,
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    color: widget.dados.obsAlmoco == "-" ? Colors.black : Colors.blue,
                    padding: EdgeInsets.all(0),
                    iconSize: 30,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogObs(format.format(widget.dados.date), widget.dados.obsAlmoco, 'Almoço', refresh);
                      },
                    ),
                    icon: Icon(Icons.info),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Jantar"),
                Text(
                  widget.dados.jantar.toString(),
                  style: dadosStyle,
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    color: widget.dados.obsJantar == "-" ? Colors.black : Colors.blue,
                    padding: EdgeInsets.all(0),
                    iconSize: 30,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogObs(format.format(widget.dados.date), widget.dados.obsJantar, 'Jantar', refresh);
                      },
                    ),
                    icon: Icon(Icons.info),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    db.buscarColetas;
    setState(
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Dados atualizados com sucesso!"),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
