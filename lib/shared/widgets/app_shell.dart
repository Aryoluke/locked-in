import 'package:flutter/material.dart';

import '../../features/dashboard/dashboard_screen.dart';
import '../../features/glow_up/glow_up_screen.dart';
import '../../features/habits/habits_screen.dart';
import '../../features.water/water_screen.dart';
import '../../features/workout/workout_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  static const pages = <Widget>[
    DashboardScreen(),
    WorkoutScreen(),
    HabitsScreen(),
    WaterScreen(),
    GlowUpScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(child: IndexedStack(index: _index, children: pages)),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Today'),
            NavigationDestination(icon: Icon(Icons.fitness_center), label: 'Train'),
            NavigationDestination(icon: Icon(Icons.check_circle_outline), label: 'Habits'),
            NavigationDestination(icon: Icon(Icons.water_drop_outlined), label: 'Water'),
            NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Tracks'),
          ],
        ),
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {this.action, super.key});
  final String title;
  final String? action;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          if (action != null) Text(action!, style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        ],
      );
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({required this.value, this.color, super.key});
  final double value;
  final Color? color;
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(
          value: value.clamp(0, 1),
          minHeight: 8,
          backgroundColor: const Color(0xFF2A372F),
          valueColor: AlwaysStoppedAnimation(color ?? Theme.of(context).colorScheme.primary),
        ),
      );
}
