
class UserModel {
  final String name;
  final String email;
  final String phone;
  final String userId;
  final String department;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    required this.department,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'userId': userId,
    'department': department,
  };
}
