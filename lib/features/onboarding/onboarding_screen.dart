import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_profile.dart';
import '../../providers/app_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final age = TextEditingController(text: '18');
  final height = TextEditingController(text: '175');
  final weight = TextEditingController(text: '70');
  final goals = TextEditingController();
  final equipment = TextEditingController(text: 'Bodyweight');
  String bodyType = 'Hybrid';

  @override
  void dispose() {
    for (final field in [name, age, height, weight, goals, equipment]) field.dispose();
    super.dispose();
  }

  String? requiredValue(String? value) => value == null || value.trim().isEmpty ? 'Required' : null;

  Future<void> finish() async {
    if (!formKey.currentState!.validate()) return;
    await context.read<AppState>().saveProfile(UserProfile(
          name: name.text.trim(),
          age: int.tryParse(age.text) ?? 18,
          heightCm: double.tryParse(height.text) ?? 0,
          weightKg: double.tryParse(weight.text) ?? 0,
          bodyType: bodyType,
          goals: goals.text.trim(),
          equipment: equipment.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('LOCKED IN', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900, color: const Color(0xFF16C784))),
                    const SizedBox(height: 8),
                    Text('Build your baseline. Then show up.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    const Text('Your data stays on this device in the mini version.', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 28),
                    TextFormField(controller: name, validator: requiredValue, decoration: const InputDecoration(labelText: 'What should we call you?')),
                    const SizedBox(height: 14),
                    Row(children: [
                      Expanded(child: TextFormField(controller: age, validator: requiredValue, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Age'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextFormField(controller: height, validator: requiredValue, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Height (cm)'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextFormField(controller: weight, validator: requiredValue, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Weight (kg)'))),
                    ]),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: bodyType,
                      decoration: const InputDecoration(labelText: 'Body type / training mode'),
                      items: const ['Sleeper', 'Bulk', 'Hybrid'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                      onChanged: (value) => setState(() => bodyType = value ?? 'Hybrid'),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(controller: goals, maxLines: 2, decoration: const InputDecoration(labelText: 'Main goals', hintText: 'e.g. get stronger, improve focus')),
                    const SizedBox(height: 14),
                    TextFormField(controller: equipment, maxLines: 2, decoration: const InputDecoration(labelText: 'Equipment available', hintText: 'e.g. pull-up bar, dumbbells, gym')),
                    const SizedBox(height: 28),
                    SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: finish, icon: const Icon(Icons.lock), label: const Padding(padding: EdgeInsets.all(14), child: Text('LOCK IN')))),
                  ]),
                ),
              ),
            ),
          ),
        ),
      );
}
