class Period {
  final int? codPeriod;
  final String title;
  final String? objective;
  final int codClient;

  Period({
    this.codPeriod,
    required this.title,
    this.objective,
    required this.codClient,
  });

  Map<String, dynamic> toMap() {
    return {
      'codPeriod': codPeriod,
      'title': title,
      'objective': objective,
      'codClient': codClient,
    };
  }

  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      codPeriod: map['codPeriod'],
      title: map['title'],
      objective: map['objective'],
      codClient: map['codClient'],
    );
  }

  @override
  String toString() {
    return 'Period(codPeriod: $codPeriod, title: $title, codClient: $codClient)';
  }
}
