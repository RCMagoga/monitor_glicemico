import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/data/db.dart';

class Telacadastro extends StatefulWidget {
  const Telacadastro({super.key});

  @override
  State<Telacadastro> createState() => _TelacadastroState();
}

class _TelacadastroState extends State<Telacadastro> {
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

  // Lista para popular o 'ToggleButtons'
  List<Widget> periodos = [
    Text("Jejum"),
    Text("Almoço"),
    Text("Jantar"),
  ];
  // Lista retorna bool para seleção do 'ToggleButton'
  final List<bool> _periodosSelecionados = [
    true,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
          key: GlobalKey(debugLabel: "ToggleButton"),
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
        TextButton(
          onPressed: () async{
            Db.salvarColeta();
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
    );
  }
}
