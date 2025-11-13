class User {
  final String cref;
  final String name;
  final String contact;

  User({
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
      cref: (map['cref'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      contact: (map['contact'] ?? '').toString(),
    );
  }

  @override
  String toString() {
    return 'User(cref: $cref, name: $name, contact: $contact)';
  }
}
