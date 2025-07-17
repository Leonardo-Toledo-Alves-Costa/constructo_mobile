class Usuario {
  final String id;
  final String name;
  final String email;
  final String imageURL;
  String role = 'leitor';

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.imageURL,
    this.role = 'leitor',
  });

  factory Usuario.fromMap(Map<String, dynamic> data) {
    return Usuario(
      id: data['employeeCode'] ?? '',
      name: data['nome'] ?? '',
      email: data['email'] ?? '',
      imageURL: data['imageURL'] ?? '',
      role: data['role'] ?? 'leitor',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeCode': id,
      'nome': name,
      'email': email,
      'imageURL': imageURL,
      'role': role,
    };
  }
}