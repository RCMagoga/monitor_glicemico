import 'package:flutter/material.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/widgets/snackBar_custom.dart';
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
  bool dadosAlterados = false;
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
          EditarDados(widget.coleta, 'Jejum', setDadosAlterados),
          EditarDados(widget.coleta, 'Almoço', setDadosAlterados),
          EditarDados(widget.coleta, 'Jantar', setDadosAlterados),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: acaoBotaoSalvar,
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
    dadosAlterados = true;
  }

  // Método ser para controlar caso algum dado tenha sido alterado
  void setDadosAlterados(bool alterado) {
    dadosAlterados = alterado;
  }

  // Função que o botão salvar executará
  void acaoBotaoSalvar() async {
    if (dadosAlterados) {
      var alterarDados = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Salvar'),
            content: Text("Deseja salvar as alterações?"),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                label: Text('Não'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                label: Text('Sim'),
              )
            ],
          );
        },
      );
      int resposta = await Db()
          .editarDados(widget.coleta, novaData, alterar: alterarDados);
      if (alterarDados) {
        if (resposta == -1) {
          SnackbarCustom.showCustomSnackbar(
            context,
            'Erro ao salvar! Tente novamente.',
            Colors.red,
          );
        } else {
          SnackbarCustom.showCustomSnackbar(
            context,
            'Dados alterados com sucesso!',
            Colors.green,
          );
        }
      }
      Navigator.pop(context);
    }
  }
}
