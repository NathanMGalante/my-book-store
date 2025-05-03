class User {
  final int id;
  final String name;
  final String? photo;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.photo,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      photo: map['photo'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'photo': photo, 'role': role};
  }
}
