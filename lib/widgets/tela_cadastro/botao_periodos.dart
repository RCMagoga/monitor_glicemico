import 'package:flutter/material.dart';

class BotaoPeriodos extends StatefulWidget {
  
  final Function setPeriodoSelecionado;
  
  const BotaoPeriodos(this.setPeriodoSelecionado, {super.key});

  @override
  State<BotaoPeriodos> createState() => _BotaoPeriodosState();
}

class _BotaoPeriodosState extends State<BotaoPeriodos> {
  // Lista para gerar as opções do momento da coleta
  final List<Text> _periodos = [
    Text("Jejum"),
    Text("Almoço"),
    Text("Jantar"),
  ];
  // Armazena o item que foi selecionada na lista _periodos
  final List<bool> _periodoSelecionado = [
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
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
              widget.setPeriodoSelecionado(_periodos[index].data);
            } else {
              _periodoSelecionado[i] = false;
            }
          }
        });
      },
      children: _periodos,
    );
  }
}
