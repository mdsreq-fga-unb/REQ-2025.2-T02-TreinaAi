class Exercise {
  final int? codExercise;
  final String name;
  final int? sets;
  final int? reps;
  final double? weight;
  final int codWorkout;

  Exercise({
    this.codExercise,
    required this.name,
    this.sets,
    this.reps,
    this.weight,
    required this.codWorkout,
  });

  Map<String, dynamic> toMap() {
    return {
      'codExercise': codExercise,
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'codWorkout': codWorkout,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      codExercise: map['codExercise'],
      name: map['name'],
      sets: map['sets'],
      reps: map['reps'],
      weight: map['weight'],
      codWorkout: map['codWorkout'],
    );
  }

  @override
  String toString() {
    return 'Exercise(codExercise: $codExercise, name: $name, codWorkout: $codWorkout)';
  }
}
