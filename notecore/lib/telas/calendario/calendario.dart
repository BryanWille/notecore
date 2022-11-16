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

  @override
  void initState() {
    super.initState();
    atualizarListaProdutos();
  }

  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Produtos'), centerTitle: true),
      body: ListView.builder(
        itemCount: _listaProdutos.length,
        itemBuilder: (context, index) {
          print(_listaProdutos);
          return Dismissible(
            key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment(-0.9, 0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direcao) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (inContext) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      title: Text('Deseja mesmo excluir o produto?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(inContext);
                            atualizarListaProdutos();
                          },
                          child: Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            atualizarListaProdutos();
                          },
                          child: Text(_listaProdutos[0]['titulo']),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 25,
              ),
              title: Text(_listaProdutos[index]['titulo']),
              subtitle: Text(
              _listaProdutos[index]['descricao']),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
              },
            ),
          );
        },
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



    // Calendario
    /*return StreamProvider<QuerySnapshot?>.value(
      value: ServicoBD().anotacoes,
      initialData: null,
      child:
    return Scaffold(
      appBar: AppBar(
        title: Text("Suas anotações"),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text("Deslogar"),
            onPressed: () {
              print("botão de debu");
            },
          )
        ],
      ),
      drawer: SafeArea(
        child: MenuDrawer(),
      ),
      //body: AnotacoesLista(),
      body: Container(
        child: CellCalendar(
          cellCalendarPageController: cellCalendarPageController,
          events: _sampleEvents,
          daysOfTheWeekBuilder: (dayIndex) {
            final labels = ["S", "M", "T", "W", "T", "F", "S"];
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
            final eventsOnTheDate = _sampleEvents.where((event) {
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (contex) => AdicionaNota(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[700],
      ),
    ); 
  }*/
  

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
