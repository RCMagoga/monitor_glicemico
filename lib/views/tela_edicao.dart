import 'package:flutter/material.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/widgets/tela_cadastro/botao_data.dart';
import 'package:monitor_glicemico/widgets/tela_edicao/edit_dados.dart';

class TelaEdicao extends StatefulWidget {
  final Coleta coleta;

  const TelaEdicao(this.coleta, {super.key});

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  String dataFormatada = "";
  late DateTime novaData;
  @override
  Widget build(BuildContext context) {
    novaData = widget.coleta.data;
    dataFormatada =
        '${widget.coleta.data.day.toString().padLeft(2, '0')}/${widget.coleta.data.month.toString().padLeft(2, '0')}/${widget.coleta.data.year}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          BotaoData(
            setDataSelecionada,
            dataSelecionada: widget.coleta.data,
          ),
          /*Text(
            dataFormatada,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),*/
          EditarDados(widget.coleta, 'Jejum'),
          EditarDados(widget.coleta, 'Almoço'),
          EditarDados(widget.coleta, 'Jantar'),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: () {
                Db().editarDados(widget.coleta, novaData);
                Navigator.pop(context);
              },
              child: Text(
                "Salvar",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Metodo set para alterar a data selecionada
  void setDataSelecionada(DateTime data) {
    novaData = data;
  }
}
