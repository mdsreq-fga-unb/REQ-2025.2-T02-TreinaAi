class Period {
  final int? codPeriod;
  final String title;
  final String? objective;
  final String? observations;
  final String? worksheetPath;
  final bool isClosed;
  final int codClient;

  Period({
    this.codPeriod,
    required this.title,
    this.objective,
    this.observations,
    this.worksheetPath,
    this.isClosed = false,
    required this.codClient,
  });

  Map<String, dynamic> toMap() {
    return {
      'codPeriod': codPeriod,
      'title': title,
      'objective': objective,
      'observations': observations,
      'worksheetPath': worksheetPath,
      'isClosed': isClosed ? 1 : 0,
      'codClient': codClient,
    };
  }

  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      codPeriod: map['codPeriod'],
      title: map['title'],
      objective: map['objective'],
      observations: map['observations'],
      worksheetPath: map['worksheetPath'],
      isClosed: (map['isClosed'] ?? 0) == 1,
      codClient: map['codClient'],
    );
  }

  @override
  String toString() {
    return 'Period(codPeriod: $codPeriod, title: $title, codClient: $codClient)';
  }
}
