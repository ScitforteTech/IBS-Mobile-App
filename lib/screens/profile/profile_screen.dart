import 'package:flutter/material.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const UserHeaderWidget(),
          const Divider(),
          _buildSection('Projects', [
            'Active Projects: 5',
            'Completed Projects: 12',
          ]),
          _buildSection('Tasks', ['Pending Tasks: 8', 'Completed Tasks: 25']),
          _buildSection('Time Entries', [
            'This Week: 32 hours',
            'This Month: 128 hours',
          ]),
          _buildSection('Leaves', ['Available: 10 days', 'Taken: 5 days']),
          _buildSection('Emergency Contacts', [
            'John Doe: +1234567890',
            'Jane Doe: +0987654321',
          ]),
          _buildSection('Shift Roster', [
            'Current Shift: 9 AM - 6 PM',
            'Next Week: 9 AM - 6 PM',
          ]),
          const FilesSection(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 7,
        onTap: (index) {
          // Handle navigation
        },
        onFabPressed: () {
          // Handle FAB press
        },
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(title),
        children: items.map((item) => ListTile(title: Text(item))).toList(),
      ),
    );
  }
}

class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 16),
          const Text(
            'John Smith',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text('Software Developer'),
          const Text('ID: EMP001'),
        ],
      ),
    );
  }
}

class FilesSection extends StatelessWidget {
  const FilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: const Text('Files'),
        children: [
          ListTile(
            leading: const Icon(Icons.file_present),
            title: const Text('Resume.pdf'),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {},
            ),
          ),
          // Add more files as needed
        ],
      ),
    );
  }
}
