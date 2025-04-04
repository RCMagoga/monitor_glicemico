import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class Pdfgenerator {
  static final Pdfgenerator _pdf = Pdfgenerator._internal();

  factory Pdfgenerator() {
    return _pdf;
  }

  Pdfgenerator._internal();

  DateFormat formatter = DateFormat('dd-MM-yyyy');
  int lastIndex = 0;
  List<Map> list = [];

  void generatePdf(List<Map> data) async {
    list = data;
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        header: _header,
        build: _body,
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
  // Apresentar o título do documento
  pw.Widget _header(pw.Context context) {
    return pw.Center(
      child: pw.Container(
        margin: pw.EdgeInsets.only(bottom: 5),
        child: pw.Text(
          "Controle Glicêmico",
          style: pw.TextStyle(fontSize: 22),
        ),
      ),
    );
  }
  // Preenche o corpo do documento
  List<pw.Widget> _body(pw.Context context) {
    return [
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          _tableHeader(),
          for (var i = 0; i < list.length; i++) _tablesRows(i),
        ],
      ),
    ];
  }
  // Cria o cabeçalho da tabela
  pw.TableRow _tableHeader() {
    return pw.TableRow(
      children: [
        _tableHeaderContainer("Data"),
        _tableHeaderContainer("Jejum"),
        _tableHeaderContainer("Almoço"),
        _tableHeaderContainer("Jantar"),
      ],
    );
  }
  // Cria os widgets de pdf que formam os cabeçalhos da tabela
  pw.Container _tableHeaderContainer(String periodo) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: pw.EdgeInsets.all(5),
      child: pw.Text(
        periodo,
        style: _tableHeaderStyle(),
      ),
    );
  }
  //Cria a lista da tabela
  pw.TableRow _tablesRows(int index) {
    lastIndex = index;
    return pw.TableRow(
      children: [
        _tableDataDate(index),
        _tableData('jejum', index),
        _tableData('almoco', index),
        _tableData('jantar', index),
      ],
    );
  }

  // widget de pdf responsável por mostrar a data
  pw.Column _tableDataDate(int index) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
          margin: pw.EdgeInsets.all(5),
          child: pw.Text(
            style: _tableBodyStyle(),
            formatter
                .format(
                  DateTime.parse(
                    list[index]["data"],
                  ),
                )
                .replaceAll("-", " / "),
          ),
        ),
      ],
    );
  }

  // widget de pdf responsável por mostrar os dados coletados
  pw.Column _tableData(String periodo, int index) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
          margin: pw.EdgeInsets.all(5),
          child: pw.Text(
            style: _tableBodyStyle(),
            list[index][periodo].toString(),
          ),
        ),
      ],
    );
  }

  pw.TextStyle _tableHeaderStyle() {
    return pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold);
  }

  pw.TextStyle _tableBodyStyle() {
    return pw.TextStyle(fontSize: 12);
  }
}
