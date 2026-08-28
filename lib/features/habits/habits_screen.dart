import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/habits.dart';
import '../../providers/app_state.dart';
import '../../shared/widgets/app_shell.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final done = starterHabits.where((habit) => state.completedHabits[habit.id] == true).length;
    return ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 28), children: [
      Text('HABITS', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white60, letterSpacing: 1.4)),
      const SizedBox(height: 5),
      const Text('Small wins. Every day.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 20),
      Card(color: const Color(0xFF123D2D), child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
        const Icon(Icons.check_circle, color: Color(0xFFE8B949), size: 36),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Today’s consistency', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text('$done / ${starterHabits.length} habits closed', style: const TextStyle(color: Colors.white70))])),
      ]))),
      const SizedBox(height: 24),
      const SectionTitle('Starter habits', action: '+ XP EACH'),
      const SizedBox(height: 10),
      ...starterHabits.map((habit) {
        final checked = state.completedHabits[habit.id] == true;
        return Card(child: CheckboxListTile(
          value: checked,
          onChanged: (_) => state.toggleHabit(habit.id, habit.xp),
          secondary: Text(habit.icon, style: const TextStyle(fontSize: 24)),
          title: Text(habit.title, style: TextStyle(fontWeight: FontWeight.w700, decoration: checked ? TextDecoration.lineThrough : null)),
          subtitle: Text('${habit.subtitle} · +${habit.xp} XP'),
          activeColor: const Color(0xFF16C784),
          controlAffinity: ListTileControlAffinity.trailing,
        ));
      }),
    ]);
  }
}
