class Workout {
  final int? codWorkout;
  final String date;
  final String? notes;
  final int codPeriod;

  Workout({
    this.codWorkout,
    required this.date,
    this.notes,
    required this.codPeriod,
  });

  Map<String, dynamic> toMap() {
    return {
      'codWorkout': codWorkout,
      'date': date,
      'notes': notes,
      'codPeriod': codPeriod,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      codWorkout: map['codWorkout'],
      date: map['date'],
      notes: map['notes'],
      codPeriod: map['codPeriod'],
    );
  }

  @override
  String toString() {
    return 'Workout(codWorkout: $codWorkout, date: $date, codPeriod: $codPeriod)';
  }
}
