class Store {
  String? banner;
  final int id;
  String name;
  String slogan;

  Store({
    required this.banner,
    required this.id,
    required this.name,
    required this.slogan,
  });

  Store clone() {
    return Store(banner: banner, id: id, name: name, slogan: slogan);
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      banner: map['banner'],
      id: map['id'],
      name: map['name'],
      slogan: map['slogan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'banner': banner, 'id': id, 'name': name, 'slogan': slogan};
  }
}
