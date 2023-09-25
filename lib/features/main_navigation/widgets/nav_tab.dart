import 'package:flutter/material.dart';
import 'package:show_flutter/constants/sizes.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: isSelected ? 1 : 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: Theme.of(context).primaryColor,
                size: Sizes.size36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
