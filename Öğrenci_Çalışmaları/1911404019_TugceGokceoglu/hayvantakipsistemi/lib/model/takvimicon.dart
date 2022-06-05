import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/model/hastalikbilgileri/hastalikekle.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TakvimIcon extends StatefulWidget {
  TextEditingController controller =TextEditingController();
  late String labeltext;
  late DateTime selectedDay;
  late DateTime focusedDay;
  TakvimIcon({ Key? key,required this.labeltext,required this.controller,required this.focusedDay,required this.selectedDay}) : super(key: key);

  @override
  State<TakvimIcon> createState() => _TakvimIconState();
}

CalendarFormat format = CalendarFormat.month;

class _TakvimIconState extends State<TakvimIcon> {
  @override
  Widget build(BuildContext context) {
    return  Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Color(0xFF375BA3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            inputFormatters: [maskFormatter],
            keyboardType: TextInputType.number,
            controller:widget.controller, //editing controller of this TextField
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Color(0xFF375BA3),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Scaffold(
                              body: TableCalendar(
                                 locale: 'tr_TR',
                                focusedDay:widget.focusedDay,
                                firstDay: DateTime(1990),
                                lastDay: DateTime(2050),
                                calendarFormat: format,
                                onFormatChanged: (CalendarFormat _format) {
                                  setState(() {
                                    format =
                                        _format; // Bugünün Tarihini Seçtirdik.
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
                                        colors: [
                                          Color(0xFF375BA3),
                                          Color(0xFF29E3D7)
                                        ],
                                        begin: FractionalOffset.centerLeft,
                                        end: FractionalOffset.centerRight,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.white)),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekendStyle: TextStyle(color: Colors.black),
                                  weekdayStyle: TextStyle(color: Colors.black),
                                ),
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: true,
                                  titleCentered: true,
                                  formatButtonShowsNext: false,
                                  formatButtonDecoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Color(0xFF375BA3)),
                                    borderRadius: BorderRadius.circular(34),
                                  ),
                                ),
                                selectedDayPredicate: (DateTime date) {
                                  return isSameDay(widget.selectedDay, date);
                                },
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                daysOfWeekVisible: true,
                                onDaySelected:
                                    (DateTime selectDay, DateTime focusDay) {
                                  setState(() {
                                    widget.selectedDay = selectDay;
                                    widget.focusedDay = focusDay;
                                 //   widget.controller.text =dateti
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                          );
                        });
                  }),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              labelText: widget.labeltext,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              hintText: '../../....',
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
  }
}