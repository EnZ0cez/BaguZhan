/// Neo-Brutal 风格底部导航栏组件
library;

import 'package:flutter/material.dart';

import '../../../core/theme/neo_brutal_theme.dart';

/// 导航项数据
class NeoNavItem {
  const NeoNavItem({
    required this.icon,
    required this.label,
    required this.id,
    this.activeIcon,
  });

  final IconData icon;
  final String label;
  final String id;
  final IconData? activeIcon;
}

/// Neo-Brutal 底部导航栏
class NeoBottomNav extends StatelessWidget {
  const NeoBottomNav({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onTap,
    this.backgroundColor,
  });

  final List<NeoNavItem> items;
  final String selectedId;
  final ValueChanged<String> onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? NeoBrutalTheme.surface,
        border: Border(
          top: BorderSide(
            color: NeoBrutalTheme.borderColor,
            width: NeoBrutalTheme.borderWidth,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: NeoBrutalTheme.spaceMd,
        right: NeoBrutalTheme.spaceMd,
        bottom: NeoBrutalTheme.spaceMd,
        top: NeoBrutalTheme.spaceXs,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final isSelected = item.id == selectedId;
            return _NavItem(
              item: item,
              isSelected: isSelected,
              onTap: () => onTap(item.id),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final NeoNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    if (widget.isSelected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: widget.isSelected
                  ? BoxDecoration(
                      color: NeoBrutalTheme.primary.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(NeoBrutalTheme.radiusXxs),
                      border: Border.all(
                        color: NeoBrutalTheme.borderColor,
                        width: 2,
                      ),
                    )
                  : null,
              child: Icon(
                widget.isSelected && widget.item.activeIcon != null
                    ? widget.item.activeIcon!
                    : widget.item.icon,
                color: widget.isSelected
                    ? NeoBrutalTheme.charcoal
                    : NeoBrutalTheme.charcoal.withOpacity(0.4),
                size: 26,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.item.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: widget.isSelected
                    ? NeoBrutalTheme.charcoal
                    : NeoBrutalTheme.charcoal.withOpacity(0.4),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 默认导航项
const defaultNavItems = [
  NeoNavItem(
    icon: Icons.map_outlined,
    activeIcon: Icons.map,
    label: 'PATH',
    id: 'path',
  ),
  NeoNavItem(
    icon: Icons.leaderboard_outlined,
    activeIcon: Icons.leaderboard,
    label: 'RANK',
    id: 'rank',
  ),
  NeoNavItem(
    icon: Icons.fitness_center_outlined,
    activeIcon: Icons.fitness_center,
    label: 'DRILL',
    id: 'drill',
  ),
  NeoNavItem(
    icon: Icons.chat_bubble_outline,
    activeIcon: Icons.chat_bubble,
    label: 'INBOX',
    id: 'inbox',
  ),
  NeoNavItem(
    icon: Icons.person_outline,
    activeIcon: Icons.person,
    label: 'ME',
    id: 'me',
  ),
];
