import 'package:cell_calendar/cell_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notecore/servicos/auth.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:flutter/material.dart';
import 'package:notecore/telas/anotacoes/adicionaNotas.dart';
import 'package:notecore/telas/calendario/anotacoes_calendario.dart';
import '../sidebar/drawer.dart';
import 'package:provider/provider.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  State<Calendario> createState() => CalendarioState();
}

class CalendarioState extends State<Calendario> {
  AuthServico _auth = AuthServico();
  ServicoBD _bd = ServicoBD();
  List<Map<String, dynamic>>_listaProdutos = [];
  List<CalendarEvent> eventos = [];


  @override
  void initState() {
    super.initState();
    atualizarListaProdutos();
  }

  @override
  Widget build(BuildContext context) {
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      appBar: AppBar(title: const Text('Notecore: Suas anotações')),
      body: Stack(
      children: <Widget>[
        ListView?.builder(
        itemCount: _listaProdutos.length,
        itemBuilder: (context, index) {
          final evento = CalendarEvent(
                eventName: _listaProdutos[index]['titulo'],
                eventDate:  DateTime.now().add(Duration(days: 2)),
                eventBackgroundColor: Colors.indigoAccent,
          );
          eventos.add(evento);
          return  Container();}),
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
                              (event) => Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 12),
                                color: event.eventBackgroundColor,
                                child: Text(
                                  event.eventName,
                                  style: TextStyle(color: event.eventTextColor),
                                ),
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
        )]
      ),
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

  void atualizarListaProdutos() {
    _bd.retornaNotas().then((lista) {
      setState(() {
        _listaProdutos = lista;
      });
    });
  }



  List<CalendarEvent> sampleEvents() {
    final today = DateTime.now();
    final eventTextStyle = TextStyle(
      fontSize: 9,
      color: Colors.white,
    );
    final sampleEvents = [
      CalendarEvent(
        eventName: "payload[0]['titulo']",
        eventDate: today.add(Duration(days: 5)),
        eventBackgroundColor: Colors.indigoAccent,
      ),
    ];
    return sampleEvents;
  }
}
