import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/data/db.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:monitor_glicemico/widgets/cardDados.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Db.buscarColetas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.white,
            ),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              if (snapshot.hasData) {
                return CardDados(Coleta(
                  DateFormat('dd/MM/yyyy').parse(snapshot.data![index]['data']),
                  snapshot.data![index]['jejum'],
                  snapshot.data![index]['almoco'],
                  snapshot.data![index]['jantar'],
                  id: snapshot.data![index]['id'],
                ));
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
