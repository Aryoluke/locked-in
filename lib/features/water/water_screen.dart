import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';
import '../../shared/widgets/app_shell.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final progress = (state.waterMl / 2000).clamp(0.0, 1.0);
    return ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 28), children: [
      Text('WATER', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white60, letterSpacing: 1.4)),
      const SizedBox(height: 5),
      const Text('Fill the tank.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 22),
      Card(color: const Color(0xFF123D2D), child: Padding(padding: const EdgeInsets.all(22), child: Column(children: [
        const Icon(Icons.water_drop, color: Color(0xFF56C7FF), size: 54),
        const SizedBox(height: 12),
        Text('${state.waterMl} ml', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        const Text('of 2,000 ml daily target', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 18),
        ProgressBar(value: progress, color: const Color(0xFF56C7FF)),
        const SizedBox(height: 18),
        Wrap(spacing: 10, runSpacing: 10, alignment: WrapAlignment.center, children: [
          OutlinedButton(onPressed: () => state.addWater(250), child: const Text('+250 ml')),
          OutlinedButton(onPressed: () => state.addWater(500), child: const Text('+500 ml')),
          TextButton(onPressed: state.resetWater, child: const Text('Reset')),
        ]),
      ]))),
      const SizedBox(height: 22),
      const SectionTitle('Why it matters', action: 'MINI TIP'),
      const SizedBox(height: 10),
      const Card(child: ListTile(leading: Icon(Icons.tips_and_updates, color: Color(0xFFE8B949)), title: Text('Make the easy choice'), subtitle: Text('Keep water visible and pair a glass with meals. Hitting the target awards +25 XP.'))),
    ]);
  }
}
