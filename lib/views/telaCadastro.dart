import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/data/db.dart';

class Telacadastro extends StatefulWidget {
  const Telacadastro({super.key});

  @override
  State<Telacadastro> createState() => _TelacadastroState();
}

class _TelacadastroState extends State<Telacadastro> {
  Db db = Db();
  // Armazena a data, inicialmente a do dispositivo, depois é alterada por escolha do usuário
  DateTime agora = DateTime.now();
  // Formata a data
  final dataFormatada = DateFormat('dd/MM/yyyy');
  // Método para abrir e fechar menu de escolha da data
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

  // Controladores para recuperar dados e cadastrar no DB
  final TextEditingController _controllerGlicemia = TextEditingController();
  final TextEditingController _controllerObs = TextEditingController();

  @override
  void dispose() {
    _controllerGlicemia.dispose();
    super.dispose();
  }

  // Lista para popular o 'ToggleButtons'
  List<Text> periodos = [
    Text("Jejum"),
    Text("Almoço"),
    Text("Jantar"),
  ];
  // Lista retorna bool para seleção do 'ToggleButton'
  final List<bool> _periodosSelecionados = [
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            height: 10,
          ),
          Text(
            "Cadastrar Glicemia",
            style: TextStyle(fontSize: 28),
          ),
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
                  controller: _controllerGlicemia,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: "Ex: 96",
                  ),
                ),
              ),
            ],
          ),
          ToggleButtons(
            constraints: BoxConstraints(
                minWidth: (MediaQuery.of(context).size.width - 100) / 3,
                minHeight: 50),
            isSelected: _periodosSelecionados,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            selectedBorderColor: Colors.blue,
            selectedColor: Colors.white,
            fillColor: Colors.blue,
            color: Colors.black,
            textStyle: TextStyle(fontSize: 18),
            onPressed: (index) {
              setState(
                () {
                  for (var i = 0; i < _periodosSelecionados.length; i++) {
                    _periodosSelecionados[i] = i == index ? true : false;
                  }
                },
              );
            },
            children: periodos,
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
              controller: _controllerObs,
              maxLines: 4,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              int validado = validacaoCampos();
              if (validado == 0) {
                db.salvarColeta(
                  dataFormatada.format(agora).toString(),
                  _periodosSelecionados[0] ? _controllerGlicemia.text : 0,
                  _periodosSelecionados[1] ? _controllerGlicemia.text : 0,
                  _periodosSelecionados[2] ? _controllerGlicemia.text : 0,
                  _periodosSelecionados[0] ? _controllerObs.text : "-",
                  _periodosSelecionados[1] ? _controllerObs.text : "-",
                  _periodosSelecionados[2] ? _controllerObs.text : "-",
                );
                _controllerGlicemia.text = "";
                for (var i = 0; i < _periodosSelecionados.length; i++) {
                  _periodosSelecionados[i] = false;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Dados cadastrados com sucesso!"),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                String erro = "";
                if (validado == 1) {
                  erro = "Por favor, insira o valor da glicemia!";
                } else {
                  erro = "Por favor, selecione o período da coleta!";
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(erro),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
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

  int validacaoCampos() {
    if (_controllerGlicemia.text == "") {
      return 1;
    }
    for (bool b in _periodosSelecionados) {
      if (b) {
        return 0;
      }
    }
    return 2;
  }
}
