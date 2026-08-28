import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/exercise_library.dart';
import '../../models/workout_log.dart';
import '../../providers/app_state.dart';
import '../../shared/widgets/app_shell.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  Future<void> addWorkout(BuildContext context) async {
    final log = await showDialog<WorkoutLog>(context: context, builder: (_) => const _LogWorkoutDialog());
    if (log != null && context.mounted) {
      context.read<AppState>().logWorkout(log);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Workout logged · +35 XP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 28), children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('TRAIN', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white60, letterSpacing: 1.4)),
          const SizedBox(height: 5),
          const Text('Make the work count.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        ]),
        FloatingActionButton.small(onPressed: () => addWorkout(context), child: const Icon(Icons.add)),
      ]),
      const SizedBox(height: 22),
      FilledButton.icon(onPressed: () => addWorkout(context), icon: const Icon(Icons.edit_note), label: const Padding(padding: EdgeInsets.all(12), child: Text('Log a set'))),
      const SizedBox(height: 28),
      const SectionTitle('Exercise library', action: 'STARTER'),
      const SizedBox(height: 10),
      ...exerciseLibrary.map((exercise) => Card(child: ListTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFF123D2D), child: Icon(exercise.category == 'Gym' ? Icons.fitness_center : Icons.self_improvement, color: const Color(0xFF16C784))),
            title: Text(exercise.name),
            subtitle: Text('${exercise.category} · ${exercise.detail}'),
            trailing: IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => addWorkout(context)),
          ))),
      if (state.workoutLogs.isNotEmpty) ...[
        const SizedBox(height: 20),
        const SectionTitle('Recent logs'),
        const SizedBox(height: 8),
        ...state.workoutLogs.take(5).map((log) => Card(child: ListTile(
              leading: const Icon(Icons.check_circle, color: Color(0xFF16C784)),
              title: Text(log.exercise),
              subtitle: Text('${log.sets} sets × ${log.reps} reps · ${log.weightKg.toStringAsFixed(1)} kg'),
              trailing: Text(DateFormat('d MMM').format(log.date), style: const TextStyle(color: Colors.white60)),
            )))
      ],
    ]);
  }
}

class _LogWorkoutDialog extends StatefulWidget {
  const _LogWorkoutDialog();
  @override
  State<_LogWorkoutDialog> createState() => _LogWorkoutDialogState();
}

class _LogWorkoutDialogState extends State<_LogWorkoutDialog> {
  final sets = TextEditingController(text: '3');
  final reps = TextEditingController(text: '10');
  final weight = TextEditingController(text: '0');
  String exercise = exerciseLibrary.first.name;

  @override
  void dispose() {
    sets.dispose();
    reps.dispose();
    weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Log workout'),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          DropdownButtonFormField<String>(value: exercise, decoration: const InputDecoration(labelText: 'Exercise'), items: exerciseLibrary.map((item) => DropdownMenuItem(value: item.name, child: Text(item.name))).toList(), onChanged: (value) => setState(() => exercise = value ?? exercise)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: TextField(controller: sets, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Sets'))),
            const SizedBox(width: 10),
            Expanded(child: TextField(controller: reps, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Reps'))),
            const SizedBox(width: 10),
            Expanded(child: TextField(controller: weight, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Kg'))),
          ]),
        ])),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, WorkoutLog(date: DateTime.now(), exercise: exercise, sets: int.tryParse(sets.text) ?? 1, reps: int.tryParse(reps.text) ?? 1, weightKg: double.tryParse(weight.text) ?? 0)), child: const Text('Save')),
        ],
      );
}
