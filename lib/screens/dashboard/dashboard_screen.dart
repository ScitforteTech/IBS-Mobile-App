import 'package:erp_project/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';
import 'package:erp_project/navigation/app_routes.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  bool isClockedIn = false;
  final searchController = TextEditingController();
  int currentIndex = 0;
  String _currentTime = DateFormat(
    'HH:mm', // Changed from 'hh:mm a' to 'HH:mm'
  ).format(DateTime.now()); // Initialize with HH:mm format
  late Timer _timer;
  late AnimationController _buttonController;
  late Animation<double> _buttonScaleAnimation;
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    // Timer initialization remains same
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = DateFormat(
          'HH:mm',
        ).format(DateTime.now()); // Changed from 'hh:mm a'
      });
    });

    // Initialize animation controllers
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..value = 1.0; // Start at full scale

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Setup animations with improved curves
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    _rippleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeInOut),
    );

    // Start ripple animation with smoother repeat
    _rippleController.repeat(
      reverse: true,
      period: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _timer.cancel();
    _buttonController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
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
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7A2C91), Color(0xFF1C2A6D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(),
          drawer: const AppDrawer(),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF7A2C91),
                  Color(0xFF1C2A6D),
                  Color(0xFF1C2A6D),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 20),
                      _buildGreeting(),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildClockInOutCard(),
                              const SizedBox(height: 20),
                              _buildQuickActions(),
                              const SizedBox(height: 20),
                              _buildSummaryCards(),
                              const SizedBox(height: 20),
                              _buildMyTasks(),
                              const SizedBox(height: 20),
                              _buildActivityHoursChart(),
                              const SizedBox(height: 20),
                              _buildBillableChart(),
                              const SizedBox(height: 20),
                              _buildTrackerActivity(),
                              const SizedBox(height: 20),
                              _buildTopEmployees(),
                              const SizedBox(height: 20),
                              _buildTopTeams(),
                              const SizedBox(height: 20),
                              _buildTeamActivities(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: null,
          floatingActionButtonLocation: null,
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
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
                currentIndex = 2;
              });
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Badge(label: Text('3'), child: Icon(Icons.notifications)),
          onPressed: () {},
        ),
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.help_outline),
          onPressed: () {},
        ),
      ],
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: Container(
                padding: const EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: 18,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 14, // Shorter middle line
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 18,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Search tasks, projects, or people...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getGreeting(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'What are you working on?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'label': 'New Task', 'icon': Icons.add_task, 'color': Colors.blue},
      {
        'label': 'New Project',
        'icon': Icons.create_new_folder,
        'color': Colors.green,
      },
      {
        'label': 'Time Sheet',
        'icon': Icons.access_time,
        'color': Colors.orange,
      },
      {
        'label': 'Leave Request',
        'icon': Icons.beach_access,
        'color': Colors.purple,
      },
      {'label': 'Meetings', 'icon': Icons.group_add, 'color': Colors.red},
      {'label': 'Reports', 'icon': Icons.bar_chart, 'color': Colors.teal},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9,
          children:
              actions
                  .map(
                    (action) => Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              action['icon'] as IconData,
                              color: action['color'] as Color,
                              size: 40,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              action['label'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildClockInOutCard() {
    final colorScheme =
        isClockedIn
            ? const _ClockButtonColors(
              primary: Colors.red,
              onPrimary: Colors.white,
              background: Colors.transparent,
              gradientColors: [Color(0xFFFF5252), Color(0xFFD32F2F)],
            )
            : _ClockButtonColors(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              background: Colors.transparent,
              gradientColors: [
                Color(0xFF8E24AA),
                Color(0xFF8E24AA),
                Color(0xFF8E24AA),
                Color(0xFF5E35B1),
                Color(0xFF5E35B1),
                Color(0xFF1C2A6D),
              ],
            );

    final now = DateTime.now();
    final date = DateFormat('MMMM d, y').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                _currentTime,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildClockInButton(context, colorScheme),
        if (isClockedIn) ...[
          const SizedBox(height: 24),
          Text(
            'Started at ${DateFormat('hh:mm a').format(now)}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildClockInButton(
    BuildContext context,
    _ClockButtonColors colorScheme,
  ) {
    return GestureDetector(
      onTapDown: (_) => _buttonController.reverse(),
      onTapUp: (_) {
        _buttonController.forward();
        setState(() => isClockedIn = !isClockedIn);
      },
      onTapCancel: () => _buttonController.forward(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_buttonScaleAnimation, _rippleAnimation]),
        builder:
            (context, child) => Transform.scale(
              scale: _buttonScaleAnimation.value,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colorScheme.gradientColors,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.gradientColors.last.withOpacity(0.3),
                      blurRadius: 24 * _rippleAnimation.value,
                      spreadRadius: 8 * _rippleAnimation.value,
                    ),
                  ],
                ),
                child: child,
              ),
            ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isClockedIn ? Icons.logout : Icons.login,
                    size: 56,
                    color: colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isClockedIn ? 'Clock Out' : 'Clock In',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildSummaryCard('Tasks Due Today', '5', Icons.task),
        _buildSummaryCard('Hours Worked', '6.5', Icons.access_time),
        _buildSummaryCard(
          'Productive Hours',
          '6.5',
          Icons.trending_up,
          Colors.green,
        ),
        _buildSummaryCard(
          'Unproductive',
          '1.5',
          Icons.trending_down,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon, [
    Color? iconColor,
  ]) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: iconColor),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityHoursChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity Hours Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 8,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Productive', 'Unproductive'];
                          if (value < 0 || value >= titles.length)
                            return const Text('');
                          return Text(titles[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 6.5,
                          color: Colors.green,
                          width: 45,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 1.5,
                          color: Colors.red.shade300,
                          width: 45,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillableChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Billable Hours',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      value: 65,
                      title: 'Productive\n65%',
                      color: Colors.green,
                      radius: 60,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: 'Neutral\n20%',
                      color: Colors.orange,
                      radius: 60,
                    ),
                    PieChartSectionData(
                      value: 15,
                      title: 'Unproductive\n15%',
                      color: Colors.red,
                      radius: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackerActivity() {
    final activities = [
      {
        'name': 'Development',
        'type': 'Productive',
        'time': '3h 30m',
        'color': Colors.green,
      },
      {
        'name': 'Meetings',
        'type': 'Neutral',
        'time': '2h 15m',
        'color': Colors.orange,
      },
      {
        'name': 'Code Review',
        'type': 'Productive',
        'time': '1h 45m',
        'color': Colors.green,
      },
      {
        'name': 'Social Media',
        'type': 'Unproductive',
        'time': '45m',
        'color': Colors.red,
      },
      {
        'name': 'Documentation',
        'type': 'Neutral',
        'time': '1h 30m',
        'color': Colors.orange,
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tracker Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 12,
                    color: activity['color'] as Color,
                  ),
                  title: Text(activity['name'] as String),
                  subtitle: Text(activity['type'] as String),
                  trailing: Text(activity['time'] as String),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopEmployees() {
    final employees = [
      {
        'name': 'John Smith',
        'productive': '6.5h',
        'unproductive': '1.5h',
        'percent': '95%',
      },
      {
        'name': 'Emma Wilson',
        'productive': '6.0h',
        'unproductive': '2.0h',
        'percent': '90%',
      },
      {
        'name': 'Mike Johnson',
        'productive': '5.5h',
        'unproductive': '2.5h',
        'percent': '85%',
      },
      {
        'name': 'Sarah Davis',
        'productive': '5.0h',
        'unproductive': '3.0h',
        'percent': '80%',
      },
      {
        'name': 'Tom Brown',
        'productive': '4.5h',
        'unproductive': '3.5h',
        'percent': '75%',
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Productive Employees',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Text('${index + 1}'),
                  ),
                  title: Text(employee['name'] as String),
                  subtitle: Row(
                    children: [
                      Icon(Icons.trending_up, size: 16, color: Colors.green),
                      Text(' ${employee['productive']} '),
                      Icon(Icons.trending_down, size: 16, color: Colors.red),
                      Text(' ${employee['unproductive']}'),
                    ],
                  ),
                  trailing: Text(employee['percent'] as String),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTeams() {
    final teams = [
      {
        'name': 'Frontend Team',
        'productive': '28h',
        'unproductive': '4h',
        'percent': '90%',
      },
      {
        'name': 'Backend Team',
        'productive': '26h',
        'unproductive': '6h',
        'percent': '85%',
      },
      {
        'name': 'Design Team',
        'productive': '24h',
        'unproductive': '8h',
        'percent': '80%',
      },
      {
        'name': 'QA Team',
        'productive': '22h',
        'unproductive': '10h',
        'percent': '75%',
      },
      {
        'name': 'DevOps Team',
        'productive': '20h',
        'unproductive': '12h',
        'percent': '70%',
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Productive Teams',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[index],
                    child: Text('T${index + 1}'),
                  ),
                  title: Text(team['name'] as String),
                  subtitle: Row(
                    children: [
                      Icon(Icons.trending_up, size: 16, color: Colors.green),
                      Text(' ${team['productive']} '),
                      Icon(Icons.trending_down, size: 16, color: Colors.red),
                      Text(' ${team['unproductive']}'),
                    ],
                  ),
                  trailing: Text(team['percent'] as String),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamActivities() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Team Hours by Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 40,
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [BarChartRodData(toY: 35, color: Colors.blue)],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [BarChartRodData(toY: 28, color: Colors.green)],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [BarChartRodData(toY: 22, color: Colors.orange)],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [BarChartRodData(toY: 15, color: Colors.purple)],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const activities = [
                            'Dev',
                            'Design',
                            'Meeting',
                            'Other',
                          ];
                          return Text(activities[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyTasks() {
    final tasks = [
      {
        'title': 'Complete Dashboard UI',
        'project': 'ERP System Redesign',
        'hours': '2.5',
        'priority': 'high',
      },
      {
        'title': 'Review API Documentation',
        'project': 'Backend Integration',
        'hours': '1.5',
        'priority': 'high',
      },
      {
        'title': 'User Testing Session',
        'project': 'Mobile App',
        'hours': '3',
        'priority': 'medium',
      },
      {
        'title': 'Weekly Team Sync',
        'project': 'Project Management',
        'hours': '1',
        'priority': 'medium',
      },
      {
        'title': 'Update Release Notes',
        'project': 'Documentation',
        'hours': '0.5',
        'priority': 'low',
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 12,
                    color:
                        task['priority'] == 'high'
                            ? Colors.red
                            : (task['priority'] == 'medium'
                                ? Colors.orange
                                : Colors.green),
                  ),
                  title: Text(task['title'] as String),
                  subtitle: Text(task['project'] as String),
                  trailing: Text('${task['hours']}h'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ClockButtonColors {
  final Color primary;
  final Color onPrimary;
  final Color background;
  final List<Color> gradientColors;

  const _ClockButtonColors({
    required this.primary,
    required this.onPrimary,
    required this.background,
    required this.gradientColors,
  });
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7A2C91), Color(0xFF1C2A6D)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide.none),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ListView(
                padding: const EdgeInsets.only(top: 16),
                children: [
                  _buildDrawerItem(
                    context,
                    'Dashboard',
                    Icons.dashboard,
                    AppRoutes.dashboard,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Inbox',
                    Icons.inbox,
                    AppRoutes.inbox,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Work',
                    Icons.work,
                    AppRoutes.work,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Calendar',
                    Icons.calendar_today,
                    AppRoutes.calendar,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Planner',
                    Icons.event_note,
                    AppRoutes.planner,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'HRM',
                    Icons.people,
                    AppRoutes.hrm,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Reports',
                    Icons.bar_chart,
                    AppRoutes.reports,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Profile',
                    Icons.person,
                    AppRoutes.profile,
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Settings',
                    Icons.settings,
                    'settings',
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                  _buildDrawerItem(
                    context,
                    'Logout',
                    Icons.logout,
                    'logout',
                    Color(0xFF7A2C91),
                    Colors.black87,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    String route, [
    Color iconColor = Colors.black54,
    Color textColor = Colors.black87,
  ]) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: () {
        Navigator.pop(context);
        if (route == 'logout') {
          return;
        }
        if (route == 'settings') {
          return;
        }
        if (route != AppRoutes.dashboard) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
