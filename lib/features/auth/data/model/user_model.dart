class UserModel {
  final String name;
  final String email;
  final String userId;
  final String password;
  final String confirmPass;
  final String? token;
  final DateTime? lastLoginAt;

  UserModel({
    required this.name,
    required this.email,
    required this.userId,
    required this.password,
    required this.confirmPass,
    this.token,
    this.lastLoginAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      userId: json['userId'],
      password: json['password'] ?? '',
      confirmPass: json['confirmPass'] ?? '',
      token: json['token'],
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
    );
  }

  toJson() {
    return {
      'email': email,
      'name': name,
      'userId': userId,
      // 'password': password, // Removed for security
      // 'confirmPass': confirmPass, // Removed for security
      if (token != null) 'token': token,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt!.toIso8601String(),
    };
  }
}
