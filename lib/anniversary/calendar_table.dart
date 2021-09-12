import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:with_u/modles/mymodel.dart';
import 'package:with_u/resources/Theme.dart';
import 'package:with_u/utils/SharedpreferencesUtils.dart';
import 'YearChooser.dart';

class CalendarTable extends StatefulWidget {
  CalendarTable({Key key}) : super(key: key);

  @override
  _CalendarTableState createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  bool yearPickerOpened = false;
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = DateTime.now();
    _events = {
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
    };
    _selectedEvents = _events[_selectedDay] ?? [];

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected>>' + day.toString());
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  void _onHeaderTapped(DateTime focusedDay) async {
    print('CALLBACK: _onHeaderTapped');
    SharedPreferencesUtils.remove("Year");
    showDialog(context: context, builder: (ctx) => _buildDialog());
  }

  void _onHeaderLongPressed(DateTime focusedDay) {
    print('CALLBACK: _onHeaderLongPressed');
    _calendarController.setSelectedDay(
      DateTime.now(),
      runCallback: true,
    );
  }

  void _onDayLongPressed(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDayLongPressed');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendarWithBuilders(),
        ],
      );
  }

  Widget _buildTableCalendarWithBuilders() {
    return Consumer<MyModel>(
      builder: (context, model, child) {
        return TableCalendar(
          locale: 'zh_CN',
          calendarController: _calendarController,
          events: _events,
          initialCalendarFormat: CalendarFormat.month,
          formatAnimation: FormatAnimation.slide,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableGestures: AvailableGestures.all,
          availableCalendarFormats: const {
            CalendarFormat.month: '',
            CalendarFormat.week: '',
          },
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            weekendStyle: TextStyle().copyWith(color: AppTheme.nearlyBlue),
            holidayStyle: TextStyle().copyWith(color: AppTheme.nearlyBlue),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle().copyWith(color: AppTheme.nearlyBlue),
          ),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
          ),
          builders: CalendarBuilders(
            selectedDayBuilder: (context, date, _) {
              return FadeTransition(
                opacity:
                    Tween(begin: 0.0, end: 1.0).animate(_animationController),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppTheme.nearlyDarkBlue.withOpacity(0.4),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  width: 100,
                  height: 100,
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 16.0),
                  ),
                ),
              );
            },
            todayDayBuilder: (context, date, _) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.deepOrange[300],
                ),
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                width: 100,
                height: 100,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0),
                ),
              );
            },
            markersBuilder: (context, date, events, holidays) {
              final children = <Widget>[];

              if (events.isNotEmpty) {
                children.add(
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: _buildEventsMarker(date, events),
                  ),
                );
              }
              return children;
            },
          ),
          onDaySelected: (date, events, holidays) {
            _onDaySelected(date, events, holidays);
            _animationController.forward(from: 0.0);
          },
          onVisibleDaysChanged: _onVisibleDaysChanged,
          onCalendarCreated: _onCalendarCreated,
          onHeaderTapped: _onHeaderTapped,
          onHeaderLongPressed: _onHeaderLongPressed,
          onDayLongPressed: (DateTime day, List events, List holidays) {
            _calendarController.setSelectedDay(
              day,
              runCallback: true,
            );
            model.setCrossFadeState();
          },
        );
      },
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDialog() => Dialog(
      backgroundColor: AppTheme.nearlyWhite,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 10.0, top: 10, left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  '选择年份',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    letterSpacing: 0.5,
                    color: AppTheme.lightText,
                  ),
                )),
            CustomYearPicker(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                    onTap: () async {
                      String newDate =
                          await SharedPreferencesUtils.getPreference(
                                  context, "Year", _selectedDay.toString())
                              as String;
                      _calendarController.setSelectedDay(
                        DateTime.parse(newDate),
                        runCallback: true,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('确认',
                          style: TextStyle(
                              color: AppTheme.nearlyBlue, fontSize: 18)),
                    )),
                InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('取消',
                          style: TextStyle(color: AppTheme.grey, fontSize: 18)),
                    )),
              ],
            ),
          ],
        ),
      ));
}
