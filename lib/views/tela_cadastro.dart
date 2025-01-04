import 'package:flutter/material.dart';
import 'package:monitor_glicemico/widgets/tela_cadastro/botao_Data.dart';
import 'package:monitor_glicemico/widgets/tela_cadastro/botao_periodos.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Armazena a data selecionada no widget 'BotaoData'
  DateTime dataSelecionada = DateTime.now();
  // Armazena o período selecionado no widget 'BotaoPeriodo'
  String periodoSelecionado = "";

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
          BotaoPeriodos(setPeriodoSelecionado),
          //---------------------------------------------------------------------- Botão seleção da data
          BotaoData(setDataSelecionada),
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
            onPressed: () {
              
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
  // Metodo set para alterar a data selecionada
  void setDataSelecionada(DateTime data){
    dataSelecionada = data;
  }
  // Método set para alterar o período selecionado
  void setPeriodoSelecionado(String periodo){
    periodoSelecionado = periodo;
  }
}
