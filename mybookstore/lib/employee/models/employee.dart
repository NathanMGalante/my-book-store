class Employee {
  final int id;
  final String name;
  final String? photo;
  final String username;

  Employee({
    required this.id,
    required this.name,
    required this.photo,
    required this.username,
  });

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      photo: map['photo'],
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'photo': photo, 'username': username};
  }
}
