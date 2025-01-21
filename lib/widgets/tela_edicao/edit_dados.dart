import 'package:flutter/material.dart';
import 'package:monitor_glicemico/models/coleta.dart';

class EditarDados extends StatefulWidget {
  final Coleta coleta;
  final String periodo;

  const EditarDados(this.coleta, this.periodo, {super.key});

  @override
  State<EditarDados> createState() => _EditarDadosState();
}

class _EditarDadosState extends State<EditarDados> {
  final TextEditingController _controllerGlicemia = TextEditingController();

  final TextEditingController _controllerObs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    recuperarValores();
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.periodo,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Glicemia:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 50,
                width: 60,
                child: TextField(
                  controller: _controllerGlicemia,
                  onChanged: (value) {
                    if (_controllerGlicemia.text != "") {
                      if (widget.periodo == 'Jejum') {
                        widget.coleta.jejum =
                            int.parse(_controllerGlicemia.text);
                      } else if (widget.periodo == 'Almoço') {
                        widget.coleta.almoco =
                            int.parse(_controllerGlicemia.text);
                      } else {
                        widget.coleta.jantar =
                            int.parse(_controllerGlicemia.text);
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            height: 100,
            child: TextField(
              onChanged: (value) {
                if (_controllerGlicemia.text != "") {
                  if (widget.periodo == 'Jejum') {
                    widget.coleta.obsJejum = _controllerObs.text;
                    widget.coleta.jejum = int.parse(_controllerGlicemia.text);
                  } else if (widget.periodo == 'Almoço') {
                    widget.coleta.obsAlmoco = _controllerObs.text;
                    widget.coleta.almoco = int.parse(_controllerGlicemia.text);
                  } else {
                    widget.coleta.obsJantar = _controllerObs.text;
                    widget.coleta.jantar = int.parse(_controllerGlicemia.text);
                  }
                }
              },
              controller: _controllerObs,
              maxLines: 3,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void recuperarValores() {
    if (widget.periodo == "Jejum") {
      _controllerGlicemia.text = widget.coleta.jejum.toString();
      _controllerObs.text = widget.coleta.obsJejum;
    } else if (widget.periodo == "Almoço") {
      _controllerGlicemia.text = widget.coleta.almoco.toString();
      _controllerObs.text = widget.coleta.obsAlmoco;
    } else {
      _controllerGlicemia.text = widget.coleta.jantar.toString();
      _controllerObs.text = widget.coleta.obsJantar;
    }
  }
}
