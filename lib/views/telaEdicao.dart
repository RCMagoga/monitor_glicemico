import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/views/telaListagem.dart';

class TelaEdicao extends StatefulWidget {
  final Coleta _coleta;
  final Function refresh;

  const TelaEdicao(this._coleta, this.refresh, {super.key});

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  late DateTime agora = widget._coleta.date;

  final TextEditingController _controlleJejum = TextEditingController();
  final TextEditingController _controllerAlmoco = TextEditingController();
  final TextEditingController _controllerJantar = TextEditingController();

  final dataFormatada = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: DateTime(agora.year, agora.month, agora.day),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    setState(
      () {
        agora = selecionado ?? agora;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controlleJejum.text = widget._coleta.jejum.toString();
    _controllerAlmoco.text = widget._coleta.almoco.toString();
    _controllerJantar.text = widget._coleta.jantar.toString();
  }

  @override
  void dispose() {
    _controlleJejum.dispose();
    _controllerAlmoco.dispose();
    _controllerJantar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Monitor Glicemico",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        spacing: 20,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Text(
            'Editar dados:',
            style: TextStyle(fontSize: 28),
          ),
          OutlinedButton(
            style: ButtonStyle(
                minimumSize: WidgetStatePropertyAll(
                    Size(MediaQuery.of(context).size.width - 100, 50))),
            onPressed: () => _selectDate(context),
            child: Text(
              dataFormatada.format(agora),
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Jejum",
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextFormField(
                      controller: _controlleJejum,
                      //initialValue: widget._coleta.jejum.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Almoço",
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextFormField(
                      controller: _controllerAlmoco,
                      //initialValue: widget._coleta.almoco.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Janta",
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextFormField(
                      controller: _controllerJantar,
                      //initialValue: widget._coleta.jantar.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Salvar'),
                    content: Text('Deseja salvar as alterações?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Não"),
                      ),
                      TextButton(
                        onPressed: () {
                          Db.salvarColeta(
                            dataFormatada.format(agora).toString(),
                            _controlleJejum.text,
                            _controllerAlmoco.text,
                            _controllerJantar.text,
                          ).then(
                            (value) => widget.refresh,
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Sim'),
                      ),
                    ],
                  );
                },
              );
              //dataFormatada.format(agora).toString()
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue),
              minimumSize: WidgetStatePropertyAll(
                Size(MediaQuery.of(context).size.width - 100, 50),
              ),
            ),
            child: Text(
              'Salvar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
