class Client {
  final int? codClient;
  final String name;
  final String? desc;
  final String? photoPath;
  final int? age;
  final double? height;
  final double? weight;
  final String? gender;
  final int codUser;
  final bool isActive;

  Client({
    this.codClient,
    required this.name,
    this.desc,
    this.photoPath,
    this.age,
    this.height,
    this.weight,
    this.gender,
    required this.codUser,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'codClient': codClient,
      'name': name,
      'desc': desc,
      'photoPath': photoPath,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'codUser': codUser,
      'isActive': isActive ? 1 : 0,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      codClient: map['codClient'],
      name: map['name'],
      desc: map['desc'],
      photoPath: map['photoPath'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      gender: map['gender'],
      codUser: map['codUser'],
      isActive: (map['isActive'] ?? 1) == 1,
    );
  }

  @override
  String toString() {
    return 'Client(codClient: $codClient, name: $name, codUser: $codUser)';
  }
}
