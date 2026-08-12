

class RegisterEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime birthday;
  final String gender;
  final int age;
  final bool confrimEmail;

  RegisterEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.age,
    required this.confrimEmail,
  });
}