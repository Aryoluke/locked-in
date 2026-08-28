class Exercise {
  const Exercise(this.name, this.category, this.detail);
  final String name;
  final String category;
  final String detail;
}

const exerciseLibrary = <Exercise>[
  Exercise('Push-ups', 'Calisthenics', 'Chest · shoulders · triceps'),
  Exercise('Pull-ups', 'Calisthenics', 'Back · biceps · grip'),
  Exercise('Bodyweight Squats', 'Calisthenics', 'Quads · glutes · core'),
  Exercise('Plank', 'Calisthenics', 'Core stability'),
  Exercise('Bench Press', 'Gym', 'Chest · shoulders · triceps'),
  Exercise('Barbell Squat', 'Gym', 'Legs · glutes · core'),
  Exercise('Deadlift', 'Gym', 'Posterior chain · grip'),
  Exercise('Dumbbell Row', 'Gym', 'Back · biceps'),
];
