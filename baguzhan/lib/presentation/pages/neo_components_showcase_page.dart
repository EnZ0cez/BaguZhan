/// Neo 组件示例页面
///
/// 展示所有 Neo-Brutalism 风格组件的使用方式
library;

import 'package:flutter/material.dart';

import '../../core/theme/neo_brutal_theme.dart';
import '../widgets/neo/neo_bottom_nav.dart';
import '../widgets/neo/neo_button.dart';
import '../widgets/neo/neo_container.dart';
import '../widgets/neo/neo_icon_button.dart';
import '../widgets/neo/neo_progress_ring.dart';
import '../widgets/neo/neo_stat_bar.dart';
import '../widgets/neo/neo_unit_banner.dart';

/// 组件示例页面
class NeoComponentsShowcasePage extends StatelessWidget {
  const NeoComponentsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalTheme.background,
      appBar: AppBar(
        title: const Text('Neo 组件示例'),
        backgroundColor: NeoBrutalTheme.background,
        foregroundColor: NeoBrutalTheme.charcoal,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('按钮 (Buttons)'),
          _buildButtonsSection(),
          const SizedBox(height: 24),
          _buildSectionTitle('容器 (Containers)'),
          _buildContainersSection(),
          const SizedBox(height: 24),
          _buildSectionTitle('进度环 (Progress Rings)'),
          _buildProgressRingsSection(),
          const SizedBox(height: 24),
          _buildSectionTitle('统计栏 (Stat Bar)'),
          _buildStatBarSection(),
          const SizedBox(height: 24),
          _buildSectionTitle('单元横幅 (Unit Banner)'),
          _buildUnitBannerSection(),
          const SizedBox(height: 24),
          _buildSectionTitle('图标按钮 (Icon Buttons)'),
          _buildIconButtonsSection(),
          const SizedBox(height: 24),
          _buildSectionTitle('底部导航 (Bottom Nav)'),
          _buildBottomNavSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: NeoBrutalTheme.styleHeadlineSmall,
      ),
    );
  }

  Widget _buildButtonsSection() {
    return NeoContainer(
      color: NeoBrutalTheme.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Primary
          NeoTextButton(
            text: 'Primary Button',
            onPressed: () {},
            type: NeoButtonType.primary,
          ),
          const SizedBox(height: 12),

          // Secondary
          NeoTextButton(
            text: 'Secondary Button',
            onPressed: () {},
            type: NeoButtonType.secondary,
          ),
          const SizedBox(height: 12),

          // Accent
          NeoTextButton(
            text: 'Accent Button',
            onPressed: () {},
            type: NeoButtonType.accent,
          ),
          const SizedBox(height: 12),

          // Outline
          NeoTextButton(
            text: 'Outline Button',
            onPressed: () {},
            type: NeoButtonType.outline,
          ),
          const SizedBox(height: 12),

          // Disabled
          const NeoTextButton(
            text: 'Disabled Button',
            onPressed: null,
          ),
          const SizedBox(height: 12),

          // Different sizes
          Row(
            children: [
              Expanded(
                child: NeoTextButton(
                  text: 'Small',
                  onPressed: () {},
                  size: NeoButtonSize.small,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: NeoTextButton(
                  text: 'Medium',
                  onPressed: () {},
                  size: NeoButtonSize.medium,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: NeoTextButton(
                  text: 'Large',
                  onPressed: () {},
                  size: NeoButtonSize.large,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainersSection() {
    return NeoContainer(
      color: NeoBrutalTheme.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Default container
          const NeoContainer(
            padding: EdgeInsets.all(12),
            child: Text('Default Container'),
          ),
          const SizedBox(height: 12),

          // Primary color container
          NeoContainer(
            color: NeoBrutalTheme.primary,
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Primary Color Container',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),

          // Accent color container
          NeoContainer(
            color: NeoBrutalTheme.accent,
            padding: const EdgeInsets.all(12),
            child: const Text('Accent Color Container'),
          ),
          const SizedBox(height: 12),

          // Card
          const NeoCard(
            child: Text('NeoCard (White Background)'),
          ),
          const SizedBox(height: 12),

          // Interactive container
          NeoContainer(
            color: NeoBrutalTheme.secondary.withOpacity(0.2),
            padding: const EdgeInsets.all(12),
            onTap: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app),
                SizedBox(width: 8),
                Text('Tap Me (Interactive)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRingsSection() {
    return NeoContainer(
      color: NeoBrutalTheme.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  NeoProgressRing(
                    progress: 0.25,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('25%'),
                ],
              ),
              Column(
                children: [
                  NeoProgressRing(
                    progress: 0.5,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('50%'),
                ],
              ),
              Column(
                children: [
                  NeoProgressRing(
                    progress: 0.75,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('75%'),
                ],
              ),
              Column(
                children: [
                  NeoProgressRing(
                    progress: 1.0,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('100%'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Progress Button
          NeoProgressButton(
            progress: 0.75,
            size: 140,
            buttonIcon: Icons.play_arrow,
            buttonLabel: 'START',
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatBarSection() {
    return Column(
      children: [
        NeoContainer(
          color: NeoBrutalTheme.surface,
          padding: const EdgeInsets.all(16),
          child: NeoStatBar.standard(
            streak: 15,
            accuracy: 0.92,
            totalQuestions: 450,
            xp: 1250,
          ),
        ),
        const SizedBox(height: 12),
        NeoContainer(
          color: NeoBrutalTheme.surface,
          padding: const EdgeInsets.all(16),
          child: NeoStatBar(
            metrics: [
              StatMetric(
                icon: Icons.star,
                value: 'Level 5',
                color: NeoBrutalTheme.accent,
              ),
              StatMetric(
                icon: Icons.emoji_events,
                value: '10',
                color: NeoBrutalTheme.fire,
                suffix: '徽章',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitBannerSection() {
    return Column(
      children: [
        const NeoUnitBanner(
          unit: 1,
          part: 7,
          topic: 'JavaScript Closures',
          subtitle: 'Master memory & scope',
        ),
        const SizedBox(height: 12),
        const NeoUnitBanner(
          unit: 2,
          part: 3,
          topic: 'React Hooks',
          subtitle: 'useState & useEffect',
        ),
      ],
    );
  }

  Widget _buildIconButtonsSection() {
    return NeoContainer(
      color: NeoBrutalTheme.surface,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NeoIconButton(
            icon: Icons.description_outlined,
            onPressed: () {},
            tooltip: '错题本',
          ),
          NeoIconButton(
            icon: Icons.grade_outlined,
            onPressed: () {},
            tooltip: '收藏',
            backgroundColor: NeoBrutalTheme.accent,
          ),
          NeoIconButton(
            icon: Icons.history_outlined,
            onPressed: () {},
            tooltip: '历史',
            backgroundColor: NeoBrutalTheme.secondary,
          ),
          NeoIconButton(
            icon: Icons.settings_outlined,
            onPressed: () {},
            tooltip: '设置',
            backgroundColor: NeoBrutalTheme.surface,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavSection() {
    return StatefulBuilder(
      builder: (context, setState) {
        var selectedId = 'path';

        return NeoBottomNav(
          items: defaultNavItems,
          selectedId: selectedId,
          onTap: (id) {
            setState(() {
              selectedId = id;
            });
          },
        );
      },
    );
  }
}
