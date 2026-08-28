import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';
import '../../shared/widgets/app_shell.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final profile = state.profile!;
    final today = DateFormat('EEEE, d MMM').format(DateTime.now());
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
        sliver: SliverToBoxAdapter(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(today.toUpperCase(), style: const TextStyle(color: Colors.white60, letterSpacing: 1.2, fontSize: 12)),
            const SizedBox(height: 5),
            Text('Stay locked, ${profile.name}.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          ]),
          CircleAvatar(backgroundColor: const Color(0xFF1B6D4D), child: Text(profile.name.substring(0, 1).toUpperCase())),
        ])),
      ),
      SliverPadding(padding: const EdgeInsets.all(20), sliver: SliverToBoxAdapter(child: _HeroCard(state: state))),
      SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 20), sliver: SliverToBoxAdapter(child: Row(children: [
        Expanded(child: _MetricCard(icon: Icons.local_fire_department, value: '${state.streak}', label: 'day streak', color: Colors.orange)),
        const SizedBox(width: 12),
        Expanded(child: _MetricCard(icon: Icons.bolt, value: '${state.xp}', label: 'total XP', color: const Color(0xFFE8B949))),
        const SizedBox(width: 12),
        Expanded(child: _MetricCard(icon: Icons.shield, value: '${state.level}', label: 'level', color: const Color(0xFF16C784))),
      ]))),
      const SliverPadding(
        padding: EdgeInsets.fromLTRB(20, 28, 20, 10),
        sliver: SliverToBoxAdapter(child: SectionTitle('Today’s plan', action: 'MINI CORE'))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(20, 28, 20, 10), sliver: SliverToBoxAdapter(child: Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: const [
        ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.fitness_center, color: Color(0xFF16C784)), title: Text('Train with intent'), subtitle: Text('Log one exercise in the Train tab')),
        Divider(),
        ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.check_circle_outline, color: Color(0xFFE8B949)), title: Text('Close your habits'), subtitle: Text('Hydration, creating, skincare, study')),
      ]))))),
      const SliverPadding(padding: EdgeInsets.fromLTRB(20, 28, 20, 10), sliver: SliverToBoxAdapter(child: SectionTitle('Badges', action: 'COMING SOON'))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), sliver: SliverToBoxAdapter(child: Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: const [
        Icon(Icons.workspace_premium_outlined, color: Color(0xFFE8B949), size: 32), SizedBox(width: 14), Expanded(child: Text('Your first badge is waiting. Keep a streak alive to unlock it.', style: TextStyle(color: Colors.white70))),
      ]))))),
    ]);
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.state});
  final AppState state;
  @override
  Widget build(BuildContext context) => Card(color: const Color(0xFF123D2D), child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('LOCK-IN LEVEL', style: TextStyle(color: Colors.white70, letterSpacing: 1.3, fontSize: 12)), SizedBox(height: 5), Text('Momentum over motivation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))]),
      Text('LVL ${state.level}', style: const TextStyle(color: Color(0xFFE8B949), fontSize: 22, fontWeight: FontWeight.w900)),
    ]),
    const SizedBox(height: 20),
    ProgressBar(value: state.levelProgress, color: const Color(0xFFE8B949)),
    const SizedBox(height: 8),
    Text('${state.levelXp} / 250 XP to next level', style: const TextStyle(color: Colors.white70)),
  ])));
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.icon, required this.value, required this.label, required this.color});
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), child: Column(children: [Icon(icon, color: color), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)), const SizedBox(height: 2), Text(label, style: const TextStyle(fontSize: 11, color: Colors.white60))])));
}
