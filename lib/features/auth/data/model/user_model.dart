class UserModel {
  final String name;
  final String email;
  final String userId;
  final String password;
  final String confirmPass;

  UserModel({
    required this.name,

    required this.email,
    required this.userId,
    required this.password,
    required this.confirmPass,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      userId: json['userId'],
      password: json['password'],
      confirmPass: json['confirmPass'],
    );
  }

  toJson() {
    return {
      'email': email,
      'name': name,
      'userId': userId,
      'password': password,
      'confirmPass': confirmPass,
    };
  }
}
