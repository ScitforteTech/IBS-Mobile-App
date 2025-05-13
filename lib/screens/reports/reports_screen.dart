import 'package:flutter/material.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        children: [
          _buildReportCard('Productivity Report', Icons.trending_up),
          _buildReportCard('Utilization Report', Icons.pie_chart),
          _buildReportCard('Time Sheet Usage', Icons.access_time),
          _buildReportCard('Work Report', Icons.work),
          _buildReportCard('Profitability Report', Icons.monetization_on),
          _buildReportCard('Auto Tracker Report', Icons.track_changes),
          _buildReportCard('User Activity Report', Icons.person_outline),
          _buildReportCard('Team Productivity', Icons.groups),
          _buildReportCard('Productivity Goal', Icons.flag),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 6,
        onTap: (index) {
          // Handle navigation
        },
        onFabPressed: () {
          // Handle FAB press
        },
      ),
    );
  }

  Widget _buildReportCard(String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detailed report view
        },
      ),
    );
  }
}
