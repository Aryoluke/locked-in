class GlowUpTrack {
  const GlowUpTrack({required this.id, required this.title, required this.subtitle, required this.progress});
  final String id;
  final String title;
  final String subtitle;
  final double progress;
}

const glowUpTracks = <GlowUpTrack>[
  GlowUpTrack(id: 'normal', title: 'Normal', subtitle: 'Build your baseline', progress: 0.28),
  GlowUpTrack(id: 'gym', title: 'Gym', subtitle: 'Strength and physique', progress: 0.18),
  GlowUpTrack(id: 'mental-brain', title: 'Mental & Brain', subtitle: 'Focus, clarity, confidence', progress: 0.12),
  GlowUpTrack(id: 'physical', title: 'Physical', subtitle: 'Movement, posture, presence', progress: 0.22),
];
