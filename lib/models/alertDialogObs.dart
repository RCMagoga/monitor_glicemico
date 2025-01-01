import 'package:flutter/material.dart';
import 'package:monitor_glicemico/data/db.dart';

class AlertDialogObs extends StatefulWidget {
  final String data;
  final String obs;
  final String periodo;
  final Function refresh;

  const AlertDialogObs(this.data, this.obs, this.periodo, this.refresh, {super.key});

  @override
  State<AlertDialogObs> createState() => _AlertDialogObsState();
}

class _AlertDialogObsState extends State<AlertDialogObs> {

  Db db = Db();

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose(){
    widget.refresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.obs == '-' ? "" : widget.obs;
    return AlertDialog(
      title: Text(
        "Observações",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dia: ${widget.data}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Período: ${widget.periodo}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            db.salvarColeta(
              widget.data,
              0,
              0,
              0,
              widget.periodo == 'Jejum' && _controller.text != "" ? _controller.text : widget.obs,
              widget.periodo == 'Almoço' && _controller.text != "" ? _controller.text : widget.obs,
              widget.periodo == 'Jantar' && _controller.text != "" ? _controller.text : widget.obs,
            );
            Navigator.of(context).pop();
          },
          child: Text("Salvar"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Sair"),
        ),
      ],
    );
  }
}
