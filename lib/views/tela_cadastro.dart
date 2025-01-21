import 'package:flutter/material.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/widgets/snackBar_custom.dart';
import 'package:monitor_glicemico/widgets/tela_cadastro/botao_data.dart';
import 'package:monitor_glicemico/widgets/tela_cadastro/botao_periodos.dart';

/*
  Tela criada para que o usuário cadastre novos dados no banco de dados
*/
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
  // Armazena o valor da glicemia
  late int valorGlicemia;
  // Armazanam os dados da glicemia e observações, respectivamente
  final TextEditingController _controllerGlicemia = TextEditingController();
  final TextEditingController _controllerObservacao = TextEditingController();
  // Usado para fechar a tela se o salvamento for bem sucedido
  bool fecharTela = false;

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
              controller: _controllerObservacao,
              maxLines: 4,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //---------------------------------------------------------------------- Botão salvar
          TextButton(
            onPressed: () async {
              List<dynamic> alertaAcao = ["", ""];
              //----------------------------------------- Validação com msg erro
              alertaAcao = validacao();
              //----------------------------------------- Salvar no banco de dados com msg
              if (alertaAcao[0] == "") {
                alertaAcao = await salvar();
              }
              // SnackBar que sempre irá apresentar uma msg para o usuário de erro ou não
              SnackbarCustom.showCustomSnackbar(
                context,
                alertaAcao[0],
                alertaAcao[1],
              );
              if (fecharTela) {
                Navigator.pop(context);
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

  // Metodo set para alterar a data selecionada
  void setDataSelecionada(DateTime data) {
    dataSelecionada = data;
  }

  // Método set para alterar o período selecionado
  void setPeriodoSelecionado(String periodo) {
    periodoSelecionado = periodo;
  }

  // Faz a validação dos dados antes do cadastro para o db e retorna msg para o usuário
  List<dynamic> validacao() {
    List<dynamic> resposta = ["", ""];
    String msgErro = "";
    try {
      valorGlicemia = int.parse(_controllerGlicemia.text);
      if (valorGlicemia <= 0) {
        msgErro = "Digite um valor válido para glicemia!";
      } else if (periodoSelecionado == "") {
        msgErro = "Selecione o período da coleta!";
      }
    } catch (e) {
      msgErro = "Digite apenas numeros para glicemia!";
    }
    resposta[0] = msgErro;
    resposta[1] = Colors.red;
    return resposta.first != "" ? resposta : ["", ""];
  }

  // Faz o salvamento no banco de dados e retorna msg para o usuário
  Future<List<dynamic>> salvar() async {
    Db db = Db();
    List<int> valorPeriodo = [0, 0, 0];
    List<String> obsPeriodo = ["", "", ""];
    if (periodoSelecionado == "Jejum") {
      valorPeriodo[0] = int.parse(_controllerGlicemia.text);
      obsPeriodo[0] = _controllerObservacao.text;
    } else if (periodoSelecionado == "Almoço") {
      valorPeriodo[1] = int.parse(_controllerGlicemia.text);
      obsPeriodo[1] = _controllerObservacao.text;
    } else {
      valorPeriodo[2] = int.parse(_controllerGlicemia.text);
      obsPeriodo[2] = _controllerObservacao.text;
    }
    int id = await db.salvarColeta(
      Coleta(
        dataSelecionada,
        valorPeriodo[0],
        valorPeriodo[1],
        valorPeriodo[2],
        obsPeriodo[0],
        obsPeriodo[1],
        obsPeriodo[2],
      ),
      periodoSelecionado,
    );
    List<dynamic> resposta = ["", ""];
    if (id >= 0) {
      resposta[0] = "Dados salvos com sucesso!";
      resposta[1] = Colors.green;
      limparTela();
      fecharTela = true;
    } else {
      resposta[0] = "Erro ao salvar no banco de dados!";
      resposta[1] = Colors.red;
    }
    return resposta;
  }

  //limpa a tela
  void limparTela() {
    setState(() {
      _controllerGlicemia.text = "";
      _controllerObservacao.text = "";
    });
  }
}
