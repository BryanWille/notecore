import 'package:cell_calendar/cell_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notecore/servicos/auth.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:flutter/material.dart';
import 'package:notecore/telas/anotacoes/adicionar_notas.dart';
import 'package:notecore/telas/anotacoes/editar_notas.dart';
import '../sidebar/drawer.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  State<Calendario> createState() => CalendarioState();
}

class CalendarioState extends State<Calendario> {
  AuthServico _auth = AuthServico();
  ServicoBD _bd = ServicoBD();
  List<Map<String, dynamic>> _listaNotas = [];
  List<CalendarEvent> eventos = [];

  @override
  void initState() {
    super.initState();
    atualizarListaNotas();
  }

  @override
  Widget build(BuildContext context) {
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      drawer: SafeArea(
        child: MenuDrawer(),
      ),
      appBar: AppBar(title: const Text('Notecore: Suas anotações')),
      body: Stack(children: <Widget>[
        ListView?.builder(
            itemCount: _listaNotas.length,
            itemBuilder: (context, index) {
              DateTime diaAnotacao =
                  (_listaNotas[index]['horaCriacao'] as Timestamp).toDate();
              Color cor = Color(converterCor(_listaNotas[index]['hexCor']));
              final evento = CalendarEvent(
                eventName: _listaNotas[index]['titulo'],
                eventDate: diaAnotacao.add(
                    Duration(days: daysBetween(diaAnotacao, DateTime.now()))),
                eventBackgroundColor: cor,
                eventID: _listaNotas[index]['idNota'],
              );
              eventos.add(evento);
              return Container();
            }),
        CellCalendar(
          cellCalendarPageController: cellCalendarPageController,
          events: eventos,
          daysOfTheWeekBuilder: (dayIndex) {
            final labels = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"];
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                labels[dayIndex],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
          monthYearLabelBuilder: (datetime) {
            final year = datetime!.year.toString();
            final month = datetime.month.monthName;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    "$month  $year",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      cellCalendarPageController.animateToDate(
                        DateTime.now(),
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 300),
                      );
                    },
                  )
                ],
              ),
            );
          },
          onCellTapped: (date) {
            final eventsOnTheDate = eventos.where((event) {
              final eventDate = event.eventDate;
              return eventDate.year == date.year &&
                  eventDate.month == date.month &&
                  eventDate.day == date.day;
            }).toList();
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text(
                          date.month.monthName + " " + date.day.toString()),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: eventsOnTheDate
                            .map(
                              (event) => ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            event.eventBackgroundColor)),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(30),
                                  color: event.eventBackgroundColor,
                                  child: Text(event.eventName,
                                      style: TextStyle(color: Colors.black)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            EditarAnotacao(
                                                idNota: event.eventID!),
                                      ));
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ));
          },
          onPageChanged: (firstDate, lastDate) {
            /// Called when the page was changed
            /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
          },
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (contex) => AdicionaNota(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void atualizarListaNotas() {
    _bd.retornaNotas().then((lista) {
      setState(() {
        _listaNotas = lista;
      });
    });
  }

  int converterCor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
