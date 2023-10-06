import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'rounded_button.dart';
import 'date.dart';

void main() {
  runApp(
    Directionality(textDirection: TextDirection.ltr, child: BookingPage())
    );
}
class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}


class _BookingPageState extends State<BookingPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  // ignore: unused_field
  static bool _dateSelected = false;
  static  bool _timeSelected = false;
  String? token;
  
late final getDate;
late final getTime;


  
  @override
  /*void initState() {
    super.initState();
    GetData();

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Reservation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
           SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    
                    (context, index) {
                      var timeSlots = solts();
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(

                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            
                            border: Border.all(
                              color: _currentIndex == index 
                                  ? Colors.white
                                  : Color.fromARGB(255, 33, 30, 30),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex == index 
                                ? Color.fromARGB(255, 232, 231, 230) 
                                : null, 
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${int.parse(timeSlots[index].substring(0,2))}${timeSlots[index].substring(2)} ${int.parse(timeSlots[index].substring(0,2))>11 ? "PM" : "AM"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _currentIndex == index ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: solts().length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.5),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: RoundedButton(
                text: 'Select',
                press: () async {
                  //convert date/day/time into string first
                  getDate = DateConverted.getDate(_currentDay);
                  //final getDay = DateConverted.getDay(_currentDay.weekday);
                  getTime = DateConverted.getTime(_currentIndex!);

                 // Navigator.pop(context);

                  //if booking return status code 200, then redirect to success booking page

                  
                },
                disable: _timeSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 90)),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 50,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week' , CalendarFormat.twoWeeks: '2 weeks', CalendarFormat.month: 'Month'
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
        
          //check if weekend is selected
          /*if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }*/
        });
      }),
    );}
    
  


    
}
