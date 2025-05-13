import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onFabPressed;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onFabPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF7A2C91);
    final Color secondaryColor = const Color(0xFF1C2A6D);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        BottomAppBar(
          height: 65,
          padding: EdgeInsets.zero,
          notchMargin: 12, // Increased notch margin
          elevation: 0,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(),
            CircleBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(context, 0, Icons.work_outline, 'Work'),
                      _buildNavItem(context, 1, Icons.inbox_outlined, 'Inbox'),
                    ],
                  ),
                ),
                const SizedBox(width: 80), // Increased space for FAB
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(context, 3, Icons.calendar_today_outlined, 'Calendar'),
                      _buildNavItem(context, 4, Icons.person_outline, 'Profile'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -20, // Changed from -30 to -20 to lower the button
          child: SizedBox(
            width: 65,
            height: 65,
            child: Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: InkWell(
                onTap: onFabPressed,
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.dashboard,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final isSelected = currentIndex == index;
    final Color primaryColor = const Color(0xFF7A2C91);

    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? _getFilledIcon(icon) : icon,
              color: isSelected ? primaryColor : Colors.grey,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? primaryColor : Colors.grey,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFilledIcon(IconData outlinedIcon) {
    switch (outlinedIcon) {
      case Icons.work_outline:
        return Icons.work;
      case Icons.inbox_outlined:
        return Icons.inbox;
      case Icons.calendar_today_outlined:
        return Icons.calendar_today;
      case Icons.person_outline:
        return Icons.person;
      default:
        return outlinedIcon;
    }
  }
}
