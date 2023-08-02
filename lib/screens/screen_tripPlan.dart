import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> { 

  DateTime? selectedDate ;
  DateTime _focusedDay = DateTime.now();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;


  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .2 ,
        centerTitle: true,
        backgroundColor: Colors.white  ,
        title: const Text('Make your own trip',style: TextStyle(color: Colors.black ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10 ,top: 7 ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your trip name',
                  border: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(18)
                  )
                ),
               
             
              ),
            ), 
            TableCalendar(
                rowHeight: 50,
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2023, 01, 01),
                lastDay: DateTime.utc(2025, 12, 01),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 217, 230, 37),
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, _) {
                    if (selectedStartDate != null &&
                        selectedEndDate != null &&
                        date.isAfter(selectedStartDate!) &&
                        date.isBefore(selectedEndDate!)) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(251, 226, 228, 153)
                              .withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (date == selectedStartDate ||
                        date == selectedEndDate) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(249, 183, 189, 21),
                          shape: BoxShape.circle,
                        ),
                        child: Text(date.day.toString(),
                            style: const TextStyle(color: Colors.white)),
                      );
                    }
                    return null;
                  },
                ),
                selectedDayPredicate: (date) {
                  return isSameDay(selectedStartDate, date) ||
                      isSameDay(selectedEndDate, date) ||
                      (selectedStartDate != null &&
                          selectedEndDate != null &&
                          date.isAfter(selectedStartDate!) &&
                          date.isBefore(selectedEndDate!));
                },
                onDaySelected: (date, _) {
                  setState(() {
                    if (date.isBefore(_focusedDay )) {
                      selectedDate = null;
                      selectedStartDate = null;
                      selectedEndDate = null;
                    } else if (selectedDate == null ||
                        selectedEndDate != null) {
                      selectedDate = date;
                      selectedStartDate = date;
                      selectedEndDate = null;
                    } else if (selectedDate != null &&
                        selectedEndDate == null) {
                      if (date.isAfter(selectedDate!)) {
                        selectedEndDate = date;
                      } else {
                        selectedEndDate = selectedStartDate;
                        selectedStartDate = date;
                      }
                    }
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
              ), 


         
          // You can add more widgets here...
          ],
        ),
      ), 
    );
  }
}