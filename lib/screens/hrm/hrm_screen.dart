import 'package:flutter/material.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';
import 'package:erp_project/theme/app_theme.dart';

class HRMScreen extends StatefulWidget {
  const HRMScreen({super.key});

  @override
  State<HRMScreen> createState() => _HRMScreenState();
}

class _HRMScreenState extends State<HRMScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final threshold = MediaQuery.of(context).size.height * 0.15;
    setState(() {
      _isScrolled = _scrollController.offset > threshold;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  elevation: innerBoxIsScrolled ? 4 : 0,
                  backgroundColor: AppTheme.primaryColor,
                  surfaceTintColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  iconTheme: const IconThemeData(color: Colors.white),
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1,
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.secondaryColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'WhatsApp Image 2025-03-18 at 05.30.09_b09baf62.jpg',
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Hamza Mustafa',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(65),
                    child: Container(
                      child: TabBar(
                        controller: _tabController,
                        dividerColor: Colors.transparent,
                        labelStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 2,
                        indicatorColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        tabs: [
                          Tab(
                            height: 60,
                            icon: const Icon(Icons.dashboard_rounded, size: 22),
                            text: 'Dashboard',
                          ),
                          Tab(
                            height: 60,
                            icon: const Icon(
                              Icons.beach_access_rounded,
                              size: 22,
                            ),
                            text: 'Leaves',
                          ),
                          Tab(
                            height: 60,
                            icon: const Icon(
                              Icons.watch_later_rounded,
                              size: 22,
                            ),
                            text: 'Attendance',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
          body: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color:
                    _isScrolled
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryColor,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                clipBehavior: Clip.antiAlias,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    _DashboardTab(),
                    _LeavesTab(),
                    _AttendanceTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const _QuickActionsSheet(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            );
          },
          backgroundColor: AppTheme.primaryColor,
          elevation: 2,
          child: const Icon(Icons.insert_link_rounded, color: Colors.white),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 5,
          onTap: (index) {},
          onFabPressed: () {},
        ),
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildQuickStats(),
        const SizedBox(height: 24),
        _buildUpcomingEvents(),
        const SizedBox(height: 24),
        _buildRecentActivities(),
      ],
    );
  }

  Widget _buildQuickStats() {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Hours Today',
            value: '7.5/8',
            icon: Icons.access_time,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Leave Balance',
            value: '12 days',
            icon: Icons.event_available,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEvents() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildEventItem('Team Meeting', 'Today, 2:00 PM', Icons.group),
            _buildEventItem('Project Deadline', 'Tomorrow', Icons.assignment),
            _buildEventItem('Holiday', 'Dec 25', Icons.celebration),
          ],
        ),
      ),
    );
  }

  Widget _buildEventItem(String title, String time, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(
                time,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.notifications)),
            title: Text('Activity ${index + 1}'),
            subtitle: Text('Description for activity ${index + 1}'),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeavesTab extends StatelessWidget {
  const _LeavesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildLeaveBalance(),
        const SizedBox(height: 24),
        _buildLeaveHistory(),
      ],
    );
  }

  Widget _buildLeaveBalance() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _LeaveBalanceCard(
          title: 'Annual Leave',
          used: 5,
          total: 14,
          color: Colors.blue,
          icon: Icons.beach_access,
        ),
        _LeaveBalanceCard(
          title: 'Medical Leave',
          used: 2,
          total: 10,
          color: Colors.red,
          icon: Icons.local_hospital,
        ),
        _LeaveBalanceCard(
          title: 'Casual Leave',
          used: 3,
          total: 7,
          color: Colors.orange,
          icon: Icons.event,
        ),
        _LeaveBalanceCard(
          title: 'Total Balance',
          used: 10,
          total: 31,
          color: Colors.green,
          icon: Icons.calendar_today,
        ),
      ],
    );
  }

  Widget _buildLeaveHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Leave History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text('Annual Leave'),
                subtitle: Text('12-14 Dec 2023'),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Approved',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _LeaveBalanceCard extends StatelessWidget {
  final String title;
  final int used;
  final int total;
  final Color color;
  final IconData icon;

  const _LeaveBalanceCard({
    required this.title,
    required this.used,
    required this.total,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '${total - used} days remaining',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: (total - used) / total,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }
}

class _AttendanceTab extends StatelessWidget {
  const _AttendanceTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTodayStatus(),
        const SizedBox(height: 24),
        _buildMonthlyOverview(),
      ],
    );
  }

  Widget _buildTodayStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeInfo('Check In', '09:00 AM', Icons.login),
                _buildTimeInfo('Check Out', '-- : --', Icons.logout),
                _buildTimeInfo('Duration', '7h 30m', Icons.access_time),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeInfo(String label, String time, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.secondaryColor),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMonthlyOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Monthly Overview',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: 31,
          itemBuilder: (context, index) {
            return Card(
              color:
                  index % 3 == 0 ? Colors.green.withOpacity(0.1) : Colors.white,
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: index % 3 == 0 ? Colors.green : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _QuickActionsSheet extends StatelessWidget {
  const _QuickActionsSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.add_circle, color: Colors.blue),
            title: const Text('Request Leave'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.timer, color: Colors.green),
            title: const Text('Mark Attendance'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
