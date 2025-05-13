import 'package:flutter/material.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tasks'),
            Tab(text: 'Time Entries'),
            Tab(text: 'Projects'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [TasksTab(), TimeEntriesTab(), ProjectsTab()],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle navigation
        },
        onFabPressed: () {
          // Handle FAB press
        },
      ),
    );
  }
}

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab>
    with SingleTickerProviderStateMixin {
  late TabController _innerTabController;

  @override
  void initState() {
    super.initState();
    _innerTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _innerTabController,
          labelColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: 'Task Board'),
            Tab(text: 'Task List'),
            Tab(text: 'Time Sheets'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _innerTabController,
            children: const [TaskBoardView(), TaskListView(), TimeSheetsView()],
          ),
        ),
      ],
    );
  }
}

class TaskBoardView extends StatelessWidget {
  const TaskBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Drag and Drop Task Board'));
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Task ${index + 1}'),
          subtitle: Slider(value: 0.5, onChanged: (value) {}),
        );
      },
    );
  }
}

class TimeSheetsView extends StatelessWidget {
  const TimeSheetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Weekly Time Sheet'));
  }
}

class TimeEntriesTab extends StatelessWidget {
  const TimeEntriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Time Entries'));
  }
}

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Projects'));
  }
}
