import 'package:flutter/material.dart';

import '../../data/glow_up_tracks.dart';
import '../../shared/widgets/app_shell.dart';

class GlowUpScreen extends StatelessWidget {
  const GlowUpScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 28), children: [
        Text('GLOW-UP TRACKS', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white60, letterSpacing: 1.4)),
        const SizedBox(height: 5),
        const Text('Choose your lane.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('These are roadmap stubs in the MINI version. Your consistency will power the full programs.', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 22),
        ...glowUpTracks.map((track) => Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(track.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)), Text('${(track.progress * 100).round()}%', style: const TextStyle(color: Color(0xFFE8B949), fontWeight: FontWeight.w800))]),
              const SizedBox(height: 6),
              Text(track.subtitle, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 14),
              ProgressBar(value: track.progress),
              const SizedBox(height: 12),
              const Row(children: [Icon(Icons.construction_outlined, size: 16, color: Colors.white54), SizedBox(width: 6), Text('Program builder coming soon', style: TextStyle(color: Colors.white54, fontSize: 12))]),
            ])))),
        const SizedBox(height: 8),
        const Card(child: ListTile(leading: Icon(Icons.auto_awesome, color: Color(0xFFE8B949)), title: Text('Badges are on the roadmap'), subtitle: Text('The first achievement engine will reward consistency across every track.'))),
      ]);
}
