class User {
  final int id;
  final String email;
  final String name;
  final String? photo;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.photo,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      photo: map['photo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'name': name, 'photo': photo};
  }
}
