class UserAuthentication {
  UserAuthentication({
    required this.email,
    required this.password,
    this.displayName,

  });

  String email;
  String password;
  String? displayName;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'displayName': displayName,
    };
  }
}
