import 'package:flutter/material.dart';
import '../core/theme.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onSelect;
  final int selectedIndex;

  const Sidebar({
    super.key,
    required this.onSelect,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,

      color: AppColors.sidebar,

      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 20),

          const Text(
            "Smart Library",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 40),

          sidebarItem("Dashboard", Icons.dashboard, 0),
          sidebarItem("Books", Icons.menu_book, 1),
          sidebarItem("My Books", Icons.bookmark, 2),
          sidebarItem("Analytics", Icons.bar_chart, 3),
          sidebarItem("Admin", Icons.admin_panel_settings, 4),
          sidebarItem("Profile", Icons.person, 5),
        ],
      ),
    );
  }

  Widget sidebarItem(String title, IconData icon, int index) {
    bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onSelect(index),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),

            const SizedBox(width: 12),

            Text(
              title,
              style: TextStyle(
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
