class UserModel {
  static UserModel? currentUser;
  final String id;
  final String name;
  final String email;
  final String userId;
  final String? token;
  final DateTime? lastLoginAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userId,
    this.token,
    this.lastLoginAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userId: json['userId'],
      token: json['token'],
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
    );
  }

  toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userId': userId,
      if (token != null) 'token': token,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt!.toIso8601String(),
    };
  }
}
