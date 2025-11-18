class User {
  final int? codUser;
  final String cref;
  final String name;
  final String contact;

  User({
    this.codUser,
    required this.cref,
    required this.name,
    required this.contact,
  });

  // Converte o objeto User em um mapa (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'cref': cref,
      'name': name,
      'contact': contact,
    };
  }

  // Cria um objeto User a partir de um mapa (para ler do banco)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      codUser: map['codUser'] as int?,
      cref: (map['cref'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      contact: (map['contact'] ?? '').toString(),
    );
  }

  @override
  String toString() {
    return 'User(codUser: $codUser, cref: $cref, name: $name, contact: $contact)';
  }

  // Cria uma cópia do User com valores atualizados (útil para edições)
  User copyWith({
    int? codUser,
    String? cref,
    String? name,
    String? contact,
  }) {
    return User(
      codUser: codUser ?? this.codUser,
      cref: cref ?? this.cref,
      name: name ?? this.name,
      contact: contact ?? this.contact,
    );
  }
}
