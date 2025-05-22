enum Role { admin, employee, user }

extension RoleExtension on Role {
  String get value => 'ROLE_${name.toUpperCase()}';
}

extension RoleListExtension on List<Role> {
  Role byValue(String value) {
    for (var role in this) {
      if (role.value == value) return role;
    }
    throw ArgumentError.value(value, "value", "No enum value with that value");
  }
}
