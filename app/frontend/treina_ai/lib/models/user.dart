class User {
  final String cref;
  final String name;
  final String contato;

  User({
    required this.cref,
    required this.name,
    required this.contato,
  });

  // Converte o objeto User em um mapa (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'cref': cref,
      'name': name,
      'contato': contato,
    };
  }

  // Cria um objeto User a partir de um mapa (para ler do banco)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      cref: map['cref'],
      name: map['name'],
      contato: map['contato'],
    );
  }

  @override
  String toString() {
    return 'User(cref: $cref, name: $name, contato: $contato)';
  }
}
