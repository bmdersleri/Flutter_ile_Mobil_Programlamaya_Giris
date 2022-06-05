import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Takvim extends StatefulWidget {
  DateTime selectedday;
  late TextEditingController zaman;
  Takvim({Key? key,required this.selectedday,required this.zaman}) : super(key: key);

  @override
  State<Takvim> createState() => _TakvimState();
  
}

class _TakvimState extends State<Takvim> {
  @override
  initState(){
    initializeDateFormatting();
  }
  final dateFormat = DateFormat('dd/MM/yyyy');
  CalendarFormat format = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        locale: 'tr_TR',
        focusedDay: focusedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format) {
          setState(() {
            format = _format; // Bugünün Tarihini Seçtirdik.
          });
        },
        calendarStyle: CalendarStyle(
            
            todayDecoration: BoxDecoration(
              color: Color.fromARGB(255, 123, 203, 198),
              shape: BoxShape.circle,
            ),
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
              ),
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white)),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Colors.black),
          weekdayStyle: TextStyle(color: Colors.black),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xFF375BA3)),
            borderRadius: BorderRadius.circular(34),
          ),
        ),
        selectedDayPredicate: (DateTime date) {
          return isSameDay(widget.selectedday, date);
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekVisible: true,
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            widget.selectedday= selectDay;
            widget.zaman.text=dateFormat.format(selectDay);
            focusedDay = focusDay;
          });
         
          Navigator.pop(context);
        },
      ),
    );
  }
}
