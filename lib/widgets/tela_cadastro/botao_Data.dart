import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BotaoData extends StatefulWidget {
  // Recebe a função vinda de tela de cadastro para atualizar os dados da tela e inserir no Db
  final Function setDataSelecionada;

  const BotaoData(this.setDataSelecionada, {super.key});

  @override
  State<BotaoData> createState() => _BotaoDataState();
}

class _BotaoDataState extends State<BotaoData> {
  // Inicializa a variavel data para controle da data em OutLineButton
  DateTime agora = DateTime.now();

  // Formatação padrão de apresentação de datas
  DateFormat formatacaoPadrao = DateFormat('dd/MM/yyyy');

  // Abre a tela (DatePicker) para selecionar a data e recarrega a tela com a data selecionada
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: DateTime(agora.year, agora.month, agora.day),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    setState(() {
      agora = selecionado ?? agora;
      widget.setDataSelecionada(agora);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(
              Size(MediaQuery.of(context).size.width - 100, 50))),
      onPressed: () {
        _selectDate(context);
      },
      child: Text(
        formatacaoPadrao.format(agora),
        style: TextStyle(fontSize: 22, color: Colors.blue),
      ),
    );
  }
}
