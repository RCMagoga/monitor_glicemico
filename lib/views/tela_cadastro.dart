import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Inicializa a variavel data para controle da data em OutLineButton
  DateTime agora = DateTime.now();
  // Formatação padrão de apresentação de datas
  DateFormat formatacaoPadrao = DateFormat('dd/MM/yyyy');
  // Lista para gerar as opções do momento da coleta
  final List<Text> _periodos = [
    Text("Jejum"),
    Text("Almoço"),
    Text("Jantar"),
  ];
  // Armazena o item que foi selecionada na lista _periodos
  final List<bool> _periodoSelecionado = [
    true,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Column(
        spacing: 20,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          //---------------------------------------------------------------------- Texto e Valor Glicemia
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Glicemia:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 100,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: "Ex: 96",
                  ),
                ),
              ),
            ],
          ),
          //---------------------------------------------------------------------- Botão seleção período
          ToggleButtons(
            constraints: BoxConstraints(
                minWidth: (MediaQuery.of(context).size.width - 100) / 3,
                minHeight: 50),
            isSelected: _periodoSelecionado,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            selectedBorderColor: Colors.blue,
            selectedColor: Colors.white,
            fillColor: Colors.blue,
            color: Colors.black,
            textStyle: TextStyle(fontSize: 18),
            onPressed: (index) {
              setState(() {
                // Faz a troca do botão selecionado
                for (var i = 0; i < _periodoSelecionado.length; i++) {
                  if (i == index) {
                    _periodoSelecionado[i] = true;
                  } else {
                    _periodoSelecionado[i] = false;
                  }
                }
              });
            },
            children: _periodos,
          ),
          //---------------------------------------------------------------------- Botão seleção da data
          OutlinedButton(
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
          ),
          //---------------------------------------------------------------------- Texto e TextField Observações
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 50),
            child: Text(
              "Observações:",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //---------------------------------------------------------------------- Botão salvar
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue),
              minimumSize: WidgetStatePropertyAll(
                Size(MediaQuery.of(context).size.width - 100, 50),
              ),
            ),
            child: Text(
              "Salvar",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Abre a tela para selecionar a data e recarrega a tela com a data selecionada
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: DateTime(agora.year, agora.month, agora.day),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    setState(() {
      agora = selecionado ?? agora;
    });
  }
}
