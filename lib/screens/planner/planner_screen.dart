import 'package:flutter/material.dart';
import 'package:erp_project/widgets/bottom_nav_bar.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  bool isManager = true; // This would come from user role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planner')),
      body: isManager ? const ManagerView() : const EmployeeView(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
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

class ManagerView extends StatelessWidget {
  const ManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (data) {
        // Handle task assignment
      },
      builder: (context, candidateData, rejectedData) {
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Employee ${index + 1}'),
                subtitle: const Text('Current Tasks: 3'),
              ),
            );
          },
        );
      },
    );
  }
}

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Task ${index + 1}'),
            subtitle: const Text('Due: Tomorrow'),
          ),
        );
      },
    );
  }
}
