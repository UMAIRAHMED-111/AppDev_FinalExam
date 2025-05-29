import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  const CustomBottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(context, Icons.home, 'Home', 0),
          _buildNavBarItem(context, Icons.credit_card, 'Cards', 1),
          _buildNavBarItem(context, Icons.grid_view_rounded, 'Pix', 2),
          _buildNavBarItem(context, Icons.sticky_note_2_outlined, 'Notes', 3),
          _buildNavBarItem(context, Icons.receipt_long, 'Extract', 4),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(BuildContext context, IconData icon, String label, int index) {
    final bool selected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (selectedIndex != index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cards');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/pix');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/notes');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/extract');
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selected ? Colors.black : Colors.black26,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.black : Colors.black26,
              fontSize: 12,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
} 