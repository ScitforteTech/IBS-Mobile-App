import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:erp_project/navigation/app_routes.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String _getCurrentMonth() {
    return DateFormat('MMMM').format(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF562085),
        appBar: AppBar(
          backgroundColor: const Color(0xFF7A2C91),
          elevation: 0,

          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF7A2C91),
                Color(0xFF1C2A6D),
                Color(0xFF1C2A6D),
                Color(0xFF1C2A6D),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  16,
                ), // Reduced top padding
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 32,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 32,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    headerPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF7534AB),
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(color: Colors.white70),
                    defaultTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    selectedTextStyle: TextStyle(
                      color: Color(0xFF562085),
                      fontSize: 16,
                    ),
                    todayTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    outsideDaysVisible: false,
                    weekNumberTextStyle: TextStyle(color: Colors.white60),
                    cellMargin: EdgeInsets.all(2),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white70),
                    weekendStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          '${_getCurrentMonth()} Goal',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            _buildTaskCard(
                              'Release ERP v2.0',
                              Colors.blue.shade50,
                              const Color(0xFF7C5BFC),
                              Icons.rocket_launch,
                            ),
                            _buildTaskCard(
                              'Team Performance Review',
                              Colors.red.shade50,
                              Colors.red.shade300,
                              Icons.groups,
                            ),
                            _buildTaskCard(
                              'Client Presentation',
                              Colors.green.shade50,
                              Colors.green.shade300,
                              Icons.present_to_all,
                            ),
                            _buildTaskCard(
                              'System Optimization',
                              Colors.orange.shade50,
                              Colors.orange.shade300,
                              Icons.speed,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 3,
          onTap: (index) {
            setState(() {
              if (index != 2) {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, AppRoutes.work);
                    break;
                  case 1:
                    Navigator.pushNamed(context, AppRoutes.inbox);
                    break;
                  case 3:
                    Navigator.pushNamed(context, AppRoutes.calendar);
                    break;
                  case 4:
                    Navigator.pushNamed(context, AppRoutes.profile);
                    break;
                }
              }
            });
          },
          onFabPressed: () {
            setState(() {
              // Handle center button tap
            });
          },
        ),
      ),
    );
  }

  Widget _buildTaskCard(
    String title,
    Color bgColor,
    Color iconColor,
    IconData icon,
  ) {
    return Card(
      color: bgColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: const Text('Today'),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}
